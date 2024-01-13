# 使用osascript运行AppleScript并捕获输出
read x y width height <<< $(osascript -e 'tell application "Google Chrome" to get bounds of first window whose title contains "daily"')

# 计算窗口的宽度和高度
width=$(($width - $x))
height=$(($height - $y))

# 使用screencapture进行截图
screencapture -R"$x,$y,$width,$height" screenshot.png
