local utils = require("core.utils")
local map_cfg = utils.load_config().mappings.nvim_tree
local M = {}

-- packer setup callback, before loading plugin
M.setup = function()
   utils.map("n", map_cfg.toggle, ":NvimTreeToggle<CR>")
   utils.map("t", map_cfg.toggle, "<C-\\><C-n>:NvimTreeToggle<CR>")
end

-- packer config callback, after loading plugin
M.config = function()
   local present, nvim_tree = pcall(require, "nvim-tree")
   if not present then
      return
   end

   local g = vim.g

   local default = {
      filters = {
         dotfiles = false,
      },
      disable_netrw = true,
      hijack_netrw = true,
      open_on_tab = false,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      update_cwd = true,
      update_focused_file = {
         enable = true,
         update_cwd = false,
      },
      view = {
         width = 30,
         hide_root_folder = true,
         side = 'left',
         preserve_window_proportions = false,
         number = false,
         relativenumber = false,
         signcolumn = "yes",
         mappings = {
            custom_only = false,
            list = map_cfg.actions
         },
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
      },
      renderer = {
         root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" },
         add_trailing = false, -- append a trailing slash to folder names
         highlight_git = true,
         highlight_opened_files = "all",  -- none, icon, name, all
         indent_markers = {
            enable = true,
         },
         icons = {
            show = {
               folder = true,
               file = true,
               git = true,

            },
            glyphs = {
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
            },
         },
      },
   }

   nvim_tree.setup(default)
end

return M
