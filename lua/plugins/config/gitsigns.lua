local loaded, gitsigns = pcall(require, "gitsigns")
if not loaded then print("Gitsigns is not loaded") return end

local ic = require("ui.icons").ui

local options = {
  signs = {
    add = { hl = "GitSignsAdd", text = ic["U258E"], numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = ic["U258E"], numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = ic["U25B8"], numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = ic["U25B8"], numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = {
      hl = "GitSignsChange",
      text = ic["U258E"],
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
  },
  yadm = { enable = false },
}

local function set_hi_groups()
  vim.cmd([[highlight GitSignsAdd guibg=None guifg=Green]])
  vim.cmd([[highlight GitSignsChange guibg=None guifg=DarkCyan]])
  vim.cmd([[highlight GitSignsDelete guibg=None guifg=Grey]])
  vim.cmd([[highlight WinSeparator guibg=None]]) -- Remove borders for window separators
  vim.cmd([[highlight SignColumn guibg=None]]) -- Remove background from signs column
end

gitsigns.setup(options)
set_hi_groups()
