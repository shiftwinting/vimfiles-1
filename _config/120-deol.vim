scriptencoding utf-8

" XXX: 参考にする https://git.io/JeKIn

" \%(\) : 部分正規表現として保存しない :help /\%(\)
" \%(>\|# \?\|\$\) :  > # $ 
let g:deol#prompt_pattern = '[^#>$ ]\{-}\%(>\|# \?\|\$\)'

" コマンドの履歴
let g:deol#shell_history_path = expand('~/deol_history')

" job_start() へのオプション
let g:deol#extra_options = {
\   'term_kill': 'kill',
\}

" プロンプト
let g:deol_prompt_sign = '$ '

" 履歴ファイルを読めるか
let s:can_read_history_file = filereadable(g:deol#shell_history_path)


nnoremap <silent><A-t> :<C-u>call ToggleDeol()<CR>
tnoremap <silent><A-t> <C-\><C-n>:<C-u>call ToggleDeol()<CR>


augroup MyDeol
    autocmd!
augroup END

autocmd MyDeol Filetype   deol     call <SID>deol_settings()
autocmd MyDeol Filetype   deoledit call <SID>deol_editor_settings()
autocmd MyDeol TabLeave   *        call <SID>TabLeave()
autocmd MyDeol TabClosed  *        call <SID>TabClosed()
autocmd MyDeol DirChanged *        call <SID>DirChanged(expand('<afile>'))


" ====================
" QuitPre:
" ====================
function! s:QuitPre() abort
    call setbufvar(bufnr(), 'deol_quited', 1)
endfunction


" ====================
" WinLeave:
" ====================
function! s:WinLeave() abort
    if !getbufvar(bufnr(), 'deol_quited', 0)
        return
    endif

    let l:deol_edit_bufnr = get(s:get_deol(), 'edit_bufnr', -1)
    call s:bufdelete_if_exists(l:deol_edit_bufnr)
endfunction


" タブが閉じられたとき:  TabLeave -> TabClosed の順で呼ばれる
" ====================
" TabLeave:
" ====================
function! s:TabLeave() abort
    if !exists('t:deol')
        return
    endif
    let  g:last_tab_deol = t:deol
endfunction


" ====================
" TabClosed:
" ====================
function! s:TabClosed() abort
    if !exists('g:last_tab_deol') || empty(g:last_tab_deol)
        return
    endif

    call s:bufdelete_if_exists(g:last_tab_deol.bufnr)
    unlet g:last_tab_deol
endfunction


" ====================
" DirChanged:
" ====================
function! s:DirChanged(file) abort
    if exists('t:deol')
        call deol#cd(a:file)
    endif
endfunction


" ====================
" TextChangedI:
" TextChangedP:
" ====================
function! s:TextChanged() abort
    call s:sign_place()
endfunction



function! s:deol_settings() abort
    tnoremap <buffer><silent>       <A-e> <C-w>:call         deol#edit()<CR>
    nnoremap <buffer><silent>       <A-e> <Esc>:<C-u>normal! i<CR>
    nnoremap <buffer><silent>       <A-t> <Esc>:call         <SID>hide_deol(tabpagenr())<CR>

    " "\<Right>" じゃだめだった
    nnoremap <buffer><silent><expr> A     'i' . repeat("<Right>", len(getline('.')))
    nnoremap <buffer><silent><expr> I     'i' . repeat("<Left>",  len(getline('.')))

    " 不要なマッピングを削除
    nnoremap <buffer>               <C-o> <Nop>
    nnoremap <buffer>               <C-i> <Nop>
    nnoremap <buffer>               <C-e> <Nop>
    nnoremap <buffer>               <C-z> <Nop>
    nnoremap <buffer>               e     <Nop>

    " :q --- QuitPre -> WinLeave
    autocmd MyDeol QuitPre  <buffer> call <SID>QuitPre()
    autocmd MyDeol WinLeave <buffer> call <SID>WinLeave()

endfunction


function! s:deol_editor_settings() abort

    autocmd MyDeol TextChangedI,TextChangedP <buffer> call <SID>sign_place()
    autocmd MyDeol InsertEnter,InsertCharPre <buffer> call <SID>start_complete()


    inoremap <buffer><silent> <A-e> <Esc>:call <SID>deol_kill_editor()<CR>
    nnoremap <buffer><silent> <A-e> :<C-u>call <SID>deol_kill_editor()<CR>

    inoremap <buffer><silent> <A-t> <Esc>:call <SID>hide_deol(tabpagenr())<CR>
    nnoremap <buffer><silent> <A-t> :<C-u>call <SID>hide_deol(tabpagenr())<CR>

    nnoremap <buffer>         <C-o> <Nop>
    nnoremap <buffer>         <C-i> <Nop>

    nnoremap <buffer><silent> <CR>  :<C-u>call <SID>send_editor()<CR>
    inoremap <buffer><silent> <CR>  <Esc>:call <SID>send_editor(v:true)<CR>


    iabbrev <buffer> poe poetry

    resize 5
    setlocal winfixheight


    " --------------------
    " 行補完
    " --------------------
    setlocal completefunc=LineComplete
    " カレントバッファ
    setlocal complete=.
    " ウィンドウに表示されているバッファ
    setlocal complete+=w

    call s:sign_place()

endfunction


" ====================
" 行補完
" ====================
function! LineComplete(findstart, base) abort
    if a:findstart
        " 補完の開始位置を返す
        return matchstrpos(getline('.'), '^\s*\ze\S')[2]
    else
        let l:lines = getline(1, '$')
        " 先頭でマッチするものを返す
        call filter(l:lines, 'v:val =~# "^" . a:base')
        return l:lines
    endif
endfunction

function! s:start_complete() abort
    " １文字以上あったら、行補完開始
    if empty(getline('.'))
        return
    endif
    call feedkeys("\<C-x>\<C-u>", 'n')
endfunction


" ====================
" 表示/非表示を切り替える
" 
" ToggleDeol([tabnr])
" ====================
function! ToggleDeol(...) abort
    let l:tabnr = get(a:, 1, tabpagenr())

    if s:is_show_deol(l:tabnr)
        call s:hide_deol(l:tabnr)
    else
        call s:show_deol(l:tabnr)
    endif
endfunction



" ====================
" deol-edit を削除
"
" s:deol_kill_editor()
" ====================
function! s:deol_kill_editor() abort
    if !exists('t:deol')
        return
    endif

    " バッファがあれば削除
    call s:bufdelete_if_exists(t:deol.edit_bufnr)

    call win_gotoid(bufwinid(t:deol.bufnr))
endfunction


" ====================
" deol を表示
" 
" s:show_deol(tabnr[, command])
" ====================
function! s:show_deol(tabnr, ...) abort
    let l:command = get(a:, 1, &shell)

    botright 25new
    setlocal winfixheight

    if !exists('t:deol') || !bufexists(t:deol.bufnr)
        " 新規作成
        call deol#start(printf('-edit -command=%s -edit-filetype=deoledit', l:command))
    else
        " 既存を使用
        try
            " うまくできなかったため、エラーは無視する
            execute 'buffer +normal!\ i ' . t:deol.bufnr
        catch /.*/
            " ignore
        endtry

        " deol-editor を開く
        call deol#edit()
    endif
endfunction


" ====================
" deol を非表示にする
" 
" s:hide_deol(tabnr)
" ====================
function! s:hide_deol(tabnr) abort
    if !exists('t:deol')
        " まだ、作られていない場合、終わり
        return
    endif

    if s:is_show_deol_edit()
        call s:deol_kill_editor()
    endif

    call win_gotoid(bufwinid(t:deol.bufnr))
    if t:deol.bufnr ==# bufnr()
        execute 'hide'
    endif

endfunction


function! s:is_show_deol(tabnr) abort
    if !exists('t:deol')
        " まだ、作られていない場合、終わり、表示すらされないため
        return 0
    endif

    if empty(win_findbuf(t:deol.bufnr))
        " バッファが表示されているウィンドウが見つからない
        return 0
    endif
    return 1
endfunction


" ====================
" deol-edit が表示されているか
"
" s:is_show_deol_edit([tabnr])
" ====================
function! s:is_show_deol_edit(...) abort
    if !exists('t:deol')
        " まだ、作られていない場合、終わり、表示すらされないため
        return 0
    endif

    " 全タブの edit_bufnr のウィンドウを返す
    let l:winid_list = win_findbuf(t:deol.edit_bufnr)
    " カレントタブのウィンドウを取得
    call filter(l:winid_list, 'win_id2tabwin(v:val)[0] ==# tabpagenr()')
    if empty(l:winid_list)
        return 0
    endif

    return l:winid_list[0] ==# t:deol.edit_winid
endfunction


" ====================
" tab の deol を取得
"
" s:get_deol([tabnr])
" ====================
function! s:get_deol() abort
    return gettabvar(tabpagenr(), 'deol', {})
endfunction


" ====================
" バッファがあれば、削除する
" ====================
function! s:bufdelete_if_exists(bufnr) abort
    if bufexists(a:bufnr)
        execute 'bdelete! ' . a:bufnr
    endif
endfunction


" ====================
" editor の行を送信
" 
" s:send_editor([insert_mode])
" TODO: 複数行対応
" ====================
function! s:send_editor(...) abort
    call s:save_history_line(getline('.'))
    exec "normal \<Plug>(deol_execute_line)"
    if get(a:, 1, v:false)
        " 行挿入 (o)
        call feedkeys('o', 'n')
    endif
endfunction


" ====================
" 履歴に保存
" ====================
function! s:save_history_line(line) abort
    if empty(a:line)
        return
    endif

    " すでに履歴にあったら追加しない
    let l:history = readfile(g:deol#shell_history_path)[-g:deol#shell_history_max :]
    if index(l:history, a:line) != -1
        return
    endif

    call writefile([a:line], g:deol#shell_history_path, 'a')
endfunction



" ====================
" --------------------
" sign
" --------------------
" ====================

" sign の定義
call sign_define('my_deol_prompt', {
\   'text': g:deol_prompt_sign,
\   'texthl': 'Comment',
\})


" ====================
" sign の設置
" ====================
function! s:sign_place() abort
    let l:bufnr = bufnr()
    " 取得
    let l:last_lnum = getbufvar(l:bufnr, 'deol_last_lnum', 0)
    if l:last_lnum ==# line('$')
        return
    endif

    for l:idx in range(5)
        let l:lnum = line('$') - l:idx
        if l:lnum >= 1
            call sign_place(l:lnum, 'my_deol', 'my_deol_prompt', l:bufnr, {
            \   'lnum': l:lnum,
            \   'priority': 5,
            \})
        endif
    endfor

    " 保存
    call setbufvar(l:bufnr, 'deol_last_lnum', line('$', bufwinid(l:bufnr)))
endfunction
