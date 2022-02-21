local M = {}

M.config = function()
   local cmp = require'cmp'

   cmp.setup({
      snippet = {
         expand = function(args)
            require("luasnip").lsp_expand(args.body)
         end,
      },
      mapping = {
         ["<C-p>"] = cmp.mapping.select_prev_item(),
         ["<C-n>"] = cmp.mapping.select_next_item(),
         ["<C-d>"] = cmp.mapping.scroll_docs(-4),
         ["<C-f>"] = cmp.mapping.scroll_docs(4),
         ["<C-Space>"] = cmp.mapping.complete(),
         ["<C-e>"] = cmp.mapping.close(),
         ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
         },
         ["<Tab>"] = function(fallback)
            if cmp.visible() then
               cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
               vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
               fallback()
            end
         end,
         ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
               cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
               vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
               fallback()
            end
         end,
      },
      sources = {
         { name = "nvim_lsp" },
         { name = "luasnip" },
         { name = "buffer" },
         { name = "nvim_lua" },
         { name = "path" },
      },
   })

   -- -- Set configuration for specific filetype.
   -- cmp.setup.filetype('gitcommit', {
   --    sources = cmp.config.sources({
   --       { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it. 
   --    }, {
   --       { name = 'buffer' },
   --    })
   -- })

   -- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
   -- cmp.setup.cmdline('/', {
   --    sources = {
   --       { name = 'buffer' }
   --    }
   -- })

   -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
   -- cmp.setup.cmdline(':', {
   --    sources = cmp.config.sources({
   --       { name = 'path' }
   --    }, {
   --       { name = 'cmdline' }
   --    })
   -- })

   -- -- Setup lspconfig.
   -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
   -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
   -- require('lspconfig')["pyright"].setup {
   --    capabilities = capabilities
   -- }
end

return M