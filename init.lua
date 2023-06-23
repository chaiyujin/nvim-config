if vim.g.vscode then
   -- vscode-neovim.
   vim.cmd[[xmap gc  <Plug>VSCodeCommentary]]
   vim.cmd[[nmap gc  <Plug>VSCodeCommentary]]
   vim.cmd[[omap gc  <Plug>VSCodeCommentary]]
   vim.cmd[[nmap gcc <Plug>VSCodeCommentaryLine]]
else
   if vim.g.neovide then
      vim.g.neovide_input_macos_alt_is_meta = true
      -- Helper function for transparency formatting
      local alpha = function()
         return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
      end
      -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
      vim.g.neovide_transparency = 0.0
      vim.g.transparency = 0.95
      vim.g.neovide_background_color = "#0f1117" .. alpha()
   end
   -- neovim.
   require("core.bootstrap").nvim_opt()
   require("core.bootstrap").basic_mapping()
   require("core.bootstrap").plugin()
end
