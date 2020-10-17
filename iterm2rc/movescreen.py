#!/usr/bin/env python3.7

import iterm2
import objc
from AppKit import *
# To install packages from PyPI, use this command, changing package_name to the package you
# wish to install:
#   "~/Library/ApplicationSupport/iTerm2/Scripts/movescreen/iterm2env/versions/3.7.2/bin/pip3" install package_name


async def main(connection):
    app = await iterm2.async_get_app(connection)

    def screenFrames():
        return list(map(lambda screen: screen.frame(), NSScreen.screens()))

    def intersection(f1, f2):
        origin = iterm2.Point(max(f1.origin.x, f2.origin.x), max(f1.origin.y, f2.origin.y))
        limit = iterm2.Point(min(f1.origin.x + f1.size.width, f2.origin.x + f2.size.width),
                             min(f1.origin.y + f1.size.height, f2.origin.y + f2.size.height))
        size = iterm2.Size(max(0, limit.x - origin.x),
                           max(0, limit.y - origin.y))
        return iterm2.Frame(origin, size)

    def intersectionArea(f1, f2):
        i = intersection(f1, f2)
        return i.size.width * i.size.height

    def indexOfScreenWithFrame(frame):
        frames = screenFrames()
        bestArea = 0
        bestScreen = 0
        i = 0
        print("Trying to figure out the screen with window frame {}".format(str(frame)))
        for screenFrame in screenFrames():
            area = intersectionArea(screenFrame, frame)
            if area > bestArea:
                print("Screen {} looks good. Area overlap is {}. Its frame is {}".format(i, area, screenFrame))
                bestScreen = i
                bestArea = area
            i += 1
        print("Conclusion: the screen with frame {} is {}".format(frame, bestScreen))
        return bestScreen

    async def firstWindowOnScreen(i):
        screenFrame = NSScreen.screens()[i].frame()
        print("Looking for windows on screen {} with frame {}".format(i, screenFrame))
        for window in app.terminal_windows:
            frame = window.frame
            windowArea = frame.size.width * frame.size.height
            if intersectionArea(frame, screenFrame) > windowArea * 0.5:
                print("YES: Window {} is mostly on that screen".format(window))
                return window
            print("NO: Window {} is not mostly on that screen".format(window))
        return None

    async def move_current_tab_by_n_screens(delta):
        tab_to_move = app.current_terminal_window.current_tab
        window_with_tab_to_move = app.get_window_for_tab(tab_to_move.tab_id)
        i = app.terminal_windows.index(window_with_tab_to_move)
        print("Window has index {}".format(i))
        n = len(app.terminal_windows)
        j = (i + delta) % n
        print("Will move to {}".format(j))

        currentScreenIndex = indexOfScreenWithFrame(await window_with_tab_to_move.async_get_frame())
        numberOfScreens = len(NSScreen.screens())
        desiredScreenIndex = (currentScreenIndex + delta) % numberOfScreens

        print("Want to move from screen {} to screen {}".format(currentScreenIndex, desiredScreenIndex))

        if currentScreenIndex == desiredScreenIndex:
            print("Already there, I guess there is only one screen")
            return

        windowAlreadyOnDesiredScreen = await firstWindowOnScreen(desiredScreenIndex)
        if (windowAlreadyOnDesiredScreen):
            print("There is already a window on that screen. Adding the tab to it")
            tabs = windowAlreadyOnDesiredScreen.tabs + [tab_to_move]
            await windowAlreadyOnDesiredScreen.async_set_tabs(windowAlreadyOnDesiredScreen.tabs + [tab_to_move])
            return

        print("No window is on the desired screen. Create a new one")
        window = await tab_to_move.async_move_to_window()
        await window.async_set_fullscreen(False)
        nsframe = NSScreen.screens()[desiredScreenIndex].frame()
        frame = iterm2.Frame(
                iterm2.Point(nsframe.origin.x, nsframe.origin.y),
                iterm2.Size(nsframe.size.width, nsframe.size.height))
        await window.async_set_frame(frame)
        await window.async_set_fullscreen(True)

    @iterm2.RPC
    async def move_current_tab_to_next_screen():
        await move_current_tab_by_n_screens(1)
    await move_current_tab_to_next_screen.async_register(connection)

    @iterm2.RPC
    async def move_current_tab_to_previous_screen():
        n = len(NSScreen.screens())
        if n > 0:
            await move_current_tab_by_n_screens(n - 1)
    await move_current_tab_to_previous_screen.async_register(connection)

iterm2.run_forever(main)
