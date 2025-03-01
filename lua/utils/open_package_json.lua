local uv = vim.loop

local function file_exists(path)
  return uv.fs_stat(path) ~= nil
end

local function get_cwd()
  return vim.fn.getcwd()
end

local function open_package_json()
  local cwd = get_cwd()
  local package_json_path = cwd .. "/package.json"
  if not file_exists(package_json_path) then
    return nil
  end
  local file = io.open(package_json_path, "r")
  if not file then
    return nil
  end
  local content = file:read "*a"
  file:close()
  return content
end

return open_package_json
