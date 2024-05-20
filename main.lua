jit.on()

package.path = package.path
	.. ";"
	.. table.concat({
		"?.luac",
		"?/init.luac",
		"?.lua",
		"?/init.lua",
		"bm/vendor/?.luac",
		"bm/vendor/?/init.luac",
		"bm/vendor/?.lua",
		"bm/vendor/?/init.lua",
	}, ";")

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

require("lulpeg"):register()

if arg[0]:match("raylua_s$") then
	local arg0 = table.remove(arg, 1)
	arg[0] = arg0
end

local ffi = require("ffi")

local prog = "."
local argv = {}

if #arg > 0 then
	prog = table.remove(arg, 1)
end

for _, v in ipairs(arg) do
	argv[#argv + 1] = v
end

require(ffi.string(rl.GetFileName(arg[0])):match("^gbakemono") and "bm.gui_init" or "bm.init")(prog, argv)
