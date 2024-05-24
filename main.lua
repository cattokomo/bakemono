jit.on()

do
	local sep_path = package.config:sub(1, 1)
	local dll_ext = "so"
	if jit.os == "Windows" then
		dll_ext = "dll"
	elseif jit.os == "OSX" then
		dll_ext = "dylib"
	end

	package.path = package.path
		.. ";"
		.. table
			.concat({
				"?.luac",
				"?/init.luac",
				"?.lua",
				"?/init.lua",
				"bm/vendor/?.luac",
				"bm/vendor/?/init.luac",
				"bm/vendor/?.lua",
				"bm/vendor/?/init.lua",
			}, ";")
			:gsub("/", sep_path)

	package.cpath = package.cpath
		.. ";"
		.. table
			.concat({
				"?." .. dll_ext,
				"bm/vendor/?." .. dll_ext,
			}, ";")
			:gsub("/", sep_path)

	-- package.loaders[3] = function(name)
	-- 	local fs = require("bm.utils.fs")
	-- 	for path in package.path:gmatch("([^;]+);?") do
	-- 		name = name:gsub("%.", "/")
	-- 		path = path:gsub("?", name)

	-- 		local content = raylua.loadfile(path)
	-- 		if content then
	-- 			local fname = fs.join(fs.tmpdir(), name .. "." .. dll_ext)
	-- 			print(fname)
	-- 			local f = assert(io.open(fname, "wb"))
	-- 			f:write(content)
	-- 			f:close()
	-- 			return package.loadlib(fname, "luaopen_" .. fs.filename(fname):gsub("%W", "_"))
	-- 		end
	-- 	end
	-- end

	if not raylua.loadfile then
		function raylua.loadfile(path)
			local f, err = io.open(path, "rb")
			if not f and err then
				return false, err
			end
			local content = f:read("*a")
			f:close()
			return content
		end
	end
end

print(package.loaded.luv)
require("lulpeg"):register()

if arg[0]:match("raylua_s$") then
	local arg0 = table.remove(arg, 1)
	arg[0] = arg0
end

local ffi = require("ffi")
local fs = require("bm.utils.fs")

local prog = "."
local argv = {}

if #arg > 0 then
	prog = table.remove(arg, 1)
end

for _, v in ipairs(arg) do
	argv[#argv + 1] = v
end

require(ffi.string(rl.GetFileName(arg[0])):match("^gbakemono") and "bm.gui_init" or "bm.init")(
	fs.join(prog, "game"),
	argv
)
