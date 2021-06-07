local ls = require'luasnip'
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d

local parse = require'plugins.luasnip.util'.parse

-- local tab = function()
--   f(function(args)
--     return {
--       string.rep(' ', 2)
--     }
--   end, {})
-- end

-- local ret = function()
--   return t{'', ''}
-- end


ls.snippets.lua = {
  parse({trig = 'lam'}, {
    'function(${1})',
    '\t${0}',
    'end'
  }),

  parse({trig = 'if'}, {
    'if ${1} then',
    '\t${0}',
    'end'
  }),

  parse({trig = 'else'}, 'else\n\t${0}'),
  parse({trig = 'elseif'}, 'elseif ${1}\n\t${0}'),

  parse({trig = 'for'}, {
    'for ${1:_}, ${2:v} in ipairs(${3}) do',
    '\t${0}',
    'end'
  }),

  parse({trig = 'forin'}, {
    'for ${1:item} in ${2:list} do',
    '\t${0}',
    'end'
  }),

  parse({trig = 'foreach'}, {
    'for ${1:_}, ${2:v} in ipairs(${3}) do',
    '\t${0}',
    'end'
  }),

  parse({trig = 'while'}, {
    'while ${1} do',
    '\t${0}',
    'end'
  }),

  parse({trig = 'fmt'}, "string.format('${1}', ${2})"),

  --[[
  function name(args)
    |
  end

  local name = function(args)
    |
  end
  ]]
  s({trig = 'func', wordTrig = true}, {
    c(1, {
      sn(nil, {
        t{'function '}, i(1, {'name'}),
        t{'('},
        i(2),
        t{')'}, t{'', ''},
        t{'  '}, i(3), t{'', ''},
        t{'end'}
      }),
      sn(nil, {
        t{'local '}, i(1, {'name'}), t{' = function('}, i(2), t{')'}, t{'', ''},
        t{'  '}, i(3), t{'', ''},
        t{'end'}
      })
    }),
    i(0)
  }),

  parse({trig = 'req'}, {
    "require'${0}'"
  })
}
