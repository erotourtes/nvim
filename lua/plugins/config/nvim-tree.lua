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

--[[ NvimTreeGitDirty
NvimTreeGitStaged
NvimTreeGitMerge
NvimTreeGitRenamed
NvimTreeGitNew
NvimTreeGitDeleted
NvimTreeGitIgnored      (Comment)

NvimTreeSymlink
NvimTreeFolderName          (Directory)
NvimTreeRootFolder
NvimTreeFolderIcon
NvimTreeFileIcon
NvimTreeEmptyFolderName     (Directory)
NvimTreeOpenedFolderName    (Directory)
NvimTreeExecFile
NvimTreeOpenedFile
NvimTreeSpecialFile
NvimTreeImageFile
NvimTreeIndentMarker
 ]]
    highlight_opened_files = true,
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
