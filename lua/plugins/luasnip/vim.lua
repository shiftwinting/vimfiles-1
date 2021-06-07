local ls = require('luasnip')
local parse = require('plugins.luasnip.util').parse

ls.snippets.vim = {
  parse({ trig = 'if' }, {
    'if ${1:condition}',
    '\t${2}',
    'endif',
  }),

  parse({ trig = 'for' }, {
    'for ${1:var} in ${2:list}',
    '\t$3',
    'endfor',
  }),

  parse({ trig = 'func(tion)?', regTrig = true }, {
    'function! ${1:func_name}($2) abort',
    '\t${3}',
    'endfunction',
  }),

  parse({ trig = 'command' }, 'command! ${1:command_name} call ${2:func_name}'),

  parse({ trig = 'augroup' }, {
    'augroup ${1:augroup_name}',
    '\tautocmd!',
    '\tautocmd ${2:event}',
    'augroup END',
  }),

  parse({ trig = 'autocmd' }, 'autocmd ${1:group} ${2:event}'),

  parse({ trig = 'lua' }, {
    'lua << EOF',
    '$1',
    'EOF',
  }),

  parse({ trig = 'try' }, {
    'try',
    '\t$1',
    'catch /${2:.*}/',
    '\t$3',
    'endtry',
  }),
}
