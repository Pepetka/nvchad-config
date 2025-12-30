local actions = require "telescope.actions"

local additional_args = {
  "--hidden",
  "--no-ignore",
}

local options = {
  defaults = {
    file_ignore_patterns = {
      ".git",
      "node_modules",
      "build",
      "dist",
      ".next",
      "out",
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
      n = {},
    },
    preview = {
      mime_hook = function(filepath, bufnr, opts)
        local is_image = function(gp)
          local image_extensions = { "png", "jpg" }
          -- local image_extensions = { "png", "jpg", "jpeg", "webp", "svg" }
          local split_path = vim.split(gp:lower(), ".", { plain = true })
          local extension = split_path[#split_path]
          return vim.tbl_contains(image_extensions, extension)
        end
        if is_image(filepath) then
          local term = vim.api.nvim_open_term(bufnr, {})
          local function send_output(_, data, _)
            for _, d in ipairs(data) do
              vim.api.nvim_chan_send(term, d .. "\r\n")
            end
          end
          vim.fn.jobstart({
            "catimg",
            -- "chafa",
            filepath,
          }, { on_stdout = send_output, stdout_buffered = true, pty = true })
        else
          require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
        end
      end,
    },
  },
  -- pickers = {
  --   find_files = {
  --     no_ignore = true,
  --     hidden = true,
  --   },
  --   live_grep = {
  --     additional_args = additional_args,
  --   },
  -- },
}

return options
