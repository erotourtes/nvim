local loaded, treesitter = pcall(require, "nvim-treesitter.configs")
if not loaded then return end

local ts_config = require("nvim-treesitter.configs")

local function get_buf_size_in_bytes(buf)
  local line_count = vim.api.nvim_buf_line_count(buf)
  return vim.api.nvim_buf_get_offset(buf, line_count)
end

local options = {
  highlight = {
    enable = true,
    use_languagetree = true,
    disable = function(_, buf)
      local buf_size = get_buf_size_in_bytes(buf)
      return buf_size > 1000000
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
    "regex",
    "rust",
    "tsx",
    "typescript",
    "vim",
    "fish",
  },
}

ts_config.setup(options)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("NvimTreesitter-handlebars", {}),
  pattern = "handlebars",
  callback = function() vim.cmd("set filetype=html") end,
  desc = "Use html treesitter parser for handlebars",
})
