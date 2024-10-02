-- require("mini.surround").setup()
require("mini.trailspace").setup()
require("mini.pairs").setup()

-- do
--   require("mini.move").setup({
--     mappings = {
--       -- Move visual selection in Visual mode
--       left = "H",
--       right = "L",
--       down = "J",
--       up = "K",
--
--       -- Move current line in Normal mode
--       line_left = "",
--       line_right = "",
--       line_down = "",
--       line_up = "",
--     },
--   })
-- end

-- do
--   local files = require("mini.files")
--   files.setup({
--     options = {
--       permanent_delete = false,
--     },
--     windows = {
--       preview = true,
--       width_focus = 50,
--       width_nofocus = 15,
--       width_preview = 75,
--     },
--   })
--
--   local function mini_toggle()
--     if not files.close() then files.open() end
--   end
--
--   local function mini_current()
--     if not files.close() then files.open(vim.api.nvim_buf_get_name(0)) end
--   end
--
--   vim.keymap.set("n", "<C-n>", mini_toggle, { desc = "Open MiniFiles" })
--   vim.keymap.set(
--     "n",
--     "<leader>nc",
--     mini_current,
--     { desc = "Open current file directory" }
--   )
--
--   vim.api.nvim_create_autocmd("User", {
--     pattern = "MiniFilesWindowOpen",
--     callback = function(args)
--       local win_id = args.data.win_id
--
--       -- Customize window-local settings
--       vim.wo[win_id].winblend = G.const.default_winblend
--       local config = vim.api.nvim_win_get_config(win_id)
--       config.border, config.title_pos = "rounded", "left"
--       vim.api.nvim_win_set_config(win_id, config)
--     end,
--   })
--
--   local files_set_cwd = function(path)
--     -- Works only if cursor is on the valid file system entry
--     local cur_entry_path = files.get_fs_entry().path
--     local cur_directory = vim.fs.dirname(cur_entry_path)
--     vim.fn.chdir(cur_directory)
--   end
--
--   vim.api.nvim_create_autocmd("User", {
--     pattern = "MiniFilesBufferCreate",
--     callback = function(args)
--       vim.keymap.set("n", "g~", files_set_cwd, { buffer = args.data.buf_id })
--     end,
--   })
--
--   local map_split = function(buf_id, lhs, direction)
--     local rhs = function()
--       -- Make new window and set it as target
--       local cur_target = files.get_explorer_state().target_window
--       local new_target = vim.api.nvim_win_call(cur_target, function()
--         vim.cmd(direction .. " split")
--         return vim.api.nvim_get_current_win()
--       end)
--
--       files.set_target_window(new_target)
--     end
--
--     -- Adding `desc` will result into `show_help` entries
--     local desc = "Split " .. direction
--     vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
--   end
--
--   vim.api.nvim_create_autocmd("User", {
--     pattern = "MiniFilesBufferCreate",
--     callback = function(args)
--       local buf_id = args.data.buf_id
--       -- Tweak keys to your liking
--       map_split(buf_id, "<C-s>", "belowright horizontal")
--       map_split(buf_id, "<C-v>", "belowright vertical")
--     end,
--   })
--
--   local set_mark = function(id, path, desc)
--     files.set_bookmark(id, path, { desc = desc })
--   end
--   vim.api.nvim_create_autocmd("User", {
--     pattern = "MiniFilesExplorerOpen",
--     callback = function()
--       set_mark("w", vim.fn.getcwd, "Working directory") -- callable
--     end,
--   })
--
--   table.insert(G.plugin_hl, function(color)
--     vim.api.nvim_set_hl(0, "MiniFilesBorder", { bg = nil, fg = color.light_grey })
--     vim.api.nvim_set_hl(0, "MiniFilesBorderModified", { bg = nil, fg = color.yellow })
--     vim.api.nvim_set_hl(0, "MiniFilesNormal", { bg = nil, fg = color.fg })
--   end)
-- end

do
  local miniclue = require("mini.clue")
  miniclue.setup({
    triggers = {
      -- Leader triggers
      { mode = "n", keys = "<Leader>" },
      { mode = "x", keys = "<Leader>" },

      -- Built-in completion
      { mode = "i", keys = "<C-x>" },

      -- `g` key
      { mode = "n", keys = "g" },
      { mode = "x", keys = "g" },

      -- Marks
      { mode = "n", keys = "'" },
      { mode = "n", keys = "`" },
      { mode = "x", keys = "'" },
      { mode = "x", keys = "`" },

      -- Registers
      { mode = "n", keys = '"' },
      { mode = "x", keys = '"' },
      { mode = "i", keys = "<C-r>" },
      { mode = "c", keys = "<C-r>" },

      -- Window commands
      { mode = "n", keys = "<C-w>" },

      -- `z` key
      -- { mode = "n", keys = "z" },
      -- { mode = "x", keys = "z" },
    },

    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      -- miniclue.gen_clues.z(),
    },
  })

  table.insert(
    G.plugin_hl,
    function(color)
      vim.api.nvim_set_hl(0, "MiniClueBorder", { bg = nil, fg = color.light_grey })
    end
  )
end
