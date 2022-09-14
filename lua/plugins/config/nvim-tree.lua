local present, nvim_tree = pcall(require, "nvim-tree")

if not present then return end

nvim_tree.setup({
  sort_by = "case_sensitive",
  disable_netrw = true,
  hijack_cursor = true,
  -- remove_keymaps = true, -- TODO: make custom keymaps
  -- on_attach = function(bufnr)
  --   -- set keymaps here
  -- end,
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

-- vim.cmd([[highlight NvimTreeGitNew guifg=#0A7700]])
-- vim.cmd([[highlight NvimTreeGitDeleted  guifg=#E4572E]])
-- vim.cmd([[highlight NvimTreeGitDirty guifg=#E3AE2D]])
-- vim.cmd([[highlight NvimTreeGitRenamed  guifg=#007C7C]])
-- vim.cmd([[highlight NvimTreeGitMerge guifg=#7503DC]])
-- vim.cmd([[highlight NvimTreeGitStaged guifg=pink]])

-- vim.cmd([[highlight NvimTreeGitIgnored guifg=cyan]])

vim.keymap.set({ "n", "i" }, "<C-N>", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set({ "n", "i", "v"}, "<C-f>", "<cmd>NvimTreeFindFile<CR>")
