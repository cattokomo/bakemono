local ffi = require("ffi")

local screenWidth = 800
local screenHeight = 450

local colors = {
	rl.LIME,
	rl.SKYBLUE,
}

local svg_icon = rl.LoadImageSvg("bm/assets/icon.svg", 256, 256)
local win_icon = rl.LoadImage("bm/assets/48.png")

rl.InitWindow(screenWidth, screenHeight, "Bakemono (Blep!)")
rl.SetTargetFPS(60)
rl.SetWindowIcon(win_icon)

local i = 1
while not rl.WindowShouldClose() do
	do
		rl.BeginDrawing()
		rl.ClearBackground(rl.RAYWHITE)
		rl.DrawText("Blep!", screenWidth / 2 - 20, screenHeight / 2 - 10, 20, colors[i])
		rl.WaitTime(0.25)
	end
	rl.EndDrawing()
	i = i + 1
	if i > #colors then
		i = 1
	end
end

rl.CloseWindow()

rl.UnloadImage(svg_icon)
rl.UnloadImage(win_icon)
