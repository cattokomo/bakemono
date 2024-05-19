--[[
--   TODO: Add `bm` API to script
--]]

local fs = require("bm.utils.fs")
local moon = require("moon")
local moonscript = require("moonscript.base")
local tabler = require("bm.utils.tabler")

return function(prog, argv)
	local moon_mode = false
	local f
	if rl.FileExists(fs.join(prog, "main.moon")) then
		moon_mode = true
		f = assert(moonscript.loadfile(fs.join(prog, "main.moon")))
	elseif rl.FileExists(fs.join(prog, "main.lua")) then
		f = assert(loadfile(fs.join(prog, "main.lua")))
	else
		require("bm.nogame")
		os.exit(true, true)
	end

	local env = tabler.merge({}, _G)
	env.rl = false
	env.raylua = false
	env.package = tabler.merge({}, package)
	env.package.preload = {}
	env.package.loaded = {}
	env.package.path = table.concat({ fs.join(".", "?.lua"), fs.join(".", "?", "init.lua") })
	if moon_mode then
		env.package.moonpath = moonscript.create_moonpath(env.package.path)
		table.insert(env.package.loaders, 2, moonscript.moon_loader)

		for k, v in pairs(moon) do
			env[k] = v
		end
	end
	env.arg = argv
	setfenv(f, setmetatable({}, { __index = env }))
	f()
end
