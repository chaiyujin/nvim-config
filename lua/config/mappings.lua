local M = {}

-- Window

M.window_nav = {
   move_left = "<A-h>",
   move_right = "<A-l>",
   move_down = "<A-j>",
   move_up = "<A-k>",
}

M.window_resize = {
   inc_height = "<C-Up>",
   dec_height = "<C-Down>",
   inc_width = "<C-Right>",
   dec_width = "<C-Left>",
}

-- Plugins

M.floaterm = {
   toggle = "<C-j>"
}

M.buffer = {
   close_buffer = "<A-q>",
   prev_buffer = "<A-,>",
   next_buffer = "<A-.>",
   move_prev = "<A-Left>",
   move_next = "<A-Right>",
}

M.nvim_tree = {
   toggle = "<A-e>",
   actions = {
      { key = {"<CR>", "o", "l", "<2-LeftMouse>"}, action = "edit" },
      { key = {"<C-]>", "<2-RightMouse>"},         action = "cd"},
      { key = "v",                                 action = "vsplit"},
      { key = "s",                                 action = "split"},
      { key = "<C-t>",                             action = "tabnew"},
      { key = "<",                                 action = "prev_sibling"},
      { key = ">",                                 action = "next_sibling"},
      { key = {"<BS>", "h", "<S-CR>"},             action = "close_node"},
      { key = "<Tab>",                             action = "preview"},
      { key = "I",                                 action = "toggle_ignored"},
      { key = "H",                                 action = "toggle_dotfiles"},
      { key = "R",                                 action = "refresh"},
      { key = "a",                                 action = "create"},
      { key = "d",                                 action = "remove"},
      { key = "r",                                 action = "rename"},
      { key = "<C-r>",                             action = "full_rename"},
      { key = "x",                                 action = "cut"},
      { key = "c",                                 action = "copy"},
      { key = "p",                                 action = "paste"},
      { key = "[c",                                action = "prev_git_item"},
      { key = "]c",                                action = "next_git_item"},
      { key = "-",                                 action = "dir_up"},
      { key = "q",                                 action = "close"},
   }
}

M.better_escape = {
   esc_insertmode = "jk",
}

return M
