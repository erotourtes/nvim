local function default()
  -- highlight current line number
  vim.opt.cursorline = true
  vim.cmd("hi clear CursorLine")

  local c = require("onedark.colors")
  -- Make VertSplit look not faded
  vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { fg = c.bg3 })

  -- Make Everything transparent
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

  -- use default ts parameter color for hlargs
  vim.cmd([[
    hi clear Hlargs
    hi link Hlargs @parameter
  ]])
end

local function changeTo(num)
  local theme = require("onedark")
  DEFAULT_WINBLEND = num
  theme.setup({
    transparent = num == 0,
    style = "warmer",
  })
  theme.load()

  local telescope = require("telescope")
  telescope.setup({
    defaults = { winblend = DEFAULT_WINBLEND },
  })

  vim.wo.winblend = DEFAULT_WINBLEND
  vim.o.pumblend = DEFAULT_WINBLEND
  vim.cmd("hi clear CursorLine")
end

local function onedark()
  local theme = require("onedark")
  theme.setup({ transparent = true })
  theme.load()

  default()

  if require("utils.getOpacity")() == 1 then
    changeTo(15)
  end
end

return onedark
