local fs = {}

function fs.join(path1, path2, ...)
	return table.concat({path1, path2, ...}, package.config:sub(1, 1))
end

return fs
