local set = vim.keymap.set
vim.g.mapleader = " "

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "<C-i>", "<C-i>zz")
set("n", "<C-o>", "<C-o>zz")
set("n", "<C-f>", "<C-f>zz")
set("n", "<C-b>", "<C-b>zz")
set("n", "<S-g>", "<S-g>zz")

set({ "n", "v" }, "<leader>y", '"+y')

-- set("x", "<leader>p", "\"_dP")

set({ "n", "v" }, "<leader>p", '"+p')
set({ "n", "v" }, "<leader>d", '"+d')

set("n", "x", '"_x')

set("n", "<C-j>", "<cmd>cnext<CR>zz")
set("n", "<C-k>", "<cmd>cprev<CR>zz")
-- set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- set("n", "<leader>j", "<cmd>lprev<CR>zz")

set("n", "tn", "<cmd>tabnew<CR>") -- Create new tab
set({ "n", "i" }, "<C-L>", "<cmd>tabnext<CR>") -- Switch to right tab
set({ "n", "i" }, "<C-H>", "<cmd>tabprev<CR>") -- Switch to left tab
set("n", "tc", "<cmd>tabclose<CR>") -- Close current tab
set("n", "tac", "<cmd>tabo<CR>") -- Close all tabs

set("n", "sp", ":vsplit<Return><C-w>w")
set("n", "<leader>h", "<C-w>h")
set("n", "<leader>l", "<C-w>l")
set("n", "<leader>j", "<C-w>j")
set("n", "<leader>k", "<C-w>k")

set("n", "<leader>m", function()
	local text = vim.fn.getreg('"')
	vim.fn.setreg('"', text:match("^%s*(.-)%s*$"))

	vim.cmd('normal! ""p')
end)

vim.keymap.set("n", "Q", "<nop>")
