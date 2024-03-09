vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set("n", "zO", require("ufo").openAllFolds)
vim.keymap.set("n", "zC", require("ufo").closeAllFolds)
vim.keymap.set("n", "zp", require("ufo").goPreviousStartFold)
vim.keymap.set("n", "zn", require("ufo").goNextClosedFold)
vim.keymap.set("n", "zK", require("ufo").peekFoldedLinesUnderCursor)

require("ufo").setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { "lsp", "indent" }
  end,
})
