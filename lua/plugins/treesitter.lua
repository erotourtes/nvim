---@diagnostic disable: missing-fields
local ts_config = require("nvim-treesitter.configs")

ts_config.setup({
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      local ignore_file_size = ok and stats and stats.size > max_filesize
      if ignore_file_size then return true end
    end,
  },
  indent = { enable = true },
  playground = {
    enable = true,
  },
  ensure_installed = {
    "css",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "lua",
    "markdown",
    "markdown_inline",
    "regex",
    "rust",
    "tsx",
    "typescript",
    "hyprlang",
    "vim",
    "vimdoc",
    "fish",
    "bash",
    "dockerfile",
    "latex",
    "json",
    "yaml",
    "toml",
    "sql",
    "c",
    "dap_repl",
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = { query = "@function.outer", desc = "Select around function" },
        ["if"] = { query = "@function.inner", desc = "Select inside function" },
        ["ab"] = { query = "@block.outer", desc = "Select around block" },
        ["ib"] = { query = "@block.inner", desc = "Select inside block" },
        ["ac"] = { query = "@comment.outer", desc = "Select around comment" },
        ["ic"] = { query = "@comment.inner", desc = "Select inside comment" },
      },
    },
  },
  textsubjects = {
    enable = true,
    prev_selection = ",",
    keymaps = {
      ["."] = "textsubjects-smart",
    },
  },
})

require("treesitter-context").setup({
  max_lines = 3,
  patterns = {
    default = {
      "function",
      "method",
      "for",
      "while",
      "if",
      "switch",
      "case",
    },
    typescript = {
      "class_declaration",
      "abstract_class_declaration",
      "else_clause",
    },
  },
})

vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
