return {
	["nvim-lua/plenary.nvim"] = { module = "plenary" },
	["kyazdani42/nvim-web-devicons"] = { module = "nvim-web-devicons" },
	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.config.lspconfig")
		end,
	},
	["nvim-treesitter/nvim-treesitter"] = {
		config = function()
			require("plugins.config.treesitter")
		end,
		run = { run = ":TSUpdate" },
	},
	["nvim-treesitter/nvim-treesitter-context"] = {
		config = function()
			require("plugins.config.treesitter-context")
		end,
	},
	["m-demare/hlargs.nvim"] = {
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("hlargs").setup({
				color = "#e06c75", --[[ '#be5046' ]]
			})
		end,
	},
	["jose-elias-alvarez/null-ls.nvim"] = {
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
	},
	["saadparwaiz1/cmp_luasnip"] = {},
	["hrsh7th/cmp-nvim-lsp"] = {},
	["hrsh7th/cmp-nvim-lua"] = {},
	["hrsh7th/cmp-buffer"] = {},
	["hrsh7th/cmp-path"] = {},
	["williamboman/mason.nvim"] = {
		config = function()
			require("plugins.config.mason")
		end,
	},
	["nvim-telescope/telescope.nvim"] = {
		config = function()
			require("plugins.config.telescope")
		end,
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
	},
	["numToStr/Comment.nvim"] = {
		config = function()
			require("Comment").setup()
		end,
	},
	-- ["kyazdani42/nvim-tree.lua"] = {
	-- 	config = function()
	-- 		require("plugins.config.nvim-tree")
	-- 	end,
	-- },
	-- Debugging
	-- ["mfussenegger/nvim-dap"] = {
	-- 	config = function()
	-- 		require("plugins.config.dap")
	-- 	end,
	-- },
	-- ["rcarriga/nvim-dap-ui"] = {
	-- 	config = function()
	-- 		require("plugins.config.dapui")
	-- 	end,
	-- },
	-- ["theHamsta/nvim-dap-virtual-text"] = {
	-- 	config = function()
	-- 		require("nvim-dap-virtual-text").setup()
	-- 	end,
	-- },
	["nvim-lualine/lualine.nvim"] = {
		dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
		config = function()
			require("plugins.config.lualine")
		end,
	},
	-- ["windwp/nvim-autopairs"] = {
	-- 	config = function()
	-- 		require("nvim-autopairs").setup()
	-- 	end,
	-- },
	["navarasu/onedark.nvim"] = {},
	["github/copilot.vim"] = {
		config = function()
			vim.g.copilot_filetypes = { markdown = true }
			-- vim.cmd[[:Copilot enable]]
		end,
	},
	["asiryk/auto-hlsearch.nvim"] = {
		config = function()
			require("auto-hlsearch").setup()
		end,
	},
	-- ["erotourtes/wrapper-machine.nvim"] = {
	--   config = function()
	--     require("wrapper-machine").setup()
	--   end,
	-- },

	["iurimateus/luasnip-latex-snippets.nvim"] = {
		config = function()
			require("luasnip-latex-snippets").setup({ use_treesitter = true })

			-- vim.g.vimtex_compiler_latexmk = {
			--   executable = 'latexmk',
			--   options = {
			--     '-verbose',
			--     '-file-line-error',
			--     '-synctex=1',
			--     '-interaction=nonstopmode',
			--     '-aux-directory=.aux'
			--   },
			--   callback = 1,
			--   continuous = 1
			-- }
		end,
		dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
		ft = { "tex", "plaintex" },
	},

	["peterbjorgensen/sved"] = {
		config = function()
			vim.keymap.set("n", "\\lv", ":call SVED_Sync()<CR>")
		end,
		ft = { "tex", "plaintex" },
	},

	["kevinhwang91/nvim-ufo"] = {
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			require("plugins.config.ufo")
		end,
	},

	--[[

------------
Mini plugins
------------

]]

	["echasnovski/mini.surround"] = {
		version = "*",
		config = function()
			require("mini.surround").setup()
		end,
	},
	["echasnovski/mini.move"] = {
		version = "*",
		config = function()
			require("mini.move").setup({
				mappings = {
					-- Move visual selection in Visual mode
					left = "H",
					right = "L",
					down = "J",
					up = "K",

					-- Move current line in Normal mode
					line_left = "",
					line_right = "",
					line_down = "",
					line_up = "",
				},
			})
		end,
	},
	["echasnovski/mini.files"] = {
		version = "*",
		config = function()
			require("mini.files").setup({
				options = {
					permanent_delete = false,
				},
				windows = {
					preview = true,
					width_focus = 50,
					width_nofocus = 15,
					width_preview = 75,
				},
			})

			vim.keymap.set("n", "<C-n>", function()
				if not MiniFiles.close() then
					MiniFiles.open()
				end
			end)

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesWindowOpen",
				callback = function(args)
					local win_id = args.data.win_id

					-- Customize window-local settings
					vim.wo[win_id].winblend = DEFAULT_WINBLEND
					local config = vim.api.nvim_win_get_config(win_id)
					config.border, config.title_pos = "rounded", "left"
					vim.api.nvim_win_set_config(win_id, config)
				end,
			})

			local files_set_cwd = function(path)
				-- Works only if cursor is on the valid file system entry
				local cur_entry_path = MiniFiles.get_fs_entry().path
				local cur_directory = vim.fs.dirname(cur_entry_path)
				vim.fn.chdir(cur_directory)
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					vim.keymap.set("n", "g~", files_set_cwd, { buffer = args.data.buf_id })
				end,
			})
		end,
	},
	["echasnovski/mini.trailspace"] = {
		version = "*",
		config = function()
			require("mini.trailspace").setup()
		end,
	},
	["echasnovski/mini.clue"] = {
		version = "*",
		config = function()
			require("mini.clue").setup()
		end,
	},

	-- ["folke/noice.nvim"] = {
	--   event = "VeryLazy",
	--   config = function()
	--     require("noice").setup({
	--       cmdline = {
	--         view = "cmdline",
	--       },
	--       lsp = {
	--         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	--         override = {
	--           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	--           ["vim.lsp.util.stylize_markdown"] = true,
	--           ["cmp.entry.get_documentation"] = true,
	--         },
	--       },
	--       -- you can enable a preset for easier configuration
	--       presets = {
	--         bottom_search = true,    -- use a classic bottom cmdline for search
	--         -- command_palette = true, -- position the cmdline and popupmenu together
	--         long_message_to_split = true, -- long messages will be sent to a split
	--         inc_rename = false,      -- enables an input dialog for inc-rename.nvim
	--         lsp_doc_border = false,  -- add a border to hover docs and signature help
	--       },
	--     })
	--   end,
	--   dependencies = {
	--     "MunifTanjim/nui.nvim",
	--     -- "rcarriga/nvim-notify",
	--   },
	-- },

	-- ["~/Documents/projects/lua/wrapper-machine.nvim"] = {
	-- 	dev = true,
	-- 	dir = "~/Documents/projects/lua/wrapper-machine.nvim/",
	-- 	config = function()
	-- 		require("wrapper-machine").setup({
	-- 			close_symbols = {
	-- 				["("] = ")",
	-- 				["["] = "]",
	-- 				["{"] = "}",
	-- 				["<"] = ">",
	-- 				['"'] = '"',
	-- 				["'"] = "'",
	-- 				["`"] = "`",
	-- 			},
	-- 			keymap = "<leader>",
	--        create_commands = true,
	-- 		})
	-- 	end,
	-- },
}
