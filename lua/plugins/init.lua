return {
	["wbthomason/packer.nvim"] = {},
	["nvim-lua/plenary.nvim"] = { module = "plenary" },
	["kyazdani42/nvim-web-devicons"] = { module = "nvim-web-devicons" },

	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.config.lspconfig")
		end,
	},

	["nvim-treesitter/nvim-treesitter"] = {
    config = function() require("plugins.config.treesitter") end,
    run = {run = ':TSUpdate'},
  },
	["nvim-treesitter/nvim-treesitter-context"] = {
		config = function()
			require("plugins.config.treesitter-context")
		end,
		after = "nvim-treesitter",
	},
	["m-demare/hlargs.nvim"] = {
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("hlargs").setup({
				color = "#e06c75",--[[ '#be5046' ]]
			})
		end,
	},

	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("plugins.config.null-ls")
		end,
	},

	-- Completion and snippets. Are loaded in Insert mode only.
  -- ["rafamadriz/friendly-snippets"] = { event = "InsertEnter" },
	["L3MON4D3/LuaSnip"] = {
		config = function()
			require("plugins.config.luasnip")
		end,
    -- after = "friendly-snippets",
    -- event = "InsertEnter", -- Causes autocmd in defaults to not work
	},
	["hrsh7th/nvim-cmp"] = {
		config = function()
			require("plugins.config.cmp")
		end,
		after = "LuaSnip",
	},
	["saadparwaiz1/cmp_luasnip"] = { after = "nvim-cmp" },
	["hrsh7th/cmp-nvim-lsp"] = { after = "cmp_luasnip" },
	["hrsh7th/cmp-nvim-lua"] = { after = "cmp-nvim-lsp" },
	["hrsh7th/cmp-buffer"] = { after = "cmp-nvim-lua" },
	["hrsh7th/cmp-path"] = { after = "cmp-buffer" },

	["williamboman/mason.nvim"] = {
		config = function()
			require("plugins.config.mason")
		end,
	},

	["nvim-telescope/telescope.nvim"] = {
		config = function()
			require("plugins.config.telescope")
		end,
		keys = { "<Leader>f" }, -- All Telescope keybindings start with <Leader>f
	},

	["ThePrimeagen/harpoon"] = {
		config = function()
			require("plugins.config.harpoon")
		end,
	},

	["lewis6991/gitsigns.nvim"] = {
		config = function()
			require("plugins.config.gitsigns")
		end,
	},

	["akinsho/toggleterm.nvim"] = {
		config = function()
			require("plugins.config.toggleterm")
		end,
		keys = { "<C-T>" },
	},

	["numToStr/Comment.nvim"] = {
		config = function()
			require("Comment").setup()
		end,
		keys = { "gc", "gb" },
	},

	["kyazdani42/nvim-tree.lua"] = {
		config = function()
			require("plugins.config.nvim-tree")
		end,
		keys = { "<C-N>", "<leader>nf" },
	},

	-- Debugging
	["mfussenegger/nvim-dap"] = {
		config = function()
			require("plugins.config.dap")
		end,
	},
	["rcarriga/nvim-dap-ui"] = {
		config = function()
			require("plugins.config.dapui")
		end,
		after = { "nvim-dap" },
	},
	["theHamsta/nvim-dap-virtual-text"] = {
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
		after = { "nvim-dap" },
	},

	["nvim-lualine/lualine.nvim"] = {
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("plugins.config.lualine")
		end,
	},

	["windwp/nvim-autopairs"] = {
		config = function()
			require("nvim-autopairs").setup()
		end,
    event = "InsertEnter"
	},

	["navarasu/onedark.nvim"] = {},

	["github/copilot.vim"] = {
		config = function()
      -- vim.cmd[[:Copilot enable]]
		end,
  },


	-- ["folke/noice.nvim"] = {
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("noice").setup()
	-- 	end,
	-- 	requires = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- },
}
