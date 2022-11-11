local M = {}

M.config = function()
   local present, ts_config = pcall(require, "nvim-treesitter.configs")
   if not present then
      return
   end

   local default = {
      ensure_installed = {
         "vim", "lua", "bash", "python", "cpp",
      },
      highlight = {
         enable = true,
         additional_vim_regex_highlighting = false,
      },
   }

   ts_config.setup(default)
end

return M
