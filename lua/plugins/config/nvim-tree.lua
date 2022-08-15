local loaded, nvimtree = pcall(require, "nvim-tree")
if not loaded then print("Nvim-tree is not loaded") return end

nvimtree.setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

vim.keymap.set({ "n", "i" }, "<C-N>", "<cmd>NvimTreeToggle<CR>")
