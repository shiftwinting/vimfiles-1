local ls = require('luasnip')

-- ls.parser.parse_snippet(nil, ...) とすると sn() を生成してくれる
-- もし、ls.parser.parse_snippet({trig='hoge'}, ...) ってすると、s() を生成してくれる
local parse = function(context, body, tab_stops, brackets)
  if type(body) == 'table' then
    body = table.concat(body, '\n')
  end

  return ls.parser.parse_snippet(context, body, tab_stops, brackets)
end

return {
  parse = parse,
}
