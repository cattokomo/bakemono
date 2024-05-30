--[[
--   TODO: Add `bm` API to script
--]]

local fs = require("bm.utils.fs")
local errors = require("bm.errors")
local moonscript = require("moonscript.base")

return function(prog, argv)
	if not rl.FileExists(fs.join(prog, "main.moon")) then
		rl.TraceLog(rl.LOG_INFO, "%s", "Can't find game script, running nogame...")
		require("bm.nogame")
		os.exit(true, true)
	end

	local script = fs.join(prog, "main.moon")
	local f, err = moonscript.loadfile(fs.join(prog, "main.moon"))

	if not f and err then
  	errors.error_moon_loadfile(err)
  end

  local env = {
  	config = {}
  }
	for k, v in pairs(require("bm.script_api")) do
  	env[k] = v
  end

	---@cast f function
	setfenv(f, env)

	local traceback
  local ok, entry = xpcall(f, function(_err)
  	err = _err
  	traceback = debug.traceback("", 2)
  end)

  if not ok and entry then
  	errors.error_moon(err, traceback)
  end

  env = getfenv(f)
  local config = env.config
	local start_entry = function() end

	for k, v in pairs(entry) do
		setfenv(v, env)
  	if k.type == "label" and k.name == "start" then
    	start_entry = v
    end
  end

  rl.InitWindow(config.screen_width, config.screen_height, config.window_title)
	rl.SetTargetFPS(60)

	while not rl.WindowShouldClose() do
		rl.BeginDrawing()
		start_entry()
    rl.EndDrawing()
  end

	rl.CloseWindow()
end
