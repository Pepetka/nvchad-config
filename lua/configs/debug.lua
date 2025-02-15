local dap, dapui = require "dap", require "dapui"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      vim.fn.resolve(vim.fn.stdpath "data" .. "/lazy/vscode-js-debug/out/src/dapDebugServer.js"),
      "${port}",
    },
  },
}
dap.adapters["chrome"] = {
  type = "executable",
  command = "node",
  args = { vim.fn.resolve(vim.fn.stdpath "data" .. "/lazy/vscode-chrome-debug/out/src/chromeDebug.js") },
}

local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
for _, language in ipairs(js_based_languages) do
  dap.configurations[language] = {
    {
      name = "Next.js: debug server-side",
      type = "pwa-node",
      request = "attach",
      port = 9230,
      skipFiles = { "<node_internals>/**", "node_modules/**" },
      cwd = "${workspaceFolder}",
    },
    {
      name = "Next.js: debug client-side",
      type = "chrome",
      request = "launch",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      sourceMaps = true,
      sourceMapPathOverrides = {
        ["webpack://_N_E/*"] = "${webRoot}/*",
      },
    },
  }
end

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
