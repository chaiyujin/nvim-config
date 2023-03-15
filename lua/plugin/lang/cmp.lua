local M = {
   "hrsh7th/nvim-cmp",
   event = "InsertEnter",
   dependencies = {
      "nvim-lspconfig",
   },
}

-- cmp sources
table.insert(M.dependencies, {
   "hrsh7th/cmp-nvim-lsp",
   "hrsh7th/cmp-buffer",
   "hrsh7th/cmp-path",
   "hrsh7th/cmp-cmdline",
   "hrsh7th/cmp-nvim-lsp-signature-help",
})
table.insert(M.dependencies, {
   "L3MON4D3/LuaSnip",
   config = function()
      local luasnip = require("luasnip")
      local default = {
         history = true,
         updateevents = "TextChanged,TextChangedI",
      }
      luasnip.config.set_config(default)
      require("luasnip.loaders.from_vscode").load()
   end
})
table.insert(M.dependencies, {
   "saadparwaiz1/cmp_luasnip",
})

-- autopair [], (), {}
table.insert(M.dependencies, {
   "windwp/nvim-autopairs",
   opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
   },
   config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
   end,
})

M.opts = {}

M.config = function(_, opts)
   local cmp = require'cmp'
   cmp.setup({
      snippet = {
         expand = function(args)
            require("luasnip").lsp_expand(args.body)
         end,
      },
      formatting = {
         format = function(entry, vim_item)
            local icons = require "plugin.lang.lspkind_icons"
            vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
               nvim_lsp = "[LSP]",
               nvim_lua = "[Lua]",
               buffer = "[BUF]",
            })[entry.source.name]
            return vim_item
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
         { name = "buffer" },
         { name = "path" },
         { name = "cmdline" },
         { name = "nvim_lsp_signature_help" },
         { name = "luasnip" },
         { name = "nvim_lua" },
      },
   })

end

return M
