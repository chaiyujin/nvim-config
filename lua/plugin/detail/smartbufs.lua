local utils = require("core.utils")
local cfg = utils.load_config()
local map_cfg = cfg.mapping.buffer

local M = {
   'johann2357/nvim-smartbufs',
   lazy = false,
}

M.init = function()
   utils.map("n", map_cfg.next_buffer,  ":lua require('nvim-smartbufs').goto_next_buffer()<CR>")
   utils.map("n", map_cfg.prev_buffer,  ":lua require('nvim-smartbufs').goto_prev_buffer()<CR>")
   utils.map("i", map_cfg.next_buffer,  "<C-\\><C-n>:lua require('nvim-smartbufs').goto_next_buffer()<CR>")
   utils.map("i", map_cfg.prev_buffer,  "<C-\\><C-n>:lua require('nvim-smartbufs').goto_prev_buffer()<CR>")
   utils.map("n", map_cfg.close_buffer, ":lua require('nvim-smartbufs').close_current_buffer()<CR>")
   -- utils.map("n", map_cfg.move_next,    ":lua require('nvim-smartbufs').goto_next_buffer()<CR>")
   -- utils.map("n", map_cfg.move_prev,    ":lua require('nvim-smartbufs').goto_prev_buffer()<CR>")
   -- utils.map("n", map_cfg.pick_buffer,  ":BufferPick<CR>")
end

M.config = function(_, _)
end

return M
