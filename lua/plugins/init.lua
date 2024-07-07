do -- download lazy if not exists
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end

local plugins = {
  "nvim-lua/plenary.nvim",
  "kyazdani42/nvim-web-devicons",
  "navarasu/onedark.nvim",
  "sainnhe/everforest",
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "stevearc/conform.nvim",
    },
    config = function() require("plugins.lsp") end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function() require("plugins.treesitter") end,
    run = { run = ":TSUpdate" },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function() require("plugins.cmp") end,
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = { "<Leader>f" },
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function() require("plugins.telescope") end,
  },
  {
    "ThePrimeagen/harpoon",
    config = function() require("plugins.harpoon") end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function() require("plugins.gitsigns") end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function() require("plugins.toggleterm") end,
  },
  {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function() require("plugins.lualine") end,
  },
  {
    "github/copilot.vim",
    config = function() vim.g.copilot_filetypes = { markdown = true } end,
  },
  -- {
  --   "asiryk/auto-hlsearch.nvim",
  --   config = function() require("auto-hlsearch").setup() end,
  -- },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function() require("plugins.ufo") end,
  },
  {
    "echasnovski/mini.nvim",
    config = function() require("plugins.mini") end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = { enabled = false },
    },
  },
  {
    "ggandor/leap.nvim",
    config = function() require("leap").create_default_mappings() end,
  },
}

require("lazy").setup(plugins)

-- {
--   "iurimateus/luasnip-latex-snippets.nvim",
--   config = function()
--     require("luasnip-latex-snippets").setup({ use_treesitter = true })

--     -- vim.g.vimtex_compiler_latexmk = {
--     --   executable = 'latexmk',
--     --   options = {
--     --     '-verbose',
--     --     '-file-line-error',
--     --     '-synctex=1',
--     --     '-interaction=nonstopmode',
--     --     '-aux-directory=.aux'
--     --   },
--     --   callback = 1,
--     --   continuous = 1
--     -- }
--   end,
--   dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
--   ft = { "tex", "plaintex" },
-- },
-- {
--   "peterbjorgensen/sved",
--   config = function()
--     vim.keymap.set("n", "\\lv", ":call SVED_Sync()<CR>")
--   end,
--   ft = { "tex", "plaintex" },
-- },

-- {
--   "m-demare/hlargs.nvim",
--   config = function() require("hlargs").setup({ color = "#e06c75" }) end,
-- },
