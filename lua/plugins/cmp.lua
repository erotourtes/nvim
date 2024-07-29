local ok_cmp, cmp = pcall(require, "cmp")
local ok_luasnip, luasnip = pcall(require, "luasnip")
if not ok_cmp or not ok_luasnip then return end

local icons = require("ui.icons").lspkind

vim.opt.completeopt = "menuone,noselect"

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local options = {
  window = {
    completion = {
      border = border("CmpBorder"),
      winhighlight = "Normal:Normal,CursorLine:PmenuSel,Search:None",
    },
    documentation = {
      border = border("CmpDocBorder"),
      winhighlight = "Normal:Normal",
    },
  },
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
      return vim_item
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<Tab>"] = cmp.mapping(function(fallback)
      local copilot_keys = vim.fn["copilot#Accept"]()
      if cmp.visible() then
        if luasnip.expandable() then
          luasnip.expand()
        else
          cmp.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          })
        end
      elseif copilot_keys ~= "" and type(copilot_keys) == "string" then
        vim.api.nvim_feedkeys(copilot_keys, "i", true)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if luasnip.expandable() then
          luasnip.expand()
        else
          cmp.confirm({
            select = true,
          })
        end
      else
        fallback()
      end
    end),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
}

cmp.setup(options)

-- Snippets --
require("luasnip.loaders.from_vscode").lazy_load()

local luasnip_options = {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}

luasnip.config.set_config(luasnip_options)

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
  loadfile(ft_path)()
end

vim.keymap.set(
  { "i", "s" },
  "<C-l>",
  function() luasnip.expand_or_jump() end,
  { silent = true }
)
vim.keymap.set({ "i", "s" }, "<C-h>", function() luasnip.jump(-1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-e>", function()
  if luasnip.choice_active() then luasnip.change_choice(1) end
end, { silent = true })
