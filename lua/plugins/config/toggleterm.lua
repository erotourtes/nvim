local present, toggleterm = pcall(require, "toggleterm")

if not present then return end

toggleterm.setup({
  open_mapping = [[<c-t>]],
  direction = "horizontal",
  float_opts = { border = "rounded", winblend = 3 },
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return math.floor(vim.o.columns * 0.4)
    end
  end,
})
