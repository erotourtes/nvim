local present, null_ls = pcall(require, "null-ls")

if not present then return end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sources = {
  formatting.prettier,
  formatting.stylua,
  formatting.clang_format,
  -- diagnostics.eslint_d,
  code_actions.eslint_d,
}

null_ls.setup({ sources = sources })
