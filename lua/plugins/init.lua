-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  "nvim-lua/plenary.nvim",
  "kyazdani42/nvim-web-devicons",
  "navarasu/onedark.nvim",
  "sainnhe/everforest",
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim" },
      { "mason-org/mason-lspconfig.nvim" },
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
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-textsubjects",
      "LiadOz/nvim-dap-repl-highlights",
    },
    config = function()
      require("nvim-dap-repl-highlights").setup()
      require("plugins.treesitter")
    end,
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
      -- "rafamadriz/friendly-snippets",
    },
    config = function() require("plugins.cmp") end,
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
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
    branch = "harpoon2",
    config = function() require("plugins.harpoon") end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function() require("plugins.toggleterm") end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function() require("plugins.lualine") end,
  },
  -- {
  --   "github/copilot.vim",
  --   config = function()
  --     vim.g.copilot_filetypes = { markdown = true }
  --     vim.g.copilot_no_tab_map = true
  --     vim.g.copilot_assume_mapped = true
  --     vim.g.copilot_tab_fallback = ""
  --   end,
  -- },
  {
    "asiryk/auto-hlsearch.nvim",
    config = function() require("auto-hlsearch").setup() end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function() require("plugins.ufo") end,
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function() require("plugins.mini") end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = {
        show_start = false,
      },
    },
  },
  {
    "ggandor/leap.nvim",
    config = function()
      -- require("leap").create_default_mappings()
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
      vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
    end,
  },
  {
    "folke/trouble.nvim",
    -- config = function() require("plugins.trouble") end,
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>tT",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>tt",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>ts",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>tl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>tL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>tQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  -- "MunifTanjim/nui.nvim",
  -- {
  --   "folke/noice.nvim",
  --   config = function() require("plugins.noice") end,
  -- },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },
  {
    "kevinhwang91/nvim-bqf",
    dependencies = {
      "junegunn/fzf",
    },
  },
  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Git                                                     │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "lewis6991/gitsigns.nvim",
    config = function() require("plugins.gitsigns") end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "sindrets/diffview.nvim",
    },
    config = true,
  },
  {
    "sindrets/diffview.nvim",
    default_args = {
      DiffviewOpen = { "--imply-local" },
    },
  },
  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Typescript                                              │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "windwp/nvim-ts-autotag",
    config = function() require("nvim-ts-autotag").setup() end,
  },
  {
    "razak17/tailwind-fold.nvim",
    opts = {
      min_chars = 50,
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "svelte", "astro", "vue", "typescriptreact" },
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = {
          "*",
          cmp_docs = { always_update = true },
          cmp_menu = { always_update = true },
        },
        user_default_options = {
          css = true,
          mode = "background",
          tailwind = true, -- Enable tailwind colors
        },
      })
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "typescript", "typescriptreact" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function() require("plugins.typescript-tools") end,
  },
  {
    "axelvc/template-string.nvim",
    event = "InsertEnter",
    ft = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    config = true, -- run require("template-string").setup()
  },
  "windwp/nvim-ts-autotag",
  -- ╭─────────────────────────────────────────────────────────╮
  -- │ DAP                                                     │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "mfussenegger/nvim-dap",
    config = function() require("plugins.dap") end,
    keys = {
      "<Leader>da",
      "<Leader>db",
      "<Leader>dc",
      "<Leader>dd",
      "<Leader>dh",
      "<Leader>di",
      "<Leader>do",
      "<Leader>dO",
      "<Leader>dt",
    },
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      },
      "mxsdev/nvim-dap-vscode-js",
    },
  },
  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>nc",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>nd",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        "<c-n>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "g~",
      },
    },
  },
}

require("lazy").setup(plugins)
