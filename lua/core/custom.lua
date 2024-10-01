local api = vim.api

local ts = require("nvim-treesitter.ts_utils")

local function cursor_between_tags()
  local node = ts.get_node_at_cursor()
  if not node then return false end

  while node do
    if node:type() == "jsx_element" or node:type() == "element" then
      local start_row, start_col, end_row, end_col = node:range()
      local cursor_row, cursor_col = unpack(api.nvim_win_get_cursor(0))
      cursor_row = cursor_row - 1 -- Convert to 0-based index

      if
        cursor_row == start_row
        and cursor_col > start_col
        and (cursor_row < end_row or (cursor_row == end_row and cursor_col < end_col))
      then
        -- Check if we're not inside a child element
        local parent = node:parent()
        if parent and (parent:type() == "jsx_element" or parent:type() == "element") then
          local _, _, parent_end_row, parent_end_col = parent:range()
          if cursor_row == parent_end_row and cursor_col >= parent_end_col then
            return false
          end
        end
        return true
      end
    end
    node = node:parent()
  end

  return false
end

-- local function cursor_between_tags()
--   local line = api.nvim_get_current_line()
--   local _, col = unpack(api.nvim_win_get_cursor(0))
--
--   -- Check if we're between a pair of angle brackets
--   local before = line:sub(1, col):match(">([^<]*)$")
--   local after = line:sub(col + 1):match("^([^>]*)<")
--
--   return before ~= nil and after ~= nil
-- end

-- Function to get the indentation of the current line
local function get_indentation(line) return line:match("^%s*") end

-- Function to format tags
local function format_tags()
  local line = api.nvim_get_current_line()
  local cursor = api.nvim_win_get_cursor(0)
  local row, col = cursor[1], cursor[2]

  -- Get the current indentation
  local indent = get_indentation(line)
  local additional_indent = string.rep(" ", vim.bo.shiftwidth)

  -- Split the line at the cursor position
  local before = line:sub(1, col)
  local after = line:sub(col + 1)

  -- Create new lines
  local new_lines = {
    before,
    indent .. additional_indent,
    indent .. after,
  }

  -- Replace the current line with the new lines
  api.nvim_buf_set_lines(0, row - 1, row, false, new_lines)

  -- Move the cursor to the indented line
  api.nvim_win_set_cursor(0, { row + 1, #indent + #additional_indent })
end

local function enter_pressed()
  if cursor_between_tags() then
    format_tags()
  else
    api.nvim_feedkeys(api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
  end
end

-- Set up autocommand
api.nvim_create_autocmd("FileType", {
  pattern = { "html", "javascriptreact", "typescriptreact" },
  callback = function()
    local buf = api.nvim_get_current_buf()
    vim.keymap.set(
      "i",
      "<CR>",
      enter_pressed,
      { noremap = true, silent = true, expr = false, buffer = buf }
    )
  end,
})
