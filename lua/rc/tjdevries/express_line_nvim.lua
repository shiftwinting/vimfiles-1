do return end

local extensions = require('el.extensions')

local generator = function(win_id, buffer)
  local seg = {}

  table.insert(seg, extensions.mode)
end

require('el').setup({generator = generator})
