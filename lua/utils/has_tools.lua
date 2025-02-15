local uv = vim.loop

local function file_exists(path)
  return uv.fs_stat(path) ~= nil
end

local function get_cwd()
  return vim.fn.getcwd()
end

local function has_dependency(dep)
  local cwd = get_cwd()
  local package_json_path = cwd .. "/package.json"
  if not file_exists(package_json_path) then
    return false
  end
  local file = io.open(package_json_path, "r")
  if not file then
    return false
  end
  local content = file:read "*a"
  file:close()
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
