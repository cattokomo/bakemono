--[[
--   TODO: Add `bm` API to script
--]]

local fs = require("bm.utils.fs")
local moon = require("moon")
local moonscript = require("moonscript.base")
local tabler = require("bm.utils.tabler")

return function(prog, argv)
	if not rl.FileExists(fs.join(prog, "main.moon")) then
		rl.TraceLog(rl.LOG_INFO, "%s", "Can't find game script, running nogame...")
		require("bm.nogame")
		os.exit(true, true)
	end
	local f, err = moonscript.loadfile(fs.join(prog, "main.moon"))
	print("a")
	if not f and err then
  	error({
  		moon = true,
  		err
  	})
  end

	---@cast f function
	setfenv(f, { arg = argv })
  local ok, entry = pcall(f)
  if not ok and entry then
  	error({
  		moon = true,
  		err
  	})
  end
end
