local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    silent = true,
    border = "rounded",
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = "rounded" }
  ),
  ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = true }
  ),
}

require("typescript-tools").setup({
  handlers = handlers,
  settings = {
    separate_diagnostic_server = true,
    code_lens = "off",
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeCompletionsForModuleExports = true,
      quotePreference = "auto",
    },
  },
})

local set = G.utils.set

set('n', '<leader>lio', '<cmd>TSToolsOrganizeImports<CR>', 'Organize imports')

