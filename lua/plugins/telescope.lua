local loaded, telescope = pcall(require, "telescope")
if not loaded then return end

local builtin = require("telescope.builtin")

local function find_nvim_config() builtin.find_files({ cwd = "~/.config/nvim/" }) end

local set = G.utils.set
set("n", "<Leader>fi", builtin.find_files, "Find files")
set("n", "<Leader>ff", builtin.live_grep, "Live grep")
set("n", "<Leader>fa", builtin.builtin, "Find action")
set("n", "<Leader>fb", builtin.buffers, "Find buffers")
set("n", "<Leader>fc", find_nvim_config, "Find nvim config")
set("n", "<Leader>fm", builtin.marks, "Find marks")
set("n", "<Leader>fr", builtin.lsp_references, "Find references")
set("n", "<Leader>fh", builtin.help_tags, "Find help tags")

local ignore_files = {
  "node_modules/",
  "^.*%.png$",
  "^.*%.jpg$",
}

local options = {
  defaults = {
    winblend = G.const.default_winblend,
    prompt_prefix = "",
    selection_caret = "  ",
    file_ignore_patterns = ignore_files,
  },
}

telescope.setup(options)
telescope.load_extension("fzf")
