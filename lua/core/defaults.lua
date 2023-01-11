local autocmd = vim.api.nvim_create_autocmd

vim.opt.guicursor = ""

vim.opt.mouse = "a" -- enable mouse support
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.laststatus = 3 -- Set global status line

-- Add position to jumplist if moving more than 5 lines up or down
vim.keymap.set("n", "j", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'j']], { expr = true })
vim.keymap.set("n", "k", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'k']], { expr = true })

local function default()
  -- highlight current line number
  vim.opt.cursorline = true
  vim.cmd("hi clear CursorLine")

  local c = require("onedark.colors")
  -- Make VertSplit look not faded
  vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { fg = c.bg3 })

  -- Make Everything transparent
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

  -- use default ts parameter color for hlargs
  vim.cmd([[
    hi clear Hlargs
    hi link Hlargs @parameter
  ]])
end

local function onedark()
  local theme = require("onedark")
  theme.setup({ transparent = true })
  theme.load()

  default()
end

onedark()

autocmd("TextYankPost", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("TextYankPost", { clear = true }),
  callback = function()
    local mode = vim.api.nvim_get_mode()["mode"]

    -- Only highlight in normal mode. not in visual
    if mode == "no" then vim.highlight.on_yank({
        higroup = "Visual",
        timeout = 75,
      })
    end
  end,
})

-- Don't auto comment new lines
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})


-- Disable some default plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "python3_provider",
  "python_provider",
  "node_provider",
  "ruby_provider",
  "perl_provider",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  -- "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  vim.g["loaded_" .. plugin] = 1
end
