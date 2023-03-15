local M = {
   "rafcamlet/tabline-framework.nvim",
   lazy = false,
   dependencies = { "nvim-web-devicons" },
}

M.config = function(_, _)
   local render = function(f)
      f.add { '   ', fg = "#bb0000" }
   
      f.make_bufs(function(info)
      f.add(' ' .. info.index .. ' ')
      f.add(info.filename or '[no name]')
      f.add ' '
      end)
   end
   require('tabline_framework').setup {
      -- Render function is resposible for generating content of tabline
      -- This is the place where you do your magic!
      render = render,
   }
end

return M