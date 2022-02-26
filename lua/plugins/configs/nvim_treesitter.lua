local M = {}

M.config = function()
   local present, ts_config = pcall(require, "nvim-treesitter.configs")
   if not present then
      return
   end

   local default = {
      ensure_installed = {
         "vim",
         "lua",
         "python",
         "cpp",
      },
      highlight = {
         enable = true,
         use_languagetree = true,
      },
   }

   ts_config.setup(default)
end

return M
