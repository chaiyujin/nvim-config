local cfg = require("core.utils").load_config()
local M = {}

M.better_escape = function()
   require("better_escape").setup {
      mapping = cfg.mappings.better_escape.esc_insertmode,
      timeout = cfg.plugins.better_escape.esc_insertmode_timeout,
   }
end

return M
