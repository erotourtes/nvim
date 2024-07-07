local loaded, ufo = pcall(require, "ufo")
if not loaded then return end

vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local set = G.utils.set
set("n", "zO", ufo.openAllFolds, "Open all folds")
set("n", "zC", ufo.closeAllFolds, "Close all folds")
set("n", "zp", ufo.goPreviousStartFold, "Go to previous start fold")
set("n", "zn", ufo.goNextClosedFold, "Go to next closed fold")
set("n", "zK", ufo.peekFoldedLinesUnderCursor, "Peek folded lines under cursor")

ufo.setup({
  provider_selector = function(bufnr, filetype, buftype) return { "lsp", "indent" } end,
})
