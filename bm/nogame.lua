local screenWidth = 800
local screenHeight = 450

local colors = {
	rl.LIME,
	rl.SKYBLUE,
}

rl.InitWindow(screenWidth, screenHeight, "Bakemono (Blep!)")
rl.SetTargetFPS(60)

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
