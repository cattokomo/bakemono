local ffi = require("ffi")

ffi.cdef([[
  struct raymob_bind_entry {
    const char *name;
    const char *proto;
    void *ptr;
  };
]])

--[[ TODO: Workaround to detect Android platform ]]
if jit.os == "Other" then
	local raymob = {}
	local entries = ffi.cast("struct raymob_bind_entry *", require("bm.extra.raymob").bind_entries)

	local i = ffi.new("size_t", 0)
	local NULL = ffi.new("void *", nil)

	print("RAYMOB: Loading FFI binding entries.")

	while entries[i].name ~= NULL do
		local name, proto = ffi.string(entries[i].name), ffi.string(entries[i].proto)

		if raymob[name] then
			print("RAYMOB: Warn: Duplicated FFI entry : " .. name)
		end

		raymob[name] = ffi.cast(proto, entries[i].ptr)
		i = i + 1
	end

	print("RAYMOB: Loaded " .. tonumber(i) .. " FFI entries.")
	return raymob
end

return false
