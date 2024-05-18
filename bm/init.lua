local screenWidth, screenHeight = 800, 450

return function(prog, argv)
	rl.InitWindow(screenWidth, screenHeight, "Bakemono [Blep!]")
	rl.SetTargetFPS(60)

	local text = "Blep!"
	local i = 0
	while not rl.WindowShouldClose() do
		do rl.BeginDrawing()
		  rl.ClearBackground(rl.WHITE)
	  	rl.DrawText(text:sub(1, i),screenWidth/2-i-25, screenHeight/2, 20, rl.SKYBLUE)
		 	rl.WaitTime(.25)
		 	i = i + 1
		 	if i > #text then
		 		i = 0
		 	end
		rl.EndDrawing() end
	end

	rl.CloseWindow()
end
