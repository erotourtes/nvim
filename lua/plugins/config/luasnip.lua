local present, luasnip = pcall(require, "luasnip")

if not present then return end

require("luasnip.loaders.from_vscode").lazy_load()

local options = {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}

-- Jump to next snippet placeholder
vim.api.nvim_set_keymap('i', '<C-l>', '<Plug>luasnip-expand-or-jump', { silent = true })
vim.api.nvim_set_keymap('s', '<C-l>', '<Plug>luasnip-expand-or-jump', { silent = true })

-- Load friendly-snippets           
-- require("luasnip.loaders.from_vscode").lazy_load();
luasnip.config.set_config(options)
