local function remove_if(condition, list, value_to_remove)
  if not condition then
    return list
  end

  local new_list = {}

  for _, v in ipairs(list) do
    if v ~= value_to_remove then
      table.insert(new_list, v)
    end
  end

  for i, v in ipairs(list) do
    if type(i) ~= "number" then
      new_list[i] = v
    end
  end

  return new_list
end

return remove_if
