local ffi = require("ffi")

local screen_width = 800
local screen_height = 450

-- local svg_icon = rl.LoadImageSvg(raylua.loadfile("bm/assets/icon.svg").."\0", 256, 256) -- see raysan5/raylib#3854
local svg_icon = rl.LoadImage("bm/assets/icon.png")
local win_icon = rl.LoadImage("bm/assets/64.png")

rl.InitWindow(screen_width, screen_height, "Bakemono (Blep!)")
rl.SetTargetFPS(60)
rl.SetWindowIcon(win_icon)

local icon_texture = rl.LoadTextureFromImage(svg_icon)

rl.UnloadImage(svg_icon)
rl.UnloadImage(win_icon)

local txt = "no game TwT"
local txt_size = 40
while not rl.WindowShouldClose() do
	do
		rl.BeginDrawing()
		rl.ClearBackground(rl.RAYWHITE)
		rl.DrawTexture(
			icon_texture,
			screen_width / 2 - icon_texture.width / 2,
			screen_height / 2 - icon_texture.height / 2 - 60,
			rl.BLACK
		)
		rl.DrawText(
			txt,
			screen_width / 2 - rl.MeasureText(txt, txt_size) / 2,
			screen_height / 2 + 40,
			txt_size,
			rl.DARKGRAY
		)
	end
	rl.EndDrawing()
end

rl.UnloadTexture(icon_texture)

rl.CloseWindow()
