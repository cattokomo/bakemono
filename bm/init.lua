local fs = require("bm.utils.fs")
local moonscript = require("moonscript.base")

return function(prog, argv)
	if not prog then
		require("bm.nogame")
	else
		local f
		if rl.FileExists(fs.join(prog, "main.moon")) then
    	f = assert(moonscript.loadfile(fs.join(prog, "main.moon")))
    elseif rl.FileExists(fs.join(prog, "main.lua")) then
    	f = assert(loadfile(fs.join(prog, "main.lua")))
    end

  	do
  		local arg = argv
  		local package = package
  		package.path = "./?.lua;./?/init.lua"
  		moonscript.insert_loader()
  		f() --[[ TODO: Handle game script ]]
  	end
  end
end
