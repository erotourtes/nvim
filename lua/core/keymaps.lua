local set = vim.keymap.set
vim.g.mapleader = " "


set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")


set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")


set("v", "<leader>y", "\"+y")
set("v", "<leader>y", "\"+y")

set("n", "<leader>p", "\"+p")
set("v", "<leader>p", "\"+p")

set("n", "<leader>d", "\"_d")
set("v", "<leader>d", "\"_d")

set("n", "x", "\"_x")


set("n", "tn", "<cmd>tabnew<CR>") -- Create new tab
set({ "n", "i" }, "<C-L>", "<cmd>tabnext<CR>") -- Switch to right tab
set({ "n", "i" }, "<C-H>", "<cmd>tabprev<CR>") -- Switch to left tab
set("n", "tc", "<cmd>tabclose<CR>") -- Close current tab
set("n", "tac", "<cmd>tabo<CR>") -- Close all tabs


set("n", "vsp", ":vsplit<Return><C-w>w")
set("n", "sp", ":split<Return><C-w>j")
set("n", "<leader>h", "<C-w>h")
set("n", "<leader>j", "<C-w>j")
set("n", "<leader>k", "<C-w>k")
set("n", "<leader>l", "<C-w>l")
