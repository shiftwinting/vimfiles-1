local float = require'vimrc.lir.float'
local Actions = require'lir.actions'


local actions = {}
setmetatable(actions, {
  __index = function(t, key)
    return float[key] or Actions[key]
  end
})


return actions
