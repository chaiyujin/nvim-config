local M = {}

-- Window

M.window_nav = {
   move_left  = "<M-h>",
   move_right = "<M-l>",
   move_down  = "<M-j>",
   move_up    = "<M-k>",
}

M.window_resize = {
   inc_height = "<C-S-Up>",
   dec_height = "<C-S-Down>",
   inc_width  = "<C-S-Right>",
   dec_width  = "<C-S-Left>",
}

-- Plugins

M.floaterm = {
   toggle = "<M-t>"
}

M.buffer = {
   close_buffer = "<M-x>",
   prev_buffer  = "<M-,>",
   next_buffer  = "<M-.>",
   move_prev    = "<C-M-,>",
   move_next    = "<C-M-.>",
}

M.nvim_tree = {
   toggle = "<M-e>",
   actions = {
      { key = {"<CR>", "o", "l", "<2-LeftMouse>"}, action = "edit" },
      { key = {"<C-]>", "<2-RightMouse>"},         action = "cd"},
      { key = "v",                                 action = "vsplit"},
      { key = "s",                                 action = "split"},
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
      { key = "x",                                 action = "cut"},
      { key = "c",                                 action = "copy"},
      { key = "p",                                 action = "paste"},
      { key = "[c",                                action = "prev_git_item"},
      { key = "]c",                                action = "next_git_item"},
      { key = "-",                                 action = "dir_up"},
      { key = "q",                                 action = "close"},
      -- { key = "<C-t>",                             action = "tabnew"},
      -- { key = "<C-r>",                             action = "full_rename"},
   }
}

M.better_escape = {
   esc_insertmode = "jk",
}

return M
