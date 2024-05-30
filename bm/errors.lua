local errors = {}

function errors.error_moon(err, traceback)
	error({ moon = true, executed = true, err, traceback }, 2)
end

function errors.error_moon_loadfile(err)
	error({ moon = true, err }, 2)
end

return errors
