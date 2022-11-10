local present, dapui = pcall(require, "dapui")
if not present then return end

local dap = require("dap")
-- dapui.setup()
dapui.setup({
 layouts = {
   {
     elements = {
      -- Elements can be strings or table with id and size keys.
      "watches",
      { id = "scopes", size = 0.5 },
      "breakpoints",
    },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
        "stacks",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


