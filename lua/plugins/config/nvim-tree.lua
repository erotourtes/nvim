local nt = require("nvim-tree")
local nt_api = require("nvim-tree.api")
local bind = require("plenary.fun").bind

nt.setup({
  sort_by = "case_sensitive",
  disable_netrw = true,
  hijack_cursor = true,
  on_attach = function(buffer)
    -- default
    nt_api.config.mappings.default_on_attach(buffer)

    -- custom
    local function set(lhs, rhs)
      vim.keymap.set("n", lhs, rhs, { buffer = buffer, nowait = true })
    end

    set("i", "<NOP>")
    set("c", "<NOP>")

    set("<Tab>", nt_api.node.open.preview)
    set("<CR>", nt_api.node.open.edit)
    set("<2-LeftMouse>", nt_api.node.open.edit)
    set("gk", nt_api.node.navigate.parent)
    set("gj", nt_api.node.navigate.sibling.last)
    set("gc", bind(nt_api.tree.collapse_all, true))
    set("a", nt_api.fs.create)
    set("d", nt_api.fs.remove)
    set("r", nt_api.fs.rename)
    set("x", nt_api.fs.cut)
    set("p", nt_api.fs.paste)
    set("cd", nt_api.tree.change_root_to_node)
    set("<S-R>", nt_api.tree.reload)
  end,
  view = {
    width = 35,
    adaptive_size = true,
    side = "left",
    signcolumn = "yes",
  },
  renderer = {
    group_empty = true,
    root_folder_label = false,
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = false,
        folder_arrow = true,
        git = false,
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = false,
  },
})

vim.keymap.set({ "n", "i" }, "<C-N>", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>nf", "<cmd>NvimTreeFindFile<CR>")
