jit.on()

package.path = package.path .. ";" .. table.concat({
  "?.luac", "?/init.luac",
  "?.lua", "?/init.lua",
  "bm/vendor/?.luac", "bm/vendor/?/init.luac",
  "bm/vendor/?.lua", "bm/vendor/?/init.lua"
}, ";")

if raylua.loadfile then
	package.loaders[3] = function(name)
  	for path in package.path:gmatch "([^;]+);?" do
      name = name:gsub("%.", "/")
      path = path:gsub("?", name)

      local content, err = raylua.loadfile(path)
      if content then
      	local tmp = os.getenv("TMP") or os.getenv("TMP")
    end
  end
end

if arg[0]:match("raylua_s$") then
	local arg0 = table.remove(arg, 1)
	arg[0] = arg0
end

local ffi = require("ffi")

local prog
local argv = {}

if #arg > 0 then
	prog = table.remove(arg, 1)
end

for _, v in ipairs(arg) do
	argv[#argv+1] = v
end

require(ffi.string(rl.GetFileName(arg[0])):match("^gbakemono") and "bm.gui_init" or "bm.init")(prog, argv)
