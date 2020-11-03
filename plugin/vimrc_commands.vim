scriptencoding utf-8

" Lua のプラグインの設定ファイルの作成
function! TouchLuaPluginConfig(name) abort
    " lua/rc/xxx/bbb.lua を作成する
    " .vim$ は _vim に変換する

    let l:fname = substitute(a:name, '\.vim$', '_vim', '') .. '.lua'
    let l:path = g:lua_plugin_config_dir .. '/' .. l:fname
    call vimrc#drop_or_tabedit(l:path)
endfunction

" Vim プラグインの設定ファイルの作成
function! TouchVimPluginConfig(name) abort
    " rc/xxx/bbb.vim を作成する
    " .vim$ は _vim に変換する
    let l:fname = substitute(a:name, '\.vim$', '_vim', '') .. '.vim'
    let l:path = g:vim_plugin_config_dir .. '/' .. l:fname
    call vimrc#drop_or_tabedit(g:vim_plugin_config_dir .. l:path)
endfunction


command! -nargs=1 TouchLuaPluginConfig call TouchLuaPluginConfig(<f-args>)
command! -nargs=1 TouchVimPluginConfig call TouchVimPluginConfig(<f-args>)
