local function list_by_condition(tbl)
  local result = {}
  for key, value in pairs(tbl) do
    if value == true then
      table.insert(result, key)
    end
  end
  return result
end

return list_by_condition
