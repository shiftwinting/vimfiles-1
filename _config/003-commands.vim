scriptencoding utf-8

nnoremap <Space>;h :<C-u>FavoriteHelps<CR>
nnoremap <Space>;f :<C-u>FnamemodsPopup<CR>

command! HereOpen call execute('!start %:p:h', "silent")

if executable('js-sqlformat')
  command! -range=% SQLFmt <line1>,<line2>!js-sqlformat
endif

if executable('jq')
    command! -range=% Jq <line1>,<line2>!jq
endif

function! s:get_maxlen(list) abort " 
    let maxlen = 0
    for val in a:list
        let length = len(val)
        if maxlen < length
            let maxlen = length
        endif
    endfor
    return maxlen
endfunction



" ------------------------------------------------------------------------------
" カレントファイルのパスをいろんな形式で yank
command! FnamemodsPopup call s:yank_fnamemods_popup()

" TODO: コマンドでパスの変換できるようにする
" wsl wslpath -a 'xxxxx/xxxxx/xxx'

" 形式を設定
" let s:modifiers = [
"     \ ':p',
"     \ ':p:.',
"     \ ':p:~',
"     \ ':h',
"     \ ':p:h',
"     \ ':p:h:h',
"     \ ':t',
"     \ ':p:t',
"     \ ':r',
"     \ ':p:r',
"     \ ':t:r',
"     \ ':e',
"     \]
let s:modifiers = [
    \ ':p:h',
    \ ':p:~',
    \ ':p',
    \ ':p:r',
    \ ':t:r',
    \ ':p:t',
    \ ':e',
    \]

function! s:yank_fnamemods_popup() abort " 
    let fnmods = s:create_fnmods_list(expand('%:p'), s:modifiers)

    let c_fnmods = deepcopy(fnmods)
    let disp_list = map(c_fnmods, {key, val -> val.mods.' '.val.path })

    let popctx = {
        \ 'fnmods': fnmods
        \}

    let opts = {
        \ 'callback': function('s:fnmods_handler', [popctx]),
        \ 'title': 'File modifiers to yank',
        \ 'padding': [0, 1, 0, 1],
        \}

    " popup_menu: リストから選択する popup window
    "             callback の第2引数に選択行のindexを渡す(1始まり)
    let popctx.id = popup_menu(disp_list, opts)

endfunction

function! s:fnmods_handler(popctx, winid, idx) abort " 
    " キャンセル時、-1が渡されるため
    if a:idx != -1
        " idx は 1 始まりのため -1 する
        let fname = a:popctx.fnmods[a:idx-1].path
        call setreg('+', trim(fname))
        echo 'yanked'
    endif
endfunction


function! s:create_fnmods_list(fullpath, fnmods) abort " 
    let maxlen = s:get_maxlen(a:fnmods)

    let fnmods_list = []

    for mods in a:fnmods
        let path = expand('%'.mods)

        " パスの位置を合わせる
        if mods ==# ':e'
            " :e
            let space_num = strridx(a:fullpath, path)
        elseif stridx(mods, '~') != -1
            " :~
            let space_num = len($HOME) -1
        else
            let space_num = stridx(a:fullpath, path)
        endif

        " mods, path の調整
        let just_mods = printf('%-'.maxlen.'s', mods)
        let just_path = repeat(' ', space_num).' '.path

        call add(fnmods_list, {
            \ 'mods': just_mods,
            \ 'path': just_path,
            \})
    endfor

    return fnmods_list
endfunction
" ------------------------------------------------------------------------------



" ------------------------------------------------------------------------------
" よく使う help へのジャンプ 
command! FavoriteHelps call FavoriteHelps()

" 順序を保持するため、リスト
let s:fav_helps = []

call add(s:fav_helps, ['function-list', '関数一覧'])
call add(s:fav_helps, ['user-commands', 'command の書き方'])
call add(s:fav_helps, ['autocmd-events', 'autocmd 一覧'])
call add(s:fav_helps, ['E500', '<cword> とか <afile> とか'])
call add(s:fav_helps, ['usr_41', 'Vim script 基本'])
call add(s:fav_helps, ['pattern-overview', '正規表現'])
call add(s:fav_helps, ['eval', 'Vim script [tips]'])
call add(s:fav_helps, ['ex-cmd-index', '":"のコマンド'])
call add(s:fav_helps, ['filename-modifiers', ':p とか :h とか'])
call add(s:fav_helps, ['index', '各モードのマッピング'])
" call add(s:fav_helps, ['doc-file-list', 'home'])
" call add(s:fav_helps, ['functions', ''])
" call add(s:fav_helps, ['help-summary', ''])
" call add(s:fav_helps, ['quickref', ''])

" TODO: よくアクセスする順に変更したい
" let s:fav_help_history_path = expand('~/_fav_help_history')

" help menus 作成 
function! s:help_create_text_list(list) abort
    let help_items = []
    " 最大桁数を取得
    let max_len = s:get_maxlen(map(deepcopy(a:list), 'v:val[0]'))
    for [k, v] in a:list
        " 左揃えにする
        call add(help_items, printf('%-'.max_len.'s', k).' '.v)
    endfor
    return help_items
endfunction


function! s:help_favorite_handler(winid, idx) abort " 
    " キャンセル時、-1が渡されるため
    if a:idx != -1
        " ウィンドウ関数から取得
        let l:items = getwinvar(a:winid, 'items', [])
        " idx は 1 始まりのため -1 する
        exec 'help '.l:items[a:idx-1][0]
    endif
endfunction


