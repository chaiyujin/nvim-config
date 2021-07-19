local tree = {}

tree.open = function()
  local view_status_ok, view = pcall(require, "nvim-tree.view")
  if not view_status_ok then
    return
  end
  
  if not view.win_open() then
    if package.loaded["bufferline.state"] then
      require("bufferline.state").set_offset(31, "")
    end
    require("nvim-tree").find_file(true)
  end
end

tree.toggle = function()
  local view_status_ok, view = pcall(require, "nvim-tree.view")
  if not view_status_ok then
    return
  end

  if view.win_open() then
    -- Close NvimTree
    require("nvim-tree").close()
    -- Offset the bufferline
    if package.loaded["bufferline.state"] then
      require("bufferline.state").set_offset(0)
    end
  else
    -- Open NvimTree
    if vim.g.nvim_tree_follow == 1 then
      require("nvim-tree").find_file(true)
    end
    if not view.win_open() then
      require("nvim-tree.lib").open()
    end
    -- Offset the bufferline
    local width = view.View.width
    if package.loaded["bufferline.state"] then
      -- Extra 1 char for VertSplit
      require("bufferline.state").set_offset(width + 1, "FILE EXPLORER")
    end
  end
end

return tree

