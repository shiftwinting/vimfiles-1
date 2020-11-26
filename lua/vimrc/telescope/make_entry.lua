local make_entory = {}


function make_entory.gen_from_openbrowser(opts)
  opts = opts or {}

  return function(entry)
    return {
      value = entry.url,
      ordinal = entry.name .. ' ' .. entry.url,
      display = entry.name .. ' ' .. entry.url,
    }
  end
end


return make_entory
