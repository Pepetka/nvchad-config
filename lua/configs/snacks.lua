local options = {
  bigfile = {
    enabled = true,
    notify = true,
    size = 1.5 * 1024 * 1024,
    line_length = 1000,
  },
  indent = {
    enabled = true,
    animate = {
      enabled = false,
    },
  },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = { enabled = true },
  words = { enabled = true },
}

return options
