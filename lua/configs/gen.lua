local options = {
  model = "gpt-4o-mini",
  host = "https://api.openai.com",
  command = function(options)
    local body = { model = options.model, stream = true }
    return "curl --silent --no-buffer -X POST "
      .. options.host
      .. "/v1/chat/completions -d $body"
      .. " -H 'Content-Type: application/json'"
      .. " -H 'Authorization: Bearer "
      .. os.getenv "OPENAI_API_KEY"
      .. "'"
      .. " --proxy socks5h://127.0.0.1:1086"
  end,
  display_mode = "float",
  show_prompt = true,
  show_model = true,
}

return options
