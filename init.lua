if vim.g.vscode then
   -- vscode-neovim.
   vim.cmd[[xmap gc  <Plug>VSCodeCommentary]]
   vim.cmd[[nmap gc  <Plug>VSCodeCommentary]]
   vim.cmd[[omap gc  <Plug>VSCodeCommentary]]
   vim.cmd[[nmap gcc <Plug>VSCodeCommentaryLine]]
else
   -- neovim.
   require("core.bootstrap").nvim_opt()
   require("core.bootstrap").basic_mapping()
   require("core.bootstrap").plugin()
end
