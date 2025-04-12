local options = {
  api_key_cmd = "echo $OPENAI_API_KEY",
  api_host_cmd = "echo https://api.openai.com",
  openai_params = {
    model = "gpt-4o",
  },
  openai_edit_params = {
    model = "gpt-4o",
  },
  extra_curl_params = {
    "--proxy",
    "socks5h://127.0.0.1:1086",
  },
}

return options
