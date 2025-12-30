---@param t1 table | string
---@param t2 table | string
---@param array? boolean
local merge_tables = function(t1, t2, array)
  if array then
    local result = {}
    if type(t1) == "table" then
      for _, line in ipairs(t1) do
        table.insert(result, line)
      end
    else
      table.insert(result, t1)
    end
    if type(t2) == "table" then
      for _, line in ipairs(t2) do
        table.insert(result, line)
      end
    else
      table.insert(result, t2)
    end
    return result
  end

  if (type(t1) == "table") and (type(t2) == "table") then
    local result = {}
    for k, v in pairs(t1) do
      result[k] = v
    end
    for k, v in pairs(t2) do
      result[k] = v
    end
    return result
  end
end

return merge_tables
