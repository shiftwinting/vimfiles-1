scriptencoding utf-8

nnoremap <Space>fg :GrepperRg 

let s:rg_options = [
\ '--smart-case',
\ '--glob=!*/.mypy_cache/*',
\ '--glob=!.node_modules/*',
\ '--glob=!tags*',
\ '--column',
\ '--with-filename',
\ '--no-heading',
\ ' --vimgrep'
\]

let g:grepper = {
\ 'tools': ['rg', 'git'],
\ 'rg': {
\   'grepprg': 'rg ' .. join(s:rg_options, ' '),
\   'grepformat': '%f:%l:%c:%m,%f',
\   'escape': '\^$.*+?()[]{}|'
\ },
\}

