scriptencoding utf-8

let g:vimfiles_path = expand('<sfile>:h')
let g:plug_script = expand('<sfile>:h').'/plugins.vim'
let $MYVIMFILES = g:vimfiles_path

exec 'source '. g:plug_script

let s:plugs = get(s:, 'plugs', get(g:, 'plugs', {}))
function! FindPlugin(name) abort
  return has_key(s:plugs, a:name) ? isdirectory(s:plugs[a:name].dir) : 0
endfunction
command! -nargs=1 UsePlugin if !FindPlugin(<args>) | finish | endif

" lua-language-server の library に指定する
function! PlugLuaLibraries() abort
  " vim-plug で管理している lua プラグインのディレクトリを渡す
  let l:res = {}
  for l:val in values(s:plugs)
    let l:path = val.dir .. 'lua'
    if isdirectory(l:path)
      let l:res[l:path] = v:true
    endif
  endfor
  return l:res
endfunction

let g:lua_plugin_config_dir = g:vimfiles_path .. '/lua/plugins'
let g:vim_plugin_config_dir = g:vimfiles_path .. '/_config/plugins'

runtime! _config/**/*.vim
lua require('init')
