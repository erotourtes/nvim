local loaded, treesitter = pcall(require, "nvim-treesitter.configs")
if not loaded then return end

local options = {
  highlight = {
    enable = true,
    use_languagetree = true,
    disable = function(_, bufnr)
      -- Disable highlight for large files.
      return vim.api.nvim_buf_line_count(bufnr) > 50000
    end,
  },
  indent = { enable = false },
  ensure_installed = {
    "java",
    "javascript",
    "jsdoc",
    "lua",
    "markdown",
    "regex",
    "rust",
    "tsx",
    "typescript",
    "vim",
  },
}

treesitter.setup(options)
