-- Install packer 
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    vim.api.nvim_command "packadd packer.nvim"
end

-- Auto compile when there are changes in plugins.lua
vim.cmd "autocmd BufWritePost plugins.lua PackerCompile"

-- Require plugins
return require("packer").startup(function (use)
    use "wbthomason/packer.nvim"

    -- lsp config and install
    use {"neovim/nvim-lspconfig"}
    use {"kabouzeid/nvim-lspinstall"}
    -- lsp based tools
    -- use {"glepnir/lspsaga.nvim", opt=true}
    -- lsp based auto completion
    use {"nvim-lua/completion-nvim"}

    -- treesitter
    use {"nvim-treesitter/nvim-treesitter", run=":TSUpdate"}
    -- autopairs based treesitter
    use {"windwp/nvim-autopairs"}
    -- commentary in lua
    use {"terrortylor/nvim-comment"}

    -- icons and file explorer
    use {"kyazdani42/nvim-web-devicons"}
    use {"kyazdani42/nvim-tree.lua"}

    -- buffer line and status line
    use {"romgrk/barbar.nvim"}
    use {"glepnir/galaxyline.nvim"}

    -- config plugins
    require("config.lsp")
    require("config.treesitter")
    require('nvim_comment').setup()
    require("config.nvim-tree")
    require("config.barbar")
    require("config.galaxyline")

    -- config lsp servers
    require("config.lsp-servers.python")
end)