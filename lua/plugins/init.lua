-- Install packer 
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
   print("Cloning packer.nvim")
   packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
   vim.api.nvim_command "packadd packer.nvim"
end

-- Auto compile when there are changes in plugins.lua
-- vim.cmd "autocmd BufWritePost lua/plugins/*.lua PackerCompile"

return require('packer').startup(function(use)
   -- Packer can manage itself
   use 'wbthomason/packer.nvim'

   -- My plugins here
   plugins = require("plugins.users")
   plugins = require("core.utils").label_plugins(plugins)
   for k, v in pairs(plugins) do
      use(v)
   end

   -- Automatically set up your configuration after cloning packer.nvim
   -- Put this at the end after all plugins
   if packer_bootstrap then
      require('packer').sync()
   end
end)
