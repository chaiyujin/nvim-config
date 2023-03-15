local utils = require("core.utils")
local cfg = utils.load_config()
local M = {}

M.plugins = function(lazypath)
   -- Make sure lazy.nvim is installed.
   if lazypath == nil or lazypath == '' then
      lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
   end
   if not vim.loop.fs_stat(lazypath) then
      print "[lazy.nvim] Cloning ..."
      vim.fn.system({
         "git",
         "clone",
         "--filter=blob:none",
         "https://github.com/folke/lazy.nvim.git",
         "--branch=stable", -- latest stable release
         lazypath,
      })
      print "[lazy.nvim] Done!"
   end
   vim.opt.rtp:prepend(lazypath)

   -- lazy_nvim startup opts
   -- local lazy_config = vim.tbl_deep_extend("force", require "plugins.configs.lazy_nvim", config.lazy_nvim)
   local plugins = require("plugin").default_plugins
   local lazy_opt = require("plugin.detail.lazy")

   require("lazy").setup(plugins, lazy_opt)
   vim.api.nvim_buf_delete(0, { force = true }) -- close lazy window
end

M.nvim_opts = function()
   vim.g.mapleader = cfg.mapleader
   for k, v in pairs(cfg.opt) do
      vim.opt[k] = v
   end
end

M.basic_mappings = function()
   local m = cfg.mappings
   local map = utils.map

   -- Window Navigation
   map('n', m.window_nav.move_left,  '<C-w>h')
   map('n', m.window_nav.move_right, '<C-w>l')
   map('n', m.window_nav.move_down,  '<C-w>j')
   map('n', m.window_nav.move_up,    '<C-w>k')
   map('i', m.window_nav.move_left,  '<C-\\><C-n><C-w>h')
   map('i', m.window_nav.move_right, '<C-\\><C-n><C-w>l')
   map('i', m.window_nav.move_down,  '<C-\\><C-n><C-w>j')
   map('i', m.window_nav.move_up,    '<C-\\><C-n><C-w>k')
   map('t', m.window_nav.move_left,  '<C-\\><C-n><C-w>h')
   map('t', m.window_nav.move_right, '<C-\\><C-n><C-w>l')
   map('t', m.window_nav.move_down,  '<C-\\><C-n><C-w>j')
   map('t', m.window_nav.move_up,    '<C-\\><C-n><C-w>k')
   map('t', '<Esc>', '<C-\\><C-n>')

   -- Resize window with arrows
   map('n', m.window_resize.inc_height, ':resize +2<CR>')
   map('n', m.window_resize.dec_height, ':resize -2<CR>')
   map('n', m.window_resize.inc_width,  ':vertical resize +2<CR>')
   map('n', m.window_resize.dec_width,  ':vertical resize -2<CR>')
   map('t', m.window_resize.inc_height, '<C-\\><C-n>:resize +2<CR>')
   map('t', m.window_resize.dec_height, '<C-\\><C-n>:resize -2<CR>')
   map('t', m.window_resize.inc_width,  '<C-\\><C-n>:vertical resize +2<CR>')
   map('t', m.window_resize.dec_width,  '<C-\\><C-n>:vertical resize -2<CR>')
   
   -- Indenting without de-selection
   map('v', '<', '<gv')
   map('v', '>', '>gv')

   -- Move selected line / block of text in visual mode
   -- map('x', 'K', ':move \'<-2<CR>gv-gv')
   -- map('x', 'J', ':move \'>+1<CR>gv-gv')

   -- Highlight
   -- map('n', '<Leader>h', ':set hlsearch!<CR>')
end

return M
