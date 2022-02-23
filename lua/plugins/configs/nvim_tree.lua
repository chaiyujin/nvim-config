local utils = require("core.utils")
local map_cfg = utils.load_config().mappings.nvim_tree
local M = {}

-- packer setup callback, before loading plugin
M.setup = function()
   utils.map("n", map_cfg.toggle, ":NvimTreeToggle <CR>")
   utils.map("t", map_cfg.toggle, "<C-\\><C-n>:NvimTreeToggle <CR>")
end

-- packer config callback, after loading plugin
M.config = function()
   local present, nvim_tree = pcall(require, "nvim-tree")
   if not present then
      return
   end

   local g = vim.g

   g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
   g.nvim_tree_git_hl = 0
   g.nvim_tree_highlight_opened_files = 0
   g.nvim_tree_indent_markers = 1
   g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened
   g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }

   g.nvim_tree_show_icons = {
      folders = 1,
      files = 1,
      git = 1,
   }

   g.nvim_tree_icons = {
      default = "",
      symlink = "",
      git = {
         deleted = "",
         ignored = "◌",
         renamed = "➜",
         staged = "✓",
         unmerged = "",
         unstaged = "✗",
         untracked = "★",
      },
      folder = {
         default = "",
         empty = "",
         empty_open = "",
         open = "",
         symlink = "",
         symlink_open = "",
      },
   }

   local default = {
      filters = {
         dotfiles = false,
      },
      disable_netrw = true,
      hijack_netrw = true,
      ignore_ft_on_setup = { "dashboard" },
      auto_close = false,
      open_on_tab = false,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      update_cwd = true,
      update_focused_file = {
         enable = true,
         update_cwd = false,
      },
      view = {
         allow_resize = true,
         hide_root_folder = true,
         width = 30,
         height = 30,
         side = 'left',
         auto_resize = false,
         mappings = {
         custom_only = false,
         list = map_cfg.actions
         },
         number = false,
         relativenumber = false,
         signcolumn = "yes"
      },
      git = {
         enable = false,
         ignore = false,
      },
      actions = {
         change_dir = {
            enable = true,
            global = false,
         },
         open_file = {
            quit_on_open = false,
            window_picker = {
               enable = true,
               chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
               exclude = {
                  filetype = { "notify", "packer", "qf" },
                  buftype = { "terminal" },
               }
            }
         },
      }
   }

   nvim_tree.setup(default)
end

return M
