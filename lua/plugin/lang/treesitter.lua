local M = {
   "nvim-treesitter/nvim-treesitter",
   event = "BufRead",
   build = ":TSUpdate",
}

M.opts = {
   ensure_installed = {
      "vim", "lua", "python", "cpp", "bash", "yaml", "toml", "rust"
   },
   auto_install = false,
   highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
   },
}

M.config = function(_, opts)
   require("nvim-treesitter.configs").setup(opts)

   -- Rescript.
   local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
   parser_config.rescript = {
     install_info = {
       url = "https://github.com/nkrkv/nvim-treesitter-rescript",
       files = { "tree-sitter-rescript/src/parser.c", "tree-sitter-rescript/src/scanner.c" },
       location = "tree-sitter-rescript/rescript",
       branch = "main",
     },
     filetype = "res",
   }
end

return M
