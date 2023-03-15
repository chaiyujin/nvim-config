local M = {
   "nvim-treesitter/nvim-treesitter",
   event = "BufRead",
   build = ":TSUpdate",
}

M.opts = {
   ensure_installed = {
      "vim", "lua", "python", "cpp", "bash", "yaml", "toml"
   },
   auto_install = false,
   highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
   },
}

M.config = function(_, opts)
   require("nvim-treesitter.configs").setup(opts)
end

return M
