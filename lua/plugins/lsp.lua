local lspconfig = require("lspconfig")
require("mason").setup({ max_concurrent_installers = 10 })
require("mason-lspconfig").setup()
local conform = require("conform")

local function on_attach(_, buffer)
  local function set(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = buffer, desc = desc })
  end
  local function format() conform.format({ async = true, lsp_fallback = true }) end

  set("gd", vim.lsp.buf.definition, "Go to definition")
  set("gD", vim.lsp.buf.declaration, "Go to declaration")
  set("gl", vim.lsp.buf.implementation, "Go to implementation")
  set("<S-K>", function()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then vim.lsp.buf.hover() end
  end, "Show information under cursor")
  set("<Leader>lf", format, "Format buffer")
  set("<Leader>lr", vim.lsp.buf.rename, "Rename symbol")
  set("<Leader>la", vim.lsp.buf.code_action, "Available actions")
  set("<Leader>lcr", vim.lsp.codelens.refresh)

  set("<M-p>", vim.diagnostic.goto_prev, "Go to previous diagnostic")
  set("<M-n>", vim.diagnostic.goto_next, "Go to next diagnostic")

  set("<leader>llr", function() vim.lsp.buf.references() end, "Show references")
end

local lsps = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
          library = {
            "${3rd}/luv/library",
            unpack(vim.api.nvim_get_runtime_file("", true)),
          },
        },
        completion = {
          callSnippet = "Replace",
        },
        telemetry = { enable = false },
      },
    },
  },
  "pyright",
  "rust_analyzer",
  -- "tsserver",
  "lua_ls",
  "svelte",
  "html",
  "jsonls",
  "eslint",
  "cssls",
  "clangd",
  "bashls",
  "texlab",
  "gopls",
  "dockerls",
  "docker_compose_language_service",
  "tailwindcss-language-server",
  "emmet_language_server",
}

require("mason-tool-installer").setup({
  ensure_installed = vim.list_extend({
    "eslint_d",
    "prettierd",
    "stylua",
    "luacheck",
    "clang-format",
    "texlab",
    -- dap --
    -- {
    --   "js-debug-adapter",
    --   version = "v1.76.1",
    -- },
    "cpptools",
  }, G.utils.tbl_name(lsps)),
})

local default_config = {
  flags = { debounce_text_changes = 150 },
  on_attach = function(client, buffer) on_attach(client, buffer) end,
}

G.utils.tbl_each(lsps, function(server_name, server_config)
  local config = vim.tbl_extend("force", default_config, server_config)

  if server_name == "tailwindcss-language-server" then server_name = "tailwindcss" end

  lspconfig[server_name].setup(config)
end)

-- Format --
conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
  },
})

-- Diagnostics signs --
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "None" })
end

-- LSP stop for large files --
local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
  -- Don't run LSP for large files.
  pattern = "*",
  callback = function()
    vim.cmd([[if line2byte(line("$") + 1) > 1000000 | LspStop | endif]])
  end,
})
