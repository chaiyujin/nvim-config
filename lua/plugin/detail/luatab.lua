local M = {
   'alvarosevilla95/luatab.nvim',
   dependencies = { "nvim-web-devicons" },
   lazy = false,
   opts = {},
}

local title = function(buf)
   local bufnr = buf["bufnr"]
   local file = buf["name"]
   local buftype = vim.fn.getbufvar(bufnr, '&buftype')
   local filetype = vim.fn.getbufvar(bufnr, '&filetype')

   if buftype == 'help' then
      return 'help:' .. vim.fn.fnamemodify(file, ':t:r')
   elseif buftype == 'quickfix' then
      return 'quickfix'
   elseif filetype == 'TelescopePrompt' then
      return 'Telescope'
   elseif filetype == 'git' then
      return 'Git'
   elseif filetype == 'fugitive' then
      return 'Fugitive'
   elseif file:sub(file:len()-2, file:len()) == 'FZF' then
      return 'FZF'
   elseif buftype == 'terminal' then
      local _, mtch = string.match(file, "term:(.*):(%a+)")
      return mtch ~= nil and mtch or vim.fn.fnamemodify(vim.env.SHELL, ':t')
   elseif file == '' then
      return '[No Name]'
   else
      return vim.fn.pathshorten(vim.fn.fnamemodify(file, ':p:~:t'))
   end
end

local modified = function(buf)
   return vim.fn.getbufvar(buf["bufnr"], '&modified') == 1 and '[+] ' or ''
end

local devicon = function(buf, isSelected)
   local icon, devhl
   local bufnr = buf["bufnr"]
   local file = buf["name"]
   local buftype = vim.fn.getbufvar(bufnr, '&buftype')
   local filetype = vim.fn.getbufvar(bufnr, '&filetype')
   local devicons = require'nvim-web-devicons'
   if filetype == 'TelescopePrompt' then
      icon, devhl = devicons.get_icon('telescope')
   elseif filetype == 'fugitive' then
      icon, devhl = devicons.get_icon('git')
   elseif filetype == 'vimwiki' then
      icon, devhl = devicons.get_icon('markdown')
   elseif buftype == 'terminal' then
      icon, devhl = devicons.get_icon('zsh')
   else
      icon, devhl = devicons.get_icon(file, vim.fn.expand('#'..bufnr..':e'))
   end
   if icon then
      local h = require'luatab.highlight'
      local fg = h.extract_highlight_colors(devhl, 'fg')
      local bg = h.extract_highlight_colors('TabLineSel', 'bg')
      local hl = h.create_component_highlight_group({bg = bg, fg = fg}, devhl)
      local selectedHlStart = (isSelected and hl) and '%#'..hl..'#' or ''
      local selectedHlEnd = isSelected and '%#TabLineSel#' or ''
      return selectedHlStart .. icon .. selectedHlEnd .. ' '
   end
   return ''
end

local separator = function(index)
   return (index < vim.fn.tabpagenr('$') and '%#TabLine#|' or '')
end

local cell = function(index, buf)
   local bufnr = vim.fn.bufnr()
   local isSelected = bufnr == buf["bufnr"]
   local hl = (isSelected and '%#TabLineSel#' or '%#TabLine#')

   return hl .. '%' .. index .. 'T' .. ' ' ..
      title(buf) .. ' ' ..
      modified(buf) ..
      devicon(buf, isSelected) .. '%T' ..
      separator(index)
end

local tabline = function()
   local line = ''
   local bufs = vim.fn.getbufinfo({buflisted = 1})
   for i, buf in ipairs(bufs) do
      -- if i > 1 then
      --    -- TODO: spliter
      --    line = line .. "|"
      -- end
      line = line .. cell(i, buf)
   end
   line = line .. '%#TabLineFill#%='
   return line
end

M.config = function(_, opts)
   require('luatab').setup({
      tabline=tabline
   })
end

return M
