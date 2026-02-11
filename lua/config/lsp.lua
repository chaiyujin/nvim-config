local M = {}

local custom_on_attach = function(event)
   local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

   -- Keymaps
   vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "LSP: Goto definition." })
   vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "LSP: Goto declaration." })
   vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, { buffer = event.buf, desc = "LSP: Goto previous diagnostic." })
   vim.keymap.set("n", "gn", vim.diagnostic.goto_next, { buffer = event.buf, desc = "LSP: Goto next diagnostic." })
   vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, { buffer = event.buf, desc = "LSP: Open diagnostic in float." })
   vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { buffer = event.buf, desc = "LSP: Open diagnostic in quickfix." })

   -- Inlay hint.
   if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.keymap.set("n", "<leader>th", function()
         vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, { buffer = event.buf, desc = "LSP: Toggle Inlay Hints" })
   end

   -- Folding
   if client and client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
   end

   -- Highlight words under cursor
   if
      client
      and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
      and vim.bo.filetype ~= "bigfile"
   then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
         buffer = event.buf,
         group = highlight_augroup,
         callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
         buffer = event.buf,
         group = highlight_augroup,
         callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
         group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
         callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            -- vim.cmd 'setl foldexpr <'
         end,
      })
   end

end


M.setup = function()
   -- Enable language servers.
   vim.lsp.enable("lua_ls")
   vim.lsp.enable("pyright")

   -- Config diagnostic.
   vim.diagnostic.config {
      virtual_text = {
         prefix = "",
      },
      underline = true,
      update_in_insert = false,
      signs = {
         text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
         },
         texthl = {
            [vim.diagnostic.severity.ERROR] = "Error",
            [vim.diagnostic.severity.WARN] = "Warn",
            [vim.diagnostic.severity.HINT] = "Hint",
            [vim.diagnostic.severity.INFO] = "Info",
         },
         numhl = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
         },
      },
   }

   -- Create autocmd of LspAttach.
   vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("SetupLSP", {}),
      callback = custom_on_attach ,
   })

end

return M
