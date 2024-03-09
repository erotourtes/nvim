local loaded, gitsigns = pcall(require, "gitsigns")
if not loaded then
  print("Gitsigns is not loaded")
  return
end

vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<cr>")
vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<cr>")
vim.keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<cr>zz")
vim.keymap.set("n", "<leader>gp", ":Gitsigns prev_hunk<cr>zz")
vim.keymap.set("n", "<leader>ga", ":Gitsigns stage_hunk<cr>zz")
vim.keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<cr>zz")
vim.keymap.set("n", "<leader>gP", ":Gitsigns preview_hunk<cr>zz")
vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<cr>")

local icons = require("ui.icons").ui

local options = {
  signs = {
    add = { text = icons.block },
    change = { text = icons.block },
    delete = { text = icons.triangle },
    topdelete = { text = icons.triangle },
    changedelete = { text = icons.block },
    untracked = { text = icons.thin_block },
  },
}

gitsigns.setup(options)
