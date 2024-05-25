--[[
--   TODO: Add `bm` API to script
--]]

local fs = require("bm.utils.fs")
local moon = require("moon")
local moonscript = require("moonscript.base")
local tabler = require("bm.utils.tabler")

local function loadfile_any(path)
	if rl.FileExists(path..".moon") then
  	return moonscript.loadfile(path..".moon")
  else
  	return loadfile(path..".lua")
  end
end

return function(prog, argv)
	local moon_mode = false
	if rl.FileExists(fs.join(prog, "main.moon")) then
		moon_mode = true
	elseif not rl.FileExists(fs.join(prog, "main.lua")) then
		rl.TraceLog(rl.LOG_INFO, "%s", "Can't find any game script, running nogame...")
		require("bm.nogame")
		os.exit(true, true)
	end
	local f = assert(loadfile_any(fs.join(prog, "main")))

	local env = tabler.merge({}, _G)
	env.rl = false
	env.raylua = false
	env.config = {}
	env.package = tabler.merge({}, package)
	env.package.preload = {}
	env.package.loaded = {}
	env.package.path = table.concat({ "./?.lua", "./?/init.lua", "./game/?.lua", "./game/?/init.lua" }):gsub("/", package.config:sub(1, 1))
	if moon_mode then
		env.package.moonpath = moonscript.create_moonpath(env.package.path)
		table.insert(env.package.loaders, 2, moonscript.moon_loader)

		for k, v in pairs(moon) do
			env[k] = v
		end
	end
	env.arg = argv
	setfenv(f, env)

	f()

	-- do
 --  	assert(f())
	-- 	env = getfenv(f)

 --  end
end
