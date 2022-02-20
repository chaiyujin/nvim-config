local M = {}

-- Load and override config
M.load_config = function()
   -- load default config
   local conf = require "config.default"
   -- (optional) load from custom config and override
   local ok, conf_custom = pcall(require, "custom.config")
   if ok then
      conf = vim.tbl_deep_extend("force", conf, conf_custom)
   end
   return conf
end

-- Provide labels to plugins instead of integers
M.label_plugins = function(plugins)
   local plugins_labeled = {}
   for _, plugin in ipairs(plugins) do
      plugins_labeled[plugin[1]] = plugin
   end
   return plugins_labeled
end


M.map = function(mode, keys, command, opt)
   if not keys or keys == "" then
      return
   end

   local options = { noremap = true, silent = true }
   if opt then
      options = vim.tbl_extend("force", options, opt)
   end

   -- all valid modes allowed for mappings
   -- :h map-modes
   local valid_modes = {
      [""] = true,
      ["n"] = true,
      ["v"] = true,
      ["s"] = true,
      ["x"] = true,
      ["o"] = true,
      ["!"] = true,
      ["i"] = true,
      ["l"] = true,
      ["c"] = true,
      ["t"] = true,
   }

   -- helper function for M.map
   -- can gives multiple modes and keys
   local function map_wrapper(sub_mode, lhs, rhs, sub_options)
      if type(lhs) == "table" then
         for _, key in ipairs(lhs) do
            map_wrapper(sub_mode, key, rhs, sub_options)
         end
      else
         if type(sub_mode) == "table" then
            for _, m in ipairs(sub_mode) do
               map_wrapper(m, lhs, rhs, sub_options)
            end
         else
            if valid_modes[sub_mode] and lhs and rhs then
               vim.api.nvim_set_keymap(sub_mode, lhs, rhs, sub_options)
            else
               sub_mode, lhs, rhs = sub_mode or "", lhs or "", rhs or ""
               print(
                  "Cannot set mapping [ mode = '" .. sub_mode .. "' | key = '" .. lhs .. "' | cmd = '" .. rhs .. "' ]"
               )
            end
         end
      end
   end

   map_wrapper(mode, keys, command, options)
end

return M
