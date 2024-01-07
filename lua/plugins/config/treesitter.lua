local ts_config = require("nvim-treesitter.configs")

local options = {
  highlight = {
    enable = true,
    use_languagetree = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
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
    "vim",
    "fish",
    "dockerfile",
    "latex"
  },
}

ts_config.setup(options)
