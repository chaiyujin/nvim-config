local M = {}

local opts = {
   clipboard = "unnamedplus",
   cmdheight = 1,
   wrap = false,
   ruler = false,
   hidden = true,
   ignorecase = true,
   smartcase = true,
   showmode = false,
   signcolumn = "yes",
   mouse = "a",
   number = true,
   numberwidth = 2,
   relativenumber = true,
   expandtab = true,
   shiftwidth = 2,
   smartindent = true,
   tabstop = 4,
   softtabstop = 4,
   timeoutlen = 400,
   updatetime = 250,
   undofile = true,
   fillchars = { eob = " " },
   cursorline = true,
   termguicolors = true,
   guifont = 'Liga SFMono Nerd Font:h18:#e-subpixelantialias:#h-none',
   laststatus = 3,  -- global statusline
   statusline = "  %f %m %= %l:%c   ",
   showtabline = 2,
}

M.setup = function()
   for k, v in pairs(opts) do
      vim.opt[k] = v
   end
end

return M
