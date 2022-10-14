local present = pcall(require, "harpoon")

if not present then return end

local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
local silent = { silent = true }
local bind = require("plenary.fun").bind

local function center_move(fn)
  return function()
    fn()
    vim.cmd("norm! zz")
  end
end

vim.keymap.set("n", "<leader>ha", harpoon_mark.add_file, silent)
vim.keymap.set("n", "<leader>hm", harpoon_ui.toggle_quick_menu, silent)
vim.keymap.set("n", "<M-j>", center_move(bind(harpoon_ui.nav_file, 1)), silent)
vim.keymap.set("n", "<M-k>", center_move(bind(harpoon_ui.nav_file, 2)), silent)
vim.keymap.set("n", "<M-l>", center_move(bind(harpoon_ui.nav_file, 3)), silent)
vim.keymap.set("n", "<M-;>", center_move(bind(harpoon_ui.nav_file, 4)), silent)
