local present, nvim_tree = pcall(require, "nvim-tree")

if not present then return end

nvim_tree.setup({
  sort_by = "case_sensitive",
  disable_netrw = true,
  hijack_cursor = true,
  view = {
    width = 35,
    height = 35,
    adaptive_size = true,
    hide_root_folder = false,
    side = "left",
    signcolumn = "yes",
  },
  renderer = {
    group_empty = true,
    highlight_git = true, -- TODO: change colors
    highlight_opened_files = "name",
    icons = {
      show = {
        file = true,
        folder = false,
        folder_arrow = true,
        git = false,
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  filters = {
    dotfiles = true,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = false,
  },
})

vim.keymap.set({ "n", "i" }, "<C-N>", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set({ "n", "i", "v"}, "<C-f>", "<cmd>NvimTreeFindFile<CR>")
