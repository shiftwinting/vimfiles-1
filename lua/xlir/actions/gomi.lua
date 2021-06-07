local lir = require('lir')
local utils = require('lir.utils')
local actions = require('lir.actions')

local function esc_path(path)
  return vim.fn.shellescape(vim.fn.fnamemodify(path, ':p'), true)
end

local function gomi()
  local ctx = lir.get_context()
  -- 選択されているものを取得する
  local marked_items = ctx:get_marked_items()
  if #marked_items == 0 then
    utils.error('Please mark one or more.')
    -- -- 選択されていなければ、カレント行を削除
    -- local path = ctx.dir .. ctx:current_value()
    -- vim.fn.system('gomi ' .. esc_path(path))
    -- actions.reload()
    return
  end

  local path_list = vim.tbl_map(function(items)
    return esc_path(items.fullpath)
  end, marked_items)
  -- for _, f in ipairs(marked_items) do
  --     -- TODO:
  --     -- 確認する
  --     -- "これ以降、同じ" みたいなこともしたい
  -- end
  if vim.fn.confirm('Delete files?', '&Yes\n&No', 2) ~= 1 then
    return
  end
  vim.fn.system('gomi ' .. vim.fn.join(path_list))
  actions.reload()
end

return gomi