function! FavoriteHelps() abort " 
    let l:winid = popup_menu(s:help_create_text_list(s:fav_helps), {
    \   'callback': function('s:help_favorite_handler'),
    \   'title': 'Favorite helps',
    \   'padding': [0, 1, 0, 1],
    \})
    " window変数を使う
    call setwinvar(l:winid, 'items', map(s:fav_helps, 'v:val'))
endfunction
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" カーソル下の highlight 情報を取得 (name のみ) 
command! SyntaxInfo call GetSynInfo()

" http://cohama.hateblo.jp/entry/2013/08/11/020849
function! s:get_syn_id(transparent) abort
    " synID() で 構文ID が取得できる
    " XXX: 構文ID とは?
    " trans に1を渡しているため、実際に表示されている文字が評価対象
    let synid = synID(line('.'), col('.'), 1)
    if a:transparent
        " 数値が返される
        " XXX: なんの数値なのかはわからない...
        " :hi link の参照先の情報を取得？
        return synIDtrans(synid)
    else
        return synid
    endif
endfunction

function! s:get_syn_attr(synid) abort
    let name = synIDattr(a:synid, 'name')
    return { 'name': name }
endfunction

function! GetSynInfo() abort
    let base_syn = s:get_syn_attr(s:get_syn_id(0))
    echo 'name: ' . base_syn.name

    let linked_syn = s:get_syn_attr(s:get_syn_id(1))
    echo 'link to'
    echo 'name: ' . linked_syn.name
endfunction
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" packages 機能
command! -nargs=+ PackGet call s:packget(<f-args>)
command! -nargs=1 -complete=packadd PackAdd call s:packadd(<f-args>)
command! -nargs=1 -complete=packadd PackHelptags call s:packhelptags(<f-args>)

" 末尾の '/' を取り除くため、 :p:h とする
let s:pack_base_dir = tr(fnamemodify('~/vimfiles/pack/plugs/opt', ':p'), "\\", '/')
let s:sep = has('win32') ? "\\" : '/'

function! s:packadd(plugin_name) abort
    if index(s:packages(), a:plugin_name) ==# -1
        " echomsg に ErrorMsg ハイライトをつける
        echohl ErrorMsg
        echomsg 'Not found plugin. '.a:plugin_name
        echohl None
        return
    endif
    execute 'packadd '.a:plugin_name
endfunction

function! s:packages() abort
    let l:result = []
    for path in split(globpath(&packpath, '/pack/*/opt/*'))
        if isdirectory(path)
            let dirname = path[strridx(path, s:sep)+1:]
            call add(l:result, dirname)
        endif
    endfor
    return l:result
endfunction

function! s:packget_cb(job, status) abort
    echomsg job_status(a:job)
endfunction

function! s:add_end_slash(path) abort
    if a:path =~# '/$'
        let l:result = a:path
    else
        let l:result = a:path.'/'
    endif
    return l:result
endfunction

function! s:fix_url(url) abort
    return a:url =~# '^http' ?
    \   a:url :
    \   'https://github.com/'.a:url
endfunction

function! s:packget(url, ...) abort
    let l:base = s:add_end_slash(s:pack_base_dir)

    " 引数指定されていたら、その名前のディレクトリに作成する
    let l:plug_name = a:0 ==# 0 ?
    \   fnamemodify(a:url, ':t:r') :
    \   a:1

    let l:dst = l:base . l:plug_name

    if isdirectory(l:dst)
        echohl ErrorMsg
        echomsg "Already exists. '".l:plug_name."'"
        echohl None
        return
    endif

    let l:cmd = 'git clone ' . s:fix_url(a:url) . ' '  . l:dst

    execute 'botright term ++rows=12 '.l:cmd
    nnoremap <buffer> q <C-w>q
endfunction

" これやっても意味ない？
" :help で検索聞いてなさそう?
function! s:packhelptags(plugin_name) abort
    let l:base = s:add_end_slash(s:pack_base_dir)
    if !isdirectory(l:base . a:plugin_name)
        echohl ErrorMsg
        echomsg 'Not found plugin. '.a:plugin_name
        echohl None
        return
    endif
    execute 'helptags ' . l:base. a:plugin_name . '/doc'
endfunction

" pack/plugs/opt の中の help を検索
" runtimepath 内の doc/ も help で引ける
"  -> packadd したもののhelpを引くには、runtimepath に含める必要がある？
" command! -nargs=1 PackHelp -complete=customlist,func call s:packhelp(<f-args>)
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" カレントバッファを開く
command! ThisOpen call system('start ' . expand('%:p'))
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" カレントバッファのファイル名を変更
function! RenameCurBuffer() abort
    let l:name = input('Rename: ')
    if empty(l:name)
        return
    endif

    let l:fullpath = tmg#get_fullpath(expand('%:p:h')) . '/' . l:name
    call rename(expand('%:p'), l:fullpath)
    execute 'edit! ' . l:fullpath
endfunction

command! RenameCurBuffer call RenameCurBuffer()
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
command! MemoOpen call tmg#DropOrTabedit(expand('~/tmp_memo'))
nnoremap <Space>tm :<C-u>MemoOpen<CR>
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" bitly で URL 短縮

let bitly#use_default_token = 1

function! ShortenUrl(long_url) abort
    let l:short_url = bitly#shorten_url(a:long_url)
    if l:short_url ==# ''
        return
    endif
    let @* = l:short_url
    echomsg '[bitly.vim] Shorten url yank'
endfunction

command! -nargs=1 BitlyShortenUrl call ShortenUrl(<f-args>)

" ------------------------------------------------------------------------------
" TODO: tabstop のくるくる


" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" ghq
command! -nargs=1 GhqGet    execute 'terminal ghq get <q-args>'
command! -nargs=1 GhqCreate execute 'terminal ghq create <q-args>'
" ------------------------------------------------------------------------------
