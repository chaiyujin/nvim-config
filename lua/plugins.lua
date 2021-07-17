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
    -- autopairs based on completion
    use {"windwp/nvim-autopairs"}

    -- treesitter
    use {"nvim-treesitter/nvim-treesitter", run=":TSUpdate"}
    -- commentary in lua
    use {"terrortylor/nvim-comment"}

    -- icons and file explorer
    use {"kyazdani42/nvim-web-devicons"}
    use {"kyazdani42/nvim-tree.lua"}
    use {"ahmedkhalf/lsp-rooter.nvim", config=function() require'lsp-rooter'.setup() end} -- with this nvim-tree will follow you
    -- use {"kevinhwang91/rnvimr"}

    -- terminal
    -- use {"akinsho/nvim-toggleterm.lua"}
    use {"numtostr/FTerm.nvim"}

    -- git
    use {"lewis6991/gitsigns.nvim", requires = {"nvim-lua/plenary.nvim"}, config=function() require("gitsigns").setup() end}
    use {"sindrets/diffview.nvim"}

    -- buffer line and status line
    use {"romgrk/barbar.nvim"}
    use {"glepnir/galaxyline.nvim"}

    -- Colorschemes
    -- use {"christianchiarulli/nvcode-color-schemes.vim"}
    -- use {"sunjon/shade.nvim", config=function() require'shade'.setup({overlay_opacity = 20}) end}
    use {"norcalli/nvim-colorizer.lua", config=function() require'colorizer'.setup() end}
    -- use {"projekt0n/github-nvim-theme"}

    -- indentline
    use {"lukas-reineke/indent-blankline.nvim"}
    -- use {"Yggdroot/indentLine"}

    -- which key
    use {"folke/which-key.nvim"}

    -- markdown
    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

    -- input
    -- use {"rlue/vim-barbaric"}
    use {"kevinhwang91/vim-ibus-sw"}

    -- config plugins
    require("config.lsp")
    require("config.treesitter")
    require("config.completion-nvim")
    require("config.nvim-autopairs")

    require("config.nvim-tree")
    -- require("config.rnvimr")
    -- require("config.nvim-toggleterm")
    require("config.FTerm")
    require("config.barbar")
    require("config.galaxyline")
    require("config.nvim-comment")
    require("config.indentLine")
    require("config.which-key")
    -- require("config.vim-barbaric")
    -- require("config.github-theme")
    require("config.diffview")

    -- config lsp servers
    require("config.lsp-servers.python")
end)
