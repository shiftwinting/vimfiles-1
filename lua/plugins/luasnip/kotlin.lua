local ls = require('luasnip')
local s = ls.s
local t = ls.t
local i = ls.i
local c = ls.c
local sn = ls.sn

local parse = require('plugins.luasnip.util').parse

ls.snippets.kotlin = {
  s({ trig = 'fun', wordTrig = true }, {
    c(1, {

      --[[
        fun name() {

        }
      ]]
      sn(nil, {
        t({ 'fun ' }),
        i(1, { 'name' }),
        t({ '(' }),
        i(2),
        t({ ')' }),
        i(3),
        t({ ' {' }),
        t({ '', '' }),
        t({ '    ' }),
        i(4),
        t({ '', '' }),
        t({ '}' }),
      }),

      --[[
        fun name() =
      ]]
      sn(nil, {
        t({ 'fun ' }),
        i(1, { 'name' }),
        t({ '(' }),
        i(2),
        t({ ')' }),
        i(3),
        t({ ' = ' }),
        i(4),
      }),
    }),
    i(0),
  }),

  s({ trig = 'class', wordTrig = true }, {
    t({ 'class ' }),
    i(1, { 'name' }),
    t({ '(' }),
    c(2, {
      t({ '' }),
      sn(nil, {
        c(1, {
          t({ 'var ' }),
          t({ '' }),
        }),
        t({ '' }),
        i(2, { 'name' }),
        t({ ': ' }),
        i(3, { 'type' }),
      }),
    }),
    t({ ')' }),
    c(3, {
      sn(nil, {
        t({ ': ' }),
        i(1, { 'Unit' }),
        t({ ' ' }),
      }),
      t({ ' ' }),
    }),
    t({ '{' }),
    t({ '', '' }),
    t({ '    ' }),
    i(0),
    t({ '', '' }),
    t({ '}' }),
  }),

  parse({ trig = 'if' }, {
    'if (${1}) {',
    '\t${0}',
    '}',
  }),

  parse({ trig = 'else' }, {
    'else {',
    '\t${0}',
    '}',
  }),

  s({ trig = 'for' }, {
    t({ 'for (' }),
    c(1, {
      -- item
      sn(nil, {
        i(1, { 'item' }),
      }),
      -- (index, value)
      sn(nil, {
        t({ '(' }),
        i(1, { 'index' }),
        t({ ', ' }),
        i(2, { 'value' }),
        t({ ')' }),
      }),
    }),
    t({ ' in ' }),
    i(2, { 'collection' }),
    t({ ') {' }),
    t({ '', '' }),
    t({ '    ' }),
    i(0),
    t({ '', '' }),
    t({ '}' }),
  }),

  parse({ trig = 'while' }, {
    'while (${1}) {',
    '\t${0}',
    '}',
  }),

  parse({ trig = 'dowihle' }, {
    'do {',
    '\t${0}',
    '} while ()',
  }),

  -- parse({trig = 'when'}, {
  --   'when (${1}) {',
  --   '\t${2} -> ${3}',
  --   '\telse -> ${0}',
  --   '}'
  -- }),

  s({ trig = 'when' }, {
    t({ 'when ' }),
    c(1, {
      sn(nil, {
        t({ '(' }),
        i(1),
        t({ ') ' }),
      }),
      i(1),
    }),
    t({ '{' }),
    t({ '', '' }),
    t({ '    ' }),
    i(2),
    t({ ' -> ' }),
    i(3),
    t({ '', '' }),
    t({ '    else -> ' }),
    i(0),
    t({ '', '' }),
    t({ '}' }),
  }),

  s({ trig = 'print' }, {
    c(0, {
      sn(nil, {
        t({ 'print(' }),
        i(1),
        t({ ')' }),
      }),
      sn(nil, {
        t({ 'println(' }),
        i(1),
        t({ ')' }),
      }),
    }),
  }),
}
