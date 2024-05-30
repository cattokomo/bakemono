local tabler = {}

function tabler.merge(t1, t2)
	for k, v in pairs(t2) do
		t1[k] = v
	end
	return t1
end

function tabler.map(t, f)
	for k, v in pairs(t) do
  	t[k] = f(v) or v
  end
  return t
end

return tabler
