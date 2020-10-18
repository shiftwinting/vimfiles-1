scriptencoding utf-8

let s:V = vital#vital#new()
let s:Promise = s:V.import('Async.Promise')

" =================================================
" バックスラッシュをスラッシュにして返す
" =================================================
function! vimrc#get_fullpath(path) abort
    return tr(expand(a:path), "\\", '/')
endfunction

"
" -------------------------------------------------
" バッファが表示されているか返す
" -------------------------------------------------
function! s:find_visible_file(path) abort
    for l:buf in getbufinfo({'buflisted': 1})
        if vimrc#get_fullpath(l:buf.name) ==# a:path &&
        \   !empty(l:buf.windows)
            return 1
        endif
    endfor
    return 0
endfunction


" =================================================
" :drop or :tabedit のどっちか
" =================================================
function! vimrc#drop_or_tabedit(path) abort
    let l:path = vimrc#get_fullpath(a:path)
    if s:find_visible_file(l:path)
        execute 'drop ' . l:path
    else
        execute 'tabedit ' . l:path
    endif
endfunction


" =================================================
" 最後に選択した文字列を取得する
" =================================================
function! vimrc#getwords_last_visual() abort
    let l:reg = '"'
    " save
    let l:save_reg = getreg(l:reg)
    let l:save_regtype = getregtype(l:reg)
    let l:save_ve = &virtualedit

    set virtualedit=

    silent exec 'normal! gv"'.l:reg.'y'
    let l:result = getreg(l:reg, 1)

    " resotore
    call setreg(l:reg, l:save_reg, l:save_regtype)
    let &virtualedit = l:save_ve

    return l:result
endfunction

" " コマンドがないと怒られるため
" function! vimrc#delcommand(cmd) abort
"     if exists(':'.a:cmd) ==# 2
"         execute 'delcommand '.a:cmd
"     endif
" endfunction


" =================================================
" カレントウィンドウの右下に通知を表示する
" =================================================
function! vimrc#popup_notification_botright(messages, ...) abort
    " option は上書き可能にする
    let l:arg_opt = get(a:, 1, {})

    let l:col = &columns - (&guioptions =~# 'r' ? 1 : 0)

    let l:opt = {
    \   'line': &lines - &cmdheight - 1,
    \   'col': l:col,
    \   'time': 3000,
    \   'pos': 'botright',
    \   'maxwidth': 30,
    \   'minwidth': 30,
    \   'minheight': 4,
    \   'padding': [0, 1, 0, 1],
    \   'border': [1, 1, 1, 1],
    \   'borderchars': ['-', '|', '-', '|', '+', '+', '+', '+'],
    \   'highlight': 'Todo',
    \   'wrap': 0,
    \   'tabpage': -1
    \}
    return popup_create(a:messages, extend(l:opt, l:arg_opt))
endfunction


function! vimrc#default_close_handler(channel) abort
    let l:timer = timer_start(3000, )
endfunction

" =================================================
" コマンドを :terminal で実行する
" =================================================
" from skanehira/dotfiles http://bit.ly/36CWoez
" opts:
" {
"     cmd:        cmd の a:cmd サブコマンド のコマンド
"     args:       cmd のコマンドの引数
"     window_way: ウィンドウの分割方向 (e.g. 'bo')
" }
function! vimrc#term_exec(cmd, opts) abort
    let l:cur_winid = win_getid()
    let l:default_opts = {
    \   'cmd': '',
    \   'args': [],
    \   'window_way': 'botright',
    \}
    let l:opts = extend(l:default_opts, a:opts)

    let l:cmd = printf('%s %s %s', a:cmd , l:opts.cmd, join(l:opts.args, ' '))
    execute printf('%s term ++rows=10 %s', l:opts.window_way, l:cmd)

    " マッピング
    nnoremap <buffer> <silent> q :bw!<CR>

    " 元のウィンドウに戻る
    call win_gotoid(l:cur_winid)
endfunction


function! s:on_err(msg, ...) abort
    echohl errormsg
    echomsg a:msg
    echohl None
endfunction


function! vimrc#output_error_buffer(msg, ...) abort
    let l:buf = get(a:, 1, -1)
    " もし、渡されなければ、echo
    if l:buf == -1
        echomsg a:msg
    endif

    if index(tabpagebuflist(), l:buf) == -1
        " 表示されていなかったら、表示する
        execute 'botright 10new | b ' . l:buf
        nnoremap <silent> <buffer> q :<C-u>bd!<CR>
    endif
    " メッセージ追加
    call appendbufline(l:buf, '$', a:msg)
endfunction


function! vimrc#on_out(line, ...) abort
    if type(a:line) ==# v:t_list
        " neovim の jobstart に対応
        echo join(a:line, ' ')
    else
        echo a:line
    endif
endfunction


function! s:on_close(channel, ...) abort
    echo 'job finish!'
endfunction


function! vimrc#job_start(cmd, ...) abort

    " out_cb : stdout で読み込むものがあるときに呼び出される
    " err_cb : stderr で読み込むものがあるときに呼び出される

    let l:buf = bufadd('tmg_job_output')

    let l:default_opts = {
    \   'out_cb': function('vimrc#on_out'),
    \   'err_cb': function('s:on_err'),
    \   'close_cb': function('s:on_close')
    \}
    let l:opts = extend(l:default_opts, get(a:, 1, {}))
    if has('nvim')
        let s:job = jobstart([&shell, &shellcmdflag, a:cmd], {
        \   'on_stdout': { job_id, data -> l:opts.out_cb(data, l:buf)},
        \   'on_stderr': { job_id, data -> l:opts.err_cb(data, l:buf)},
        \   'on_exit': l:opts.close_cb,
        \})
    else
        let s:job = job_start([&shell, &shellcmdflag, a:cmd], {
        \   'out_cb': { job_id, data -> l:opts.out_cb(data, l:buf)},
        \   'err_cb': { job_id, data -> l:opts.err_cb(data, l:buf)},
        \   'close_cb': l:opts.close_cb,
        \})
    endif
endfunction

" =================================================
" echoerr
" =================================================
function! vimrc#echoerr(msg) abort
    redraw
    echohl ErrorMsg
    echo a:msg
    echohl None
endfunction



" =================================================
" echo info
" =================================================
function! vimrc#echoinfo(msg) abort
    redraw
    echohl Todo
    echo a:msg
    echohl None
endfunction

" =================================================
" $PATH に追加する
"
" vimrc#add_path({val}[, {check_dir}])
"   {val}: $PATH に追加する値
"   {check_dir}: $PATH !~# {check_dir} で使われる文字列
" =================================================
function! vimrc#add_path(val, ...) abort
    let l:check_dir = get(a:, 1, v:true)
    if $PATH !~# l:check_dir
        let $PATH = expand(a:val).';' . $PATH
    endif
endfunction



" =================================================
" input()
" http://secret-garden.hatenablog.com/entry/2016/06/23/224214
" =================================================
function! vimrc#input(...) abort
    new
    cmap <buffer> <Esc> __CANCELED__<CR>
    cmap <buffer> <C-c> __CANCELED__<CR>
    let l:ret = call('input', a:000)
    bw!
    redraw
    if l:ret =~# '__CANCELED__$'
        throw 'キャンセルされました'
    endif
    return l:ret
endfunction
