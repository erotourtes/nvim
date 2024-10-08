local present_dapui, dapui = pcall(require, "dapui")
local present_dap, dap = pcall(require, "dap")
local present_virtual_text, dap_vt = pcall(require, "nvim-dap-virtual-text")
local present_dap_utils, dap_utils = pcall(require, "dap.utils")

if not present_dapui then
  vim.notify("Missing dapui")
  return
end

if not present_dap then
  vim.notify("Missing dap")
  return
end

if not present_virtual_text then
  vim.notify("Missing nvim-dap-virtual-text")
  return
end

if not present_dap_utils then
  vim.notify("Missing dap.utils")
  return
end

-- ╭──────────────────────────────────────────────────────────╮
-- │ DAP Virtual Text Setup                                   │
-- ╰──────────────────────────────────────────────────────────╯
dap_vt.setup({
  enabled = true, -- enable this plugin (the default)
  enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true, -- show stop reason when stopped for exceptions
  commented = false, -- prefix virtual text with comment string
  only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
  all_references = false, -- show virtual text on all all references of the variable (not only definitions)
  filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
  -- Experimental Features:
  virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ DAP UI Setup                                             │
-- ╰──────────────────────────────────────────────────────────╯
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.2 },
        {
          id = "repl",
          size = 0.3,
        },
        {
          id = "watches",
          size = 0.4,
        },
        {
          id = "breakpoints",
          size = 0.1,
        },
      },
      size = 40, -- 40 columns
      position = "left",
    },
    -- {
    --   elements = {
    --     "repl",
    --     "console",
    --   },
    --   size = 0.25, -- 25% of total lines
    --   position = "bottom",
    -- },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  },
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ DAP Setup                                                │
-- ╰──────────────────────────────────────────────────────────╯
dap.set_log_level("TRACE")

-- Automatically open UI
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.after.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

-- Enable virtual text
vim.g.dap_virtual_text = true

-- ╭──────────────────────────────────────────────────────────╮
-- │ Icons                                                    │
-- ╰──────────────────────────────────────────────────────────╯
-- vim.fn.sign_define(
--   "DapBreakpoint",
--   { text = "🟥", texthl = "", linehl = "", numhl = "" }
-- )
-- vim.fn.sign_define(
--   "DapStopped",
--   { text = "⭐️", texthl = "", linehl = "", numhl = "" }
-- )

-- ╭──────────────────────────────────────────────────────────╮
-- │ Keybindings                                              │
-- ╰──────────────────────────────────────────────────────────╯
local set = G.utils.set

set("n", "<leader>db", function() dap.toggle_breakpoint() end, "DAP: Toggle Breakpoint")
set("n", "<leader>dc", function() dap.continue() end, "DAP: Continue")
set("n", "<leader>dh", function() dapui.eval() end, "DAP: Eval")
set("n", "<leader>di", function() dap.step_into() end, "DAP: Step Into")
set("n", "<leader>do", function() dap.step_out() end, "DAP: Step Out")
set("n", "<leader>dn", function() dap.step_over() end, "DAP: Step Over")
set("n", "<leader>dt", function() dap.terminate() end, "DAP: Terminate")
set("n", "<leader>dU", function() dapui.open() end, "DAP: Open UI")
set("n", "<leader>dC", function() dapui.close() end, "DAP: Close UI")

set(
  "n",
  "<Leader>dw",
  function() dapui.float_element("watches", { enter = true }) end,
  "DAP: Watches"
)
set(
  "n",
  "<Leader>ds",
  function() dapui.float_element("scopes", { enter = true }) end,
  "DAP: Scopes"
)
set(
  "n",
  "<Leader>dr",
  function() dapui.float_element("repl", { enter = true }) end,
  "DAP: REPL"
)

-- ╭──────────────────────────────────────────────────────────╮
-- │ Adapters                                                 │
-- ╰──────────────────────────────────────────────────────────╯

