local actions = require "telescope.actions"

local additional_args = {
  -- "--hidden",
  -- "--no-ignore",
}

local options = {
  defaults = {
    file_ignore_patterns = {
      "^.git/",
      "^node_modules/",
      "^build/",
      "^dist/",
      "^.next/",
      "^out/",
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
      n = {},
    },
    preview = {
      mime_hook = function(filepath, bufnr, opts)
        local ext = vim.fn.fnamemodify(filepath, ":e"):lower()
        if not vim.tbl_contains({ "png", "jpg", "jpeg", "gif", "bmp", "webp" }, ext) then
          require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
          return
        end

        local term = vim.api.nvim_open_term(bufnr, {})

        local cell_ratio = 2.2

        local avail_w = vim.api.nvim_win_get_width(opts.winid)
        local avail_h = vim.api.nvim_win_get_height(opts.winid)
        local avail_aspect = avail_w / avail_h

        local img_w, img_h
        local id_out = vim.fn.systemlist({ "identify", "-format", "%w %h", filepath })[1]
        if id_out then
          img_w, img_h = id_out:match "(%d+)%s+(%d+)"
          img_w, img_h = tonumber(img_w), tonumber(img_h)
        end
        if not img_w or not img_h then
          img_w, img_h = avail_w, avail_h
        end
        local img_aspect = cell_ratio * img_w / img_h

        if img_aspect > avail_aspect then
          img_w = avail_w
          img_h = math.floor(img_w / img_aspect)
        else
          img_h = avail_h
          img_w = math.floor(img_h * img_aspect)
        end

        local offset_x = math.floor((avail_w - img_w) / 2)

        vim.fn.jobstart({
          "viu",
          "-w",
          tostring(img_w),
          "-h",
          tostring(img_h),
          "-x",
          tostring(offset_x),
          "-b",
          "-t",
          filepath,
        }, {
          pty = true,
          stdout_buffered = true,
          on_stdout = function(_, data, _)
            local out = table.concat(data)
            if out ~= "" then
              for line in out:gmatch "[^\r\n]+" do
                vim.api.nvim_chan_send(term, line .. "\r\n")
              end
            end
          end,
        })
      end,
    },
  },
  pickers = {
    find_files = {
      no_ignore = false,
      hidden = false,
    },
    live_grep = {
      additional_args = additional_args,
    },
  },
}

return options
