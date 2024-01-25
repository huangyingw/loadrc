# 使用osascript运行AppleScript并捕获输出
window_bounds=$(osascript -e 'tell application "Google Chrome" to get bounds of first window whose title contains "daily"')

# 将输出分解为单独的变量
read -r x y width height <<< $(echo $window_bounds | tr -d ',')

# 计算窗口的实际宽度和高度
width=$(($width - $x))
height=$(($height - $y))

# 使用screencapture进行截图
screencapture -R"$x,$y,$width,$height" screenshot.png
