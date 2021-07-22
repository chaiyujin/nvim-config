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

  -- terminal
  use {"voldikss/vim-floaterm"}

  -- git
  use {"lewis6991/gitsigns.nvim", requires = {"nvim-lua/plenary.nvim"}, config=function() require("gitsigns").setup() end}
  use {"sindrets/diffview.nvim"}

  -- buffer line and status line
  use {"romgrk/barbar.nvim"}
  use {"glepnir/galaxyline.nvim"}

  -- colors
  use {"norcalli/nvim-colorizer.lua", config=function() require'colorizer'.setup() end}

  -- indentline
  use {"Yggdroot/indentLine"}

  -- which key
  use {"folke/which-key.nvim"}

  -- dashboard
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
  use {"glepnir/dashboard-nvim", requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {"nvim-telescope/telescope.nvim"}}}

  -- markdown
  use {'iamcco/markdown-preview.nvim', opt = true, run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- latex
  use {"lervag/vimtex", opt = true, config = function() require("config.vimtex") end}

  -- ibus
  use {"kevinhwang91/vim-ibus-sw"}

  -- playground for debug treesitter
  use {"nvim-treesitter/playground", config = function()
    require "nvim-treesitter.configs".setup {
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      }
    }
  end}

  -- config plugins
  require("config.lsp")
  require("config.treesitter")
  require("config.completion-nvim")
  require("config.nvim-autopairs")
  require("config.nvim-tree")
  require("config.vim-floaterm")
  require("config.barbar")
  require("config.galaxyline")
  require("config.nvim-comment")
  require("config.indentLine")
  require("config.which-key")
  require("config.dashboard")
  require("config.diffview")    

end)
