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
