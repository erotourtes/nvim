local loaded, gs = pcall(require, "gitsigns")
if not loaded then return end

local set = G.utils.set
set("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
set("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
set("n", "<leader>gn", ":Gitsigns next_hunk<cr>zz", "Next hunk")
set("n", "<leader>gp", ":Gitsigns prev_hunk<cr>zz", "Previous hunk")
set("n", "<leader>ga", ":Gitsigns stage_hunk<cr>zz", "Stage hunk")
set("n", "<leader>gA", gs.stage_buffer)
set("n", "<leader>gm", function() gs.blame_line({ full = true }) end)
set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<cr>zz", "Undo stage hunk")
set("n", "<leader>gP", ":Gitsigns preview_hunk<cr>zz", "Preview hunk")
set("n", "<leader>gd", gs.diffthis, "Diff this")

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

gs.setup(options)

table.insert(G.plugin_hl, function(c)
  vim.cmd([[highlight GitSignsAdd guibg=None guifg=]] .. c.green)
  vim.cmd([[highlight GitSignsChange guibg=None guifg=]] .. c.cyan)
  vim.cmd([[highlight GitSignsDelete guibg=None guifg=]] .. c.light_grey)
  vim.cmd([[highlight WinSeparator guibg=None]]) -- Remove borders for window separators
  vim.cmd([[highlight SignColumn guibg=None]]) -- Remove background from signs column
end)
