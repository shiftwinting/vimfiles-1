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

lua require('init')

let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_background = 'medium'

set bg=light
colorscheme gruvbox-material

runtime! rc/**/*.vim
