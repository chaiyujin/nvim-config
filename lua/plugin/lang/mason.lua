local M = {
   "williamboman/mason.nvim",
   cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
}

M.init = function()
   local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
   vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"
end

M.opts = {
   ensure_installed = { "lua-language-server", "pyright" }, -- not an option from mason.nvim
   PATH = "skip",
   ui = {
      icons = {
         package_pending = " ",
         package_installed = " ",
         package_uninstalled = " ﮊ",
      },
      keymaps = {
         toggle_server_expand = "<CR>",
         install_server = "i",
         update_server = "u",
         check_server_version = "c",
         update_all_servers = "U",
         check_outdated_servers = "C",
         uninstall_server = "X",
         cancel_installation = "<C-c>",
      },
   },
   max_concurrent_installers = 10,
}

---comment
---@param lazy any
---@param opts table
M.config = function(lazy, opts)
   require("mason").setup(opts)
   -- custom nvchad cmd to install all mason binaries listed
   vim.api.nvim_create_user_command("MasonInstallAll", function()
     vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
   end, {})
end

return M
