jit.on()

do
	local sep_path = package.config:sub(1, 1)

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

require("lulpeg"):register()

if arg[0]:match("raylua_s$") then
	local arg0 = table.remove(arg, 1)
	arg[0] = arg0
end

local ffi = require("ffi")
local fs = require("bm.utils.fs")
local errors = require("moonscript.errors")
local util = require("moonscript.util")

local prog = "."
local argv = {}

if #arg > 0 then
	prog = table.remove(arg, 1)
end

for _, v in ipairs(arg) do
	argv[#argv + 1] = v
end

xpcall(function()
	require(ffi.string(rl.GetFileName(arg[0])):match("^gbakemono") and "bm.gui_init" or "bm.init")(
		fs.join(prog, "game"),
		argv
	)
end, function(err)
		if type(err) == "table" and err.moon then
			err = err[1]
		elseif type(err) == "table" and err.moon and err.execute then
			local truncated = errors.truncate_traceback(util.trim(err[2]))
			local rewritten = errors.rewrite_traceback(truncated, err[1])

			if rewritten then
				err = rewritten
			else
				err = err[1] .. "\n" .. util.trim(err[2])
			end
		else
	    err = debug.traceback(err, 2)
    end

		if type(err) ~= "string" then
    	err = "error message is a "..type(err)
    end

		io.stderr:write("== ERROR WHILE RUNNING BAKEMONO ======================================\n")
		io.stderr:write(err)
		io.stderr:write("\n======================================================================\n")
		io.stderr:flush()

		if not rl.IsWindowReady() then
			rl.InitWindow(800, 450, "Bakemono: Error")
		end

		while not rl.WindowShouldClose() do
			do
				rl.BeginDrawing()
    		rl.ClearBackground(rl.RAYWHITE)
    		rl.DrawTextEx(rl.GetFontDefault(), err, { 2, 1 }, 15, 2, rl.BLACK)
    		rl.EndDrawing()
    	end
    end

    rl.CloseWindow()
    os.exit(false)
end)
