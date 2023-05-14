import pyautogui
import time


def exit_fullscreen():
    # Add a short delay to ensure the script has focus
    time.sleep(1)

    # Exit iTerm2 full screen mode
    pyautogui.hotkey("command", "enter")


if __name__ == "__main__":
    exit_fullscreen()
