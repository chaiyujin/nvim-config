local M = {
   'williamboman/mason-lspconfig.nvim',
   event = "BufRead",
   dependencies = {
      "mason.nvim",
      "nvim-lspconfig",
   },
}

M.opts = {
   -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
   -- This setting has no relation with the `automatic_installation` setting.
   ensure_installed = {"lua_ls", "pyright", "zls"},

   -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
   -- This setting has no relation with the `ensure_installed` setting.
   -- Can either be:
   --   - false: Servers are not automatically installed.
   --   - true: All servers set up via lspconfig are automatically installed.
   --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
   --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
   automatic_installation = false,
}

M.config = function(_, opts)
   require("mason-lspconfig").setup(opts)
   local cfg = require("plugin.lang.lspconfig")
   local capabilities = require('cmp_nvim_lsp').default_capabilities()

   local lspconfig = require("lspconfig")  ---@diagnostic disable-line
   lspconfig["pyright"].setup({
      on_attach = cfg.on_attach,
      capabilities = capabilities,
   })
   lspconfig["zls"].setup({})
   lspconfig["rust_analyzer"].setup({})
   lspconfig["fsautocomplete"].setup({})
   lspconfig["clangd"].setup({})
   lspconfig["lua_ls"].setup {
      on_attach = cfg.on_attach,
      capabilities = capabilities,

      settings = {
         Lua = {
            diagnostics = {
               globals = { "vim" },
            },
            workspace = {
               library = {
                  [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                  [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                  [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
                  [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
               },
               maxPreload = 100000,
               preloadFileSize = 10000,
            },
         },
      },
   }
end

return M
