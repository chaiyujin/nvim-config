vim.g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open
vim.g.nvim_tree_quit_on_open = 0 -- 0 by default, closes the tree when you open a file
vim.g.nvim_tree_root_folder_modifier = ':t' -- ':~' is the default. See :help filename-modifiers for more options

vim.g.nvim_tree_auto_ignore_ft = {
  'startify', 'dashboard',
} -- "empty by default, don't auto open tree on specific filetypes.

vim.g.nvim_tree_show_icons = {git = 1, folders = 1, files = 1}
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {unstaged = "", staged = "", unmerged = "", renamed = "➜", untracked = ""},
  folder = {default = "", open = "ﱮ", empty = "", empty_open = "", symlink = ""}
}

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
local tree_mappings = {
  { key = {"<CR>", "o", "l", "<2-LeftMouse>"}, cb = tree_cb("edit") },
  { key = {"<C-]>", "<2-RightMouse>"},         cb = tree_cb("cd") },
  { key = "v",                                 cb = tree_cb("vsplit") },
  { key = "s",                                 cb = tree_cb("split") },
  { key = "<C-t>",                             cb = tree_cb("tabnew") },
  { key = "<",                                 cb = tree_cb("prev_sibling") },
  { key = ">",                                 cb = tree_cb("next_sibling") },
  { key = {"<BS>", "h", "<S-CR>"},             cb = tree_cb("close_node") },
  { key = "<Tab>",                             cb = tree_cb("preview") },
  { key = "I",                                 cb = tree_cb("toggle_ignored") },
  { key = "H",                                 cb = tree_cb("toggle_dotfiles") },
  { key = "R",                                 cb = tree_cb("refresh") },
  { key = "a",                                 cb = tree_cb("create") },
  { key = "d",                                 cb = tree_cb("remove") },
  { key = "r",                                 cb = tree_cb("rename") },
  { key = "<C-r>",                             cb = tree_cb("full_rename") },
  { key = "x",                                 cb = tree_cb("cut") },
  { key = "c",                                 cb = tree_cb("copy") },
  { key = "p",                                 cb = tree_cb("paste") },
  { key = "[c",                                cb = tree_cb("prev_git_item") },
  { key = "]c",                                cb = tree_cb("next_git_item") },
  { key = "-",                                 cb = tree_cb("dir_up") },
  { key = "q",                                 cb = tree_cb("close") },
}

require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = { '__pycache__' },
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = true,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = tree_mappings
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes"
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  }
}