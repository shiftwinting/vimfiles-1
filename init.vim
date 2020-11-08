scriptencoding utf-8

let g:vimfiles_path = expand('<sfile>:h')
let g:plug_script = expand('<sfile>:h').'/plugins.vim'
let $MYVIMFILES = expand('$HOME/.config/nvim')

exec 'source '.expand('<sfile>:h').'/plugins.vim'

let s:plugs = get(s:, 'plugs', get(g:, 'plugs', {}))
function! FindPlugin(name) abort
    return has_key(s:plugs, a:name) ? isdirectory(s:plugs[a:name].dir) : 0
endfunction
command! -nargs=1 UsePlugin if !FindPlugin(<args>) | finish | endif

let g:lua_plugin_config_dir = g:vimfiles_path .. '/lua/rc'
let g:vim_plugin_config_dir = g:vimfiles_path .. '/rc'

runtime! rc/**/*.vim

lua require('init')
