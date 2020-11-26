local actions = {}
local float = require'vimrc.lir.float'
local Actions = require'lir.actions'



local function is_float()
  return vim.w.lir_float
end


actions.quit = function()
  if is_float() then
    float.quit()
  else
    Actions.quit()
  end
end



actions.edit = function()
  if is_float() then
    float.edit()
  else
    Actions.edit()
  end
end



actions.split = function()
  if is_float() then
    float.split()
  else
    Actions.split()
  end
end


actions.vsplit = function()
  if is_float() then
    float.vsplit()
  else
    Actions.vsplit()
  end
end


actions.tabopen = function()
  if is_float() then
    float.tabopen()
  else
    Actions.tabopen()
  end
end


actions.newfile = function()
  if is_float() then
    float.newfile()
  else
    Actions.newfile()
  end
end

return actions
