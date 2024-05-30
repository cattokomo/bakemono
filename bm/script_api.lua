local tabler = require("bm.utils.tabler")
local rl = rl

local script_api = {}

function script_api.label(label)
  return { type = "label", name = label }
end

function script_api.menu(choices)
  if not getmetatable(_G).is_in_label then
  	error("Trying to run label-only function outside a label")
  end

  local sorted_choices = {}
  for choice, block in pairs(choices) do
  	sorted_choices[#sorted_choices+1] = {choice, block}
  end

  --[[ TODO: Improve this function ]]
  table.sort(sorted_choices, function(a, b)
    ---@type string
  	a, b = a[1], b[1]
  	local a_num, b_num = a:match("^(%-?%d-);"), b:match("^(%-?%d-);")

  	if b_num and not a_num then
    	return true
    elseif a_num and b_num then
      return false
    end

    if a_num and b_num then
      return tonumber(b_num) < tonumber(a_num)
    end

    return false
  end)

  tabler.map(sorted_choices, function(t)
  	return { t[1]:gsub("^%-?%d-;", ""), t[2] }
  end)


end

return script_api
