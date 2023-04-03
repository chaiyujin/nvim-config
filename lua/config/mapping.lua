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
   toggle = "<C-e>",
}

M.better_escape = {
   esc_insertmode = "jk",
}

return M
