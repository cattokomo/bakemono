local ffi = require("ffi")
local raymob = require("bm.raymob")

ffi.cdef([[
  void free(void*);
]])

local C = ffi.C

local fs = {}

function fs.join(path1, path2, ...) return table.concat({ path1, path2, ... }, package.config:sub(1, 1)) end

function fs.dirname(path) return path:match("^(.*)/.-") end

function fs.basename(path) return path:match("^.*/(.-)") end

function fs.filename(path) return fs.basename(path):match("^(.*)%..-") end

function fs.tmpdir()
	if jit.os == "Other" then
		local cstr = raymob.GetCacheDir()
		local tmpdir = ffi.string(cstr)
		C.free(cstr)
		return tmpdir
	else
		return fs.dirname(os.tmpname())
	end
end

return fs
