scriptencoding utf-8

finish

if empty(globpath(&rtp, 'autoload/which_key.vim'))
    finish
endif

let g:mapleader = "\<Space>"

" <Space> が leader key とする
call which_key#register('<Space>', 'g:which_key_map')

nnoremap <silent> <leader> :<C-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<C-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_map = {}

let g:which_key_map.f = {
\   'name': '+LeaderF',
\   'f': 'file',
\   'j': 'buffer',
\   'k': 'mru',
\   'h': 'help',
\   'n': 'neosnippet',
\   'b': 'bookmark',
\   'g': 'grep',
\   'l': 'lines',
\   'q': 'ghq',
\   't': 'filetype',
\   'r': 'rg recall',
\   's': 'buffer tags',
\   'v': 'vimfiles',
\   '<Space>': 'command',
\   'd': 'git dirty',
\   'c': 'git switch',
\   'm': 'mrw',
\}

let g:which_key_map.g = {
\   'name': '+git',
\   'l': ['GV', 'log'],
\   'L': ['GV!', 'log (current buffer)'],
\   'k': ['Gpush', 'push'],
\   'j': ['Gpull', 'pull'],
\   'b': ['Gblame', 'blame'],
\   's': 'status',
\}
