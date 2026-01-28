if vim.g.vscode then
   -- vscode-neovim.
   vim.cmd[[xmap gc  <Plug>VSCodeCommentary]]
   vim.cmd[[nmap gc  <Plug>VSCodeCommentary]]
   vim.cmd[[omap gc  <Plug>VSCodeCommentary]]
   vim.cmd[[nmap gcc <Plug>VSCodeCommentaryLine]]
else
   -- neovim.
   require("config.basic").setup()
   require("config.lazy").setup()
end
