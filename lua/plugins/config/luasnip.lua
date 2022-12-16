local present, luasnip = pcall(require, "luasnip")

if not present then return end

local options = {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}
-- Load friendly-snippets           
-- require("luasnip.loaders.from_vscode").lazy_load();
luasnip.config.set_config(options)
