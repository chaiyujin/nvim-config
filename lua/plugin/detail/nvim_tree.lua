local utils = require("core.utils")
local map_cfg = utils.load_config().mapping.nvim_tree
local M = {"nvim-tree/nvim-tree.lua"}

-- Lazy-load on command
M.cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" }

-- `init` functions are always executed during startup
M.init = function()
   utils.map("n", map_cfg.toggle, ":NvimTreeToggle<CR>")
   utils.map("t", map_cfg.toggle, "<C-\\><C-n>:NvimTreeToggle<CR>")
end

-- The table will be passed to the Plugin.config() function.
-- Setting this value will imply Plugin.config().
M.opts = function() return {
   filters = {
      dotfiles = true,
      git_clean = false,
      no_buffer = false,
      custom = {".DS_Store"},
      exclude = {".gitignore"},
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
   on_attach = M._on_attach,
   view = {
      width = 30,
      side = 'left',
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
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
      root_folder_label = false,
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
            default = "",
            symlink = "",
            folder = {
               default = "",
               open = "",
               empty = "",
               empty_open = "",
               symlink = "",
               symlink_open = "",
               arrow_open = "",
               arrow_closed = "",
            },
            git = {
               deleted = "",
               ignored = "◌",
               renamed = "➜",
               staged = "✓",
               unmerged = "",
               unstaged = "✗",
               untracked = "★",
            },
         },
      },
   },
} end

-- packer config callback, after loading plugin
M.config = function(_, opts)
   require("nvim-tree").setup(opts)
end

M._on_attach = function(bufnr)
   local api = require('nvim-tree.api')
 
   local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
   end

   MouseR = '<2-RightMouse>'
   MouseL = '<2-LeftMouse>'
 
   -- Default mappings. Feel free to modify or remove as you wish.
   --
   -- BEGIN_DEFAULT_ON_ATTACH
   vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
   vim.keymap.set('n', MouseR,  api.tree.change_root_to_node,          opts('CD'))
   vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                     opts('Rename: Omit Filename'))
   vim.keymap.set('n', 'r',     api.fs.rename,                         opts('Rename'))
   vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              opts('Info'))
   vim.keymap.set('n', '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
   vim.keymap.set('n', '<C-x>', api.node.open.horizontal,              opts('Open: Horizontal Split'))
   vim.keymap.set('n', 'l',     api.node.open.edit,                    opts('Open'))
   vim.keymap.set('n', '<CR>',  api.node.open.edit,                    opts('Open'))
   vim.keymap.set('n', MouseL,  api.node.open.edit,                    opts('Open'))
   vim.keymap.set('n', 'h',     api.node.navigate.parent_close,        opts('Close Directory'))
   vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
   vim.keymap.set('n', '<Tab>', api.node.open.preview,                 opts('Open Preview'))
   vim.keymap.set('n', 'c',     api.fs.copy.node,                      opts('Copy'))
   vim.keymap.set('n', 'd',     api.fs.remove,                         opts('Delete'))
   vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,         opts('Toggle Dotfiles'))
   vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,      opts('Toggle Git Ignore'))
   vim.keymap.set('n', 'x',     api.fs.cut,                            opts('Cut'))
   vim.keymap.set('n', 'y',     api.fs.copy.filename,                  opts('Copy Name'))
   vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
   vim.keymap.set('n', 'R',     api.tree.reload,                       opts('Refresh'))
   vim.keymap.set('n', 'p',     api.fs.paste,                          opts('Paste'))
   vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))

   vim.keymap.set('n', '<C-t>', api.node.open.tab,                     opts('Open: New Tab'))
   vim.keymap.set('n', '>',     api.node.navigate.sibling.next,        opts('Next Sibling'))
   vim.keymap.set('n', '<',     api.node.navigate.sibling.prev,        opts('Previous Sibling'))
   vim.keymap.set('n', '.',     api.node.run.cmd,                      opts('Run Command'))
   vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        opts('Up'))
   vim.keymap.set('n', 'a',     api.fs.create,                         opts('Create'))
   vim.keymap.set('n', 'bmv',   api.marks.bulk.move,                   opts('Move Bookmarked'))
   vim.keymap.set('n', 'B',     api.tree.toggle_no_buffer_filter,      opts('Toggle No Buffer'))
   vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Git Clean'))
   vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
   vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
   vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
   vim.keymap.set('n', 'E',     api.tree.expand_all,                   opts('Expand All'))
   vim.keymap.set('n', 'e',     api.fs.rename_basename,                opts('Rename: Basename'))
   vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
   vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
   vim.keymap.set('n', 'F',     api.live_filter.clear,                 opts('Clean Filter'))
   vim.keymap.set('n', 'f',     api.live_filter.start,                 opts('Filter'))
   vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  opts('Help'))
   vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
   vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
   vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
   vim.keymap.set('n', 'm',     api.marks.toggle,                      opts('Toggle Bookmark'))
   vim.keymap.set('n', 'O',     api.node.open.no_window_picker,        opts('Open: No Window Picker'))
   vim.keymap.set('n', 'P',     api.node.navigate.parent,              opts('Parent Directory'))
   vim.keymap.set('n', 's',     api.node.run.system,                   opts('Run System'))
   vim.keymap.set('n', 'S',     api.tree.search_node,                  opts('Search'))
   vim.keymap.set('n', 'U',     api.tree.toggle_custom_filter,         opts('Toggle Hidden'))
   vim.keymap.set('n', 'W',     api.tree.collapse_all,                 opts('Collapse'))
   -- END_DEFAULT_ON_ATTACH
 
   -- Mappings removed via:
   --   remove_keymaps
   --   OR
   --   view.mappings.list..action = ""
   --
   -- The dummy set before del is done for safety, in case a default mapping does not exist.
   --
   -- You might tidy things by removing these along with their default mapping.
   vim.keymap.set('n', 'O', '', { buffer = bufnr })
   vim.keymap.del('n', 'O', { buffer = bufnr })
   vim.keymap.set('n', '<2-RightMouse>', '', { buffer = bufnr })
   vim.keymap.del('n', '<2-RightMouse>', { buffer = bufnr })
   vim.keymap.set('n', 'D', '', { buffer = bufnr })
   vim.keymap.del('n', 'D', { buffer = bufnr })
   vim.keymap.set('n', 'E', '', { buffer = bufnr })
   vim.keymap.del('n', 'E', { buffer = bufnr })
 
 
   -- Mappings migrated from view.mappings.list
   --
   -- You will need to insert "your code goes here" for any mappings with a custom action_cb
   vim.keymap.set('n', 'A', api.tree.expand_all, opts('Expand All'))
   vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
   vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
   vim.keymap.set('n', 'P', function()
      local node = api.tree.get_node_under_cursor()
      print(node.absolute_path)
   end, opts('Print Node Path'))
 
   vim.keymap.set('n', 'Z', api.node.run.system, opts('Run System'))
end

return M
