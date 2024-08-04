vim.g.mapleader = " "

local set = vim.keymap.set
set("n", "J", "mzJ`z")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "<C-i>", "<C-i>zz")
set("n", "<C-o>", "<C-o>zz")
set("n", "<C-f>", "<C-f>zz")
set("n", "<C-b>", "<C-b>zz")
set("n", "<S-g>", "<S-g>zz")

set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

set({ "n", "v" }, "<leader>y", '"+y')
set({ "n", "v" }, "<leader>p", '"+p')
-- set({ "n", "v" }, "<leader>d", '"+d')
set("n", "x", '"_x')
-- Don't yank on visual paste
set("v", "p", '"_dP')

set("n", "<C-j>", "<cmd>cnext<CR>zz")
set("n", "<C-k>", "<cmd>cprev<CR>zz")

set("n", "tn", "<cmd>tabnew<CR>") -- Create new tab
set({ "n", "i" }, "<C-L>", "<cmd>tabnext<CR>") -- Switch to right tab
set({ "n", "i" }, "<C-H>", "<cmd>tabprev<CR>") -- Switch to left tab
set("n", "tc", "<cmd>tabclose<CR>") -- Close current tab
set("n", "tac", "<cmd>tabo<CR>") -- Close all tabs

-- -- set("n", "sp", ":vsplit<Return><C-w>w")
-- set("n", "<leader>h", "<C-w>h")
-- set("n", "<leader>l", "<C-w>l")
-- set("n", "<leader>j", "<C-w>j")
-- set("n", "<leader>k", "<C-w>k")
-- set("n", "<leader>m", function()
--   local text = vim.fn.getreg('"')
--   vim.fn.setreg('"', text:match("^%s*(.-)%s*$"))
--   vim.cmd('normal! ""p')
-- end)

set("n", "Q", "<nop>")
-- set("n", "<leader>t", ":silent !tmux neww fish -c ts<CR>")

-- Add position to jumplist if moving more than 5 lines up or down
set(
  "n",
  "j",
  [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'j']],
  { expr = true }
)
set(
  "n",
  "k",
  [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'k']],
  { expr = true }
)

-- Toggle quicklist
set("n", "<leader>q", function()
  local fn = vim.fn
  if fn.empty(fn.filter(fn.getwininfo(), "v:val.quickfix")) == 1 then
    vim.cmd("copen")
  else
    vim.cmd("cclose")
  end
end)


set("n", "<leader>gg", ":Neogit<CR>", { silent = true })

