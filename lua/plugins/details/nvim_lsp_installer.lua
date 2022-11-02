local M = {}

M.config = function()
   local lsp_installer = require("nvim-lsp-installer")

   -- local capabilities = vim.lsp.protocol.make_client_capabilities()
   -- capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
   -- capabilities.textDocument.completion.completionItem.snippetSupport = true
   -- capabilities.textDocument.completion.completionItem.preselectSupport = true
   -- capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
   -- capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
   -- capabilities.textDocument.completion.completionItem.deprecatedSupport = true
   -- capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
   -- capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
   -- capabilities.textDocument.completion.completionItem.resolveSupport = {
   --    properties = {
   --       "documentation",
   --       "detail",
   --       "additionalTextEdits",
   --    },
   -- }

   local capabilities = require("cmp_nvim_lsp").default_capabilities()

   -- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
   -- or if the server is already installed).
   lsp_installer.on_server_ready(function(server)
      local opts = {
         on_attach = require("plugins.details.nvim_lspconfig").common_on_attach,
         capabilities = capabilities,
      }

      -- (optional) Customize the options passed to the server
      -- if server.name == "tsserver" then
      --     opts.root_dir = function() ... end
      -- end

      -- This setup() function will take the provided server configuration and decorate it with the necessary properties
      -- before passing it onwards to lspconfig.
      -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
      server:setup(opts)
   end)
end

return M
