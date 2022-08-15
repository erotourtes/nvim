local loaded, luasnip = pcall(require, "luasnip")
if not loaded then print("Luasnip is not loaded") return end

local options = {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}

luasnip.config.set_config(options)

-- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()
