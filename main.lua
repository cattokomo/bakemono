package.path = package.path .. ";" .. table.concat({
  "src/?.lua",
  "src/vendor/?.lua", "./src/vendor/?/init.lua"
}, ";")

if arg[0]:match("raylua_s$") then
	local arg0 = table.remove(arg, 1)
	arg[0] = arg0
end

local prog
local argv = {}

if #arg == 0 then
	io.stderr:write(arg[0].." <directory/zipfile> [args...]\n")
	io.stderr:write("A Visual Novel engine on top of Raylib\n")
	io.stderr:flush()
	os.exit(1)
end

if #arg > 0 then
	prog = table.remove(arg, 1)
end

for _, v in ipairs(arg) do
	argv[#argv+1] = v
end

require(rl.GetFileName(arg[0]):match("^gbakemono") and "bm.gui_init" or "bm.init")(prog, argv)
