return {
  ["wbthomason/packer.nvim"] = {},
  ["nvim-lua/plenary.nvim"] = { module = "plenary" },
  ["kyazdani42/nvim-web-devicons"] = { module = "nvim-web-devicons" },

  ["neovim/nvim-lspconfig"] = { config = function() require("plugins.config.lspconfig") end },

  ["nvim-treesitter/nvim-treesitter"] = {
    setup = function() vim.cmd("PackerLoad nvim-treesitter") end,
    config = function() require("plugins.config.treesitter") end,
    run = ":TSUpdate",
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function() require("plugins.config.null-ls") end,
  },

  -- Completion and snippets. Are loaded in Insert mode only.
  ["rafamadriz/friendly-snippets"] = { event = "InsertEnter" },
  ["L3MON4D3/LuaSnip"] = { config = function() require("plugins.config.luasnip") end, after = "friendly-snippets" },
  ["hrsh7th/nvim-cmp"] = { config = function() require("plugins.config.cmp") end, after = "LuaSnip" },
  ["saadparwaiz1/cmp_luasnip"] = { after = "nvim-cmp" },
  ["hrsh7th/cmp-nvim-lsp"] = { after = "cmp_luasnip" },
  ["hrsh7th/cmp-nvim-lua"] = { after = "cmp-nvim-lsp" },
  ["hrsh7th/cmp-buffer"] = { after = "cmp-nvim-lua" },
  ["hrsh7th/cmp-path"] = { after = "cmp-buffer" },

  ["williamboman/mason.nvim"] = { config = function() require("mason").setup() end },

  ["nvim-telescope/telescope.nvim"] = {
    config = function() require("plugins.config.telescope") end,
    keys = { "<Leader>f" }, -- All Telescope keybindings start with <Leader>f
  },

  -- ["lewis6991/gitsigns.nvim"] = { config = function() require("plugins.config.gitsigns") end},

  ['lewis6991/gitsigns.nvim'] = { config = function()
    require("gitsigns").setup({
      yadm = { enable = false } --{ enable = vim.fn.executable("yadm") == 1 },
    })
  end },

  ["numToStr/Comment.nvim"] = { config = function() require("Comment").setup() end, keys = { "gc", "gb" } },

  ["kyazdani42/nvim-tree.lua"] = {
    config = function() require("plugins.config.nvim-tree") end,
    keys = { "<C-N>" },
  },

  ['nvim-lualine/lualine.nvim'] = {
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require("plugins.config.lualine") end,
  },

  ["windwp/nvim-autopairs"] = {
    config = function() require("nvim-autopairs").setup() end,
    after = "friendly-snippets"
  },

  ['navarasu/onedark.nvim'] = { config = function() require("onedark").load() end },
}