-- VSCODE JS (Node/Chrome/Terminal/Jest)

require("dap-vscode-js").setup({
  -- debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
  debugger_path = require("lazy.core.config").defaults.root .. "/vscode-js-debug",
  -- debugger_cmd = { "js-debug-adapter" },
  debugger_cmd = nil,
  adapters = {
    "pwa-node",
    "pwa-chrome",
    "pwa-msedge",
    "node-terminal",
    "pwa-extensionHost",
    "chrome",
    "node",
  },
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ Configurations                                           │
-- ╰──────────────────────────────────────────────────────────╯
local exts = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "vue",
  "svelte",
}

set("n", "<leader>da", function()
  if vim.fn.filereadable(".vscode/launch.json") then
    local dap_vscode = require("dap.ext.vscode")
    dap_vscode.load_launchjs(nil, {
      ["pwd-node"] = exts,
      ["node"] = exts,
      ["chrome"] = exts,
      ["pwd-chrome"] = exts,
      ["extensionHost"] = exts,
    })
  end
  dap.continue()
end, "DAP: Attach")

for _, ext in ipairs(exts) do
  dap.configurations[ext] = {
    {
      type = "pwa-chrome",
      request = "launch",
      name = 'Launch Chrome with "localhost"',
      url = function()
        local co = coroutine.running()
        return coroutine.create(function()
          vim.ui.input(
            { prompt = "Enter URL: ", default = "http://localhost:3000" },
            function(url)
              if url == nil or url == "" then
                return
              else
                coroutine.resume(co, url)
              end
            end
          )
        end)
      end,
      webRoot = vim.fn.getcwd(),
      protocol = "inspector",
      sourceMaps = true,
      userDataDir = false,
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File (pwa-node)",
      cwd = vim.fn.getcwd(),
      args = { "${file}" },
      sourceMaps = true,
      protocol = "inspector",
      runtimeExecutable = "npm",
      runtimeArgs = {
        "run-script",
        "dev",
      },
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File (pwa-node with ts-node)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "--loader", "ts-node/esm" },
      runtimeExecutable = "node",
      args = { "${file}" },
      sourceMaps = true,
      protocol = "inspector",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File (pwa-node with deno)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
      runtimeExecutable = "deno",
      attachSimplePort = 9229,
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Test Current File (pwa-node with jest)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
      runtimeExecutable = "node",
      args = { "${file}", "--coverage", "false" },
      rootPath = "${workspaceFolder}",
      sourceMaps = true,
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Test Current File (pwa-node with vitest)",
      cwd = vim.fn.getcwd(),
      program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
      args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
      autoAttachChildProcesses = true,
      smartStep = true,
      console = "integratedTerminal",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Test Current File (pwa-node with deno)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
      runtimeExecutable = "deno",
      attachSimplePort = 9229,
    },
    {
      type = "pwa-chrome",
      request = "attach",
      name = "Attach Program (pwa-chrome, select port)",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = function() return vim.fn.input("Select port: ", 9222) end,
      webRoot = "${workspaceFolder}",
      skipFiles = {
        "**/node_modules/**/*",
        "**/@vite/*",
      },
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach Program (pwa-node, select pid)",
      cwd = vim.fn.getcwd(),
      processId = dap_utils.pick_process,
      skipFiles = { "<node_internals>/**" },
    },
  }
end

vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

vim.fn.sign_define("DapBreakpoint", {
  text = "",
  texthl = "DapBreakpoint",
  linehl = "DapBreakpoint",
  numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointCondition", {
  text = "ﳁ",
  texthl = "DapBreakpoint",
  linehl = "DapBreakpoint",
  numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointRejected", {
  text = "",
  texthl = "DapBreakpoint",
  linehl = "DapBreakpoint",
  numhl = "DapBreakpoint",
})
vim.fn.sign_define(
  "DapLogPoint",
  { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
)
vim.fn.sign_define(
  "DapStopped",
  { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
)

