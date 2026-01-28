return {
   "levouh/tint.nvim",
   -- dependencies = {"barbecue"},  -- After barbecue so that it can tint winbar.
   lazy = false,
   opts = {
      tint = -10,  -- Darken colors, use a positive value to brighten
      saturation = 1.0,  -- Saturation to preserve
      tint_background_colors = true,  -- Tint background portions of highlight groups
      highlight_ignore_patterns = { "WinSeparator", "Status.*" },  -- Highlight group patterns to ignore, see `string.find`
      window_ignore_function = function(winid)
         local bufid = vim.api.nvim_win_get_buf(winid)
         local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
         local filetype = vim.api.nvim_buf_get_option(bufid, "ft")
         local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
         -- Do not tint `terminal` or floating windows, tint everything else
         return buftype == "terminal" or filetype == "NvimTree" or floating
      end
   },
   config = function(_, opts)
      opts = vim.tbl_deep_extend("force", opts, {
         transforms = require("tint").transforms.SATURATE_TINT,  -- Showing default behavior, but value here can be predefined set of transforms
      })
      require("tint").setup(opts)
   end
}
