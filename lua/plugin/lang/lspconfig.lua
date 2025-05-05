---@diagnostic disable: unused-local
local M = {
   "neovim/nvim-lspconfig",
   event = "BufRead",
}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem = {
   documentationFormat = { "markdown", "plaintext" },
   snippetSupport = true,
   preselectSupport = true,
   insertReplaceSupport = true,
   labelDetailsSupport = true,
   deprecatedSupport = true,
   commitCharactersSupport = true,
   tagSupport = { valueSet = { 1 } },
   resolveSupport = {
      properties = {
         "documentation",
         "detail",
         "additionalTextEdits",
      },
   },
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(client, bufnr)
   local opts = { noremap=true, silent=true }
   -- Enable completion triggered by <c-x><c-o>
   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

   -- Mappings.
   -- See `:help vim.lsp.*` for documentation on any of the below functions
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',   '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>do', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>dq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

   -- -- NOTE: disable semanticTokens.
   -- client.server_capabilities.semanticTokensProvider = nil
end

local function filter(arr, func)
   -- Filter in place
   -- https://stackoverflow.com/questions/49709998/how-to-filter-a-lua-array-inplace
   local new_index = 1
   local size_orig = #arr
   for old_index, v in ipairs(arr) do
      if func(v, old_index) then
         arr[new_index] = v
         new_index = new_index + 1
      end
   end
   for i = new_index, size_orig do arr[i] = nil end
end

local function filter_diagnostics(diagnostic)
   -- Only filter out Pyright stuff for now
   if diagnostic.source ~= "Pyright" then
      return true
   end

   -- Allow kwargs to be unused, sometimes you want many functions to take the
   -- same arguments but you don't use all the arguments in all the functions,
   -- so kwargs is used to suck up all the extras
   if diagnostic.message == '"args" is not accessed' then
      return false
   end
   if diagnostic.message == '"kwargs" is not accessed' then
      return false
   end
   -- Allow variables starting with an underscore
   if string.match(diagnostic.message, '"_.+" is not accessed') then
      return false
   end

   return true
end

local function custom_on_publish_diagnostics(a, params, client_id, c, config)
   filter(params.diagnostics, filter_diagnostics)
   vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c, config)
end

M.config = function()

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

   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single",
   })
   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "single",
   })

   vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(custom_on_publish_diagnostics, {
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = false,
   })

end

return M
