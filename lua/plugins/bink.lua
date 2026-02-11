return {
   "saghen/blink.cmp",

   -- optional: provides snippets for the snippet source
   dependencies = { "fang2hou/blink-copilot" },

   -- use a release tag to download pre-built binaries
   version = "v1.9.1",

   ---@module 'blink.cmp'
   ---@type blink.cmp.Config
   opts = {

      sources = {
         default = { "copilot" },
         providers = {
            copilot = {
               name = "copilot",
               module = "blink-copilot",
               score_offset = 100,
               async = true,
            },
         },
      },
      keymap = {
         preset = "super-tab",
         ["<Tab>"] = {
            function(cmp)
               if vim.b[vim.api.nvim_get_current_buf()].nes_state then
                  cmp.hide()
                  return (
                    require("copilot-lsp.nes").apply_pending_nes()
                    and require("copilot-lsp.nes").walk_cursor_end_edit()
                  )
               end
               if cmp.snippet_active() then
                  return cmp.accept()
               else
                  return cmp.select_and_accept()
               end
            end,
            "snippet_forward",
            "fallback",
         },
      },

      fuzzy = { implementation = "lua" },
   },
}
