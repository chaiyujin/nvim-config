local M = {}

M.nvim_tree = {
   toggle = '<A-e>',
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

return M
