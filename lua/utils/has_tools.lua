local open_package_json = require "utils.open_package_json"

local function has_dependency(dep)
  local content = open_package_json()
  if not content then
    return false
  end
  local ok, package = pcall(vim.fn.json_decode, content)
  if not ok then
    return false
  end
  if package.devDependencies and package.devDependencies[dep] then
    return true
  end
  return false
end

local function has_stylelint()
  return has_dependency "stylelint"
end

local function has_prettier()
  return has_dependency "prettier"
end

local function has_eslint()
  return has_dependency "eslint"
end

return {
  has_stylelint = has_stylelint,
  has_prettier = has_prettier,
  has_eslint = has_eslint,
}
