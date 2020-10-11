scriptencoding utf-8

nnoremap <Space>;h :<C-u>FavoriteHelps<CR>
nnoremap <Space>;f :<C-u>FnamemodsPopup<CR>

command! HereOpen call execute('!start '.getcwd(), "silent")

" if executable('js-sqlformat')
"   command! -range=% SQLFmt <line1>,<line2>!js-sqlformat
" endif

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

function! s:github_fix_param(param) abort
    return substitute(a:param, '\v(|\s+)', '', 'g')
endfunction

" =====================
" カレントファイルのパスをいろんな形式で yank
" =====================
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


" =====================
" カーソル下の highlight 情報を取得 (name のみ) 
" =====================
command! SyntaxInfo call GetSynInfo()

" http://cohama.hateblo.jp/entry/2013/08/11/020849
function! s:get_syn_id(transparent) abort
    " synID() で 構文ID が取得できる
    " XXX: 構文ID
    "       synIDattr() と synIDtrans() に渡すことで"構文情報"を取得できる
    " trans に1を渡しているため、実際に表示されている文字が評価対象
    let synid = synID(line('.'), col('.'), 1)
    if a:transparent
        " ハイライトグループにリンクされた構文IDが取得できる
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

    " 1 を渡すとリンク先が取得できる
    let linked_syn = s:get_syn_attr(s:get_syn_id(1))
    echo 'link to'
    echo 'name: ' . linked_syn.name
endfunction


" =====================
" packages 機能
" =====================
command! -nargs=+ PackGet call s:packget(<f-args>)
" command! -nargs=1 -complete=packadd PackAdd call s:packadd(<f-args>)
command! -nargs=1 -complete=packadd PackHelptags call s:packhelptags(<f-args>)

" 末尾の '/' を取り除くため、 :p:h とする
let s:pack_base_dir = vimrc#get_fullpath(fnamemodify('$MYVIMFILES/pack/plugs/opt', ':p'))
let s:sep = has('win32') ? "\\" : '/'

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

function! s:close_handler(plug_name, channel, ...) abort
    execute 'packadd ' . a:plug_name
    echomsg ' [PackGet] packadd ' . a:plug_name
endfunction

function! s:packget(url, ...) abort
    let l:base = s:add_end_slash(s:pack_base_dir)

    " 改行文字と空白を取り除く
    let l:url = s:github_fix_param(a:url)

    " 引数指定されていたら、その名前のディレクトリに作成する
    let l:plug_name = a:0 ==# 0 ?
    \   fnamemodify(l:url, ':t:r') :
    \   a:1

    let l:dst = l:base . l:plug_name

    if isdirectory(l:dst)
        echohl WarningMsg
        echomsg " [PackGet] Already exists. '".l:plug_name."'"
        echohl None
        return
    endif

    call vimrc#job_start(
    \   printf('git clone %s %s', s:fix_url(l:url), l:dst), {
    \       'close_cb': function('s:close_handler', [l:plug_name]),
    \       'err_cb': function('vimrc#on_out'),
    \   })
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


" =====================
" カレントバッファを開く
" =====================
command! ThisOpen execute printf('!start "%s"', expand('%:p'))


" =====================
" メモ
" =====================
command! MemoOpen call vimrc#drop_or_tabedit(expand('~/tmp_memo'))
nnoremap <Space>tm :<C-u>MemoOpen<CR>


" =====================
" bitly で URL 短縮
" =====================

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


" TODO: tabstop のくるくる


" =====================
" ghq
" =====================
command! -nargs=1 GhqGet call vimrc#job_start('ghq get ' . <SID>github_fix_param(<f-args>), {})
" command! -nargs=1 GhqCreate execute 'belowright terminal ghq create <q-args>'


" =====================
" Sass
" =====================
command! -nargs=+ -complete=dir SassWatchStart    call sasswatch#start(<f-args>)
command! -nargs=+ -complete=dir SassWatchStartCwd call sasswatch#start(getcwd(), <f-args>)
command! -nargs=0               SassWatchStop     call sasswatch#stop()

" " =====================
" " git
" " =====================
" command! GitPush        call git#push()
" command! GitPull        call git#pull()
" command! GitCommit      call git#commit()
" command! GitCommitAmend call git#commit_amend()
" command! GitCheckout    :<C-u>Leaderf git_checkout --popup<CR>


" =====================
" new temp file
" =====================

if exists('*popup_create')
    " ファイルタイプと拡張子のペア
    let s:ft_pair = {
    \   'python': 'py',
    \   'vim':    'vim',
    \}

    " input() のときに getcmdline() で取得できる技
    function! s:new_tmp_file() abort
        let l:line = line('.') < 5 ? 5 : 'cursor-1'
        let l:winid =  popup_create('', {
        \   'padding': [1, 1, 1, 1],
        \   'minwidth': 20,
        \   'line': l:line,
        \   'col': 'cursor+3',
        \})

        redraw
        let l:timer = timer_start(30, funcref('s:timer_callback', [l:winid]), { 'repeat': -1 })

        let l:ft = call('input', ['>>> ', '', 'filetype'])

        " xxx.tmp => xxx.py みたいな
        let l:tmp = substitute(tempname(), '\.\zs[^.]\+$', get(s:ft_pair, l:ft, 'tmp'), '')
        " もし、空ならそのバッファに表示
        if line('$') == 1 && getline(1) ==# ''
            exec 'e '.l:tmp
        else
            exec 'new '.l:tmp
        endif
        exec 'set ft='.l:ft

        call timer_stop(l:timer)
        call popup_close(l:winid)
    endfunction

    function! s:timer_callback(winid, ...) abort
        let l:query = getcmdline()
        call win_execute(a:winid, printf("call setline(1, 'FileType: %s')", l:query))
        " redraw は必要！
        redraw
    endfunction
else
    function! s:new_tmp_file() abort "
        let s:_ft = input('FileType: ', '', 'filetype')
        let s:tmp = tempname()
        " もし、空ならそのバッファに表示
        if line('$') == 1 && getline(1) ==# ''
            exec 'e '.s:tmp
        else
            exec 'new '.s:tmp
        endif
        exec 'set ft='.s:_ft
    endfunction
endif

command! NewTempFile call <SID>new_tmp_file()


if executable('sml-format')
    command! -range=% SmlFormat <line1>,<line2>!sml-format
endif
