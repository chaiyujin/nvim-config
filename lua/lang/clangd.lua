local util = require 'lspconfig.util'

O.lang.clangd = {
  diagnostics = {virtual_text = {spacing = 0, prefix = ""}, signs = false, underline = false},
}

require'lspconfig'.clangd.setup {
  cmd = {vim.fn.stdpath('data') .. "/lsp_servers/cpp/clangd/bin/clangd"},
  on_attach = require'config.lsp'.common_on_attach,
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = O.lang.clangd.diagnostics.virtual_text,
      signs = O.lang.clangd.diagnostics.signs,
      underline = O.lang.clangd.diagnostics.underline,
      update_in_insert = true
    })
  },
  root_dir = util.root_pattern('build/compile_commands.json', '.git')
}

