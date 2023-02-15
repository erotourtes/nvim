require("core.defaults")
require("core.keymaps")

require("plugins.lazy_load").load()

vim.api.nvim_create_autocmd("FileType", {
  -- pattern = { "css", "html", "javascript", "typescript" },
  pattern = { "*" },
  command = "set shiftwidth=2",
})


require("core.theme")();
