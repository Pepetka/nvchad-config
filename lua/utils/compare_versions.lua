local open_package_json = require "utils.open_package_json"

local function compare_versions(installed, required)
  local function split_version(version)
    local parts = {}
    for num in version:gmatch "%d+" do
      table.insert(parts, tonumber(num))
    end
    return parts
  end

  local installed_parts = split_version(installed)
  local required_parts = split_version(required)

  for i = 1, math.max(#installed_parts, #required_parts) do
    local inst = installed_parts[i] or 0
    local req = required_parts[i] or 0

    if inst > req then
      return true
    elseif inst < req then
      return false
    end
  end

  return true
end

local function check_typescript(required_version)
  local content = open_package_json()
  if not content then
    return false
  end
  local ok, package = pcall(vim.fn.json_decode, content)
  if not ok then
    return false
  end

  local installed_version = package.devDependencies and package.devDependencies.typescript
  if not installed_version then
    return false
  end
  installed_version = installed_version:match "[%d%.]+"
  if not installed_version then
    return false
  end
  if compare_versions(installed_version, required_version) then
    return true
  else
    return false
  end
end

return check_typescript
