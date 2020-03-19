scriptencoding utf-8

" XXX: 参考にする https://git.io/JeKIn

" \%(\) : 部分正規表現として保存しない :help /\%(\)
" \%(>\|# \?\|\$\) :  > # $ 
let g:deol#prompt_pattern = '[^#>$ ]\{-}\%(>\|# \?\|\$\)'

" コマンドの履歴
let g:deol#shell_history_path = expand('~/deol_history')


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
    let  g:last_tab_deol = <SID>get_deol()
endfunction


" ====================
" TabClosed:
" ====================
function! s:TabClosed() abort
    " TODO: 最後のタブだった場合、どうするか

    if !exists('g:last_tab_deol') || empty(g:last_tab_deol)
        return
    endif

    " XXX: kill で終了するようにしているため、少し危なっかしいかも？
    call term_setkill(g:last_tab_deol.bufnr, 'kill')

    call s:bufdelete_if_exists(g:last_tab_deol.bufnr)

    unlet g:last_tab_deol
endfunction


" ====================
" DirChanged:
" ====================
function! s:DirChanged(file) abort
    if !empty(<SID>get_deol())
        call deol#cd(a:file)
    endif
endfunction


function! s:deol_settings() abort
    tnoremap <buffer><silent>       <A-e> <C-w>:call deol#edit()<CR>
    nnoremap <buffer><silent>       <A-e> <Esc>:<C-u>normal! i<CR>
    nnoremap <buffer><silent>       <A-t> <Esc>:call <SID>hide_deol(tabpagenr())<CR>

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
    autocmd MyDeol QuitPre  <buffer> call setbufvar(bufnr(), 'deol_quited', 1)
    autocmd MyDeol WinLeave <buffer> call <SID>WinLeave()

endfunction


function! s:deol_editor_settings() abort
    imap     <buffer><silent> <C-q> <Esc>:call <SID>deol_kill_editor()<CR>
    imap     <buffer><silent> <A-e> <Esc>:call <SID>deol_kill_editor()<CR>
    nmap     <buffer><silent> <C-q> :<C-u>call <SID>deol_kill_editor()<CR>
    nmap     <buffer><silent> <A-e> :<C-u>call <SID>deol_kill_editor()<CR>

    imap     <buffer><silent> <A-t> <Esc>:call <SID>hide_deol(tabpagenr())<CR>
    nmap     <buffer><silent> <A-t> :<C-u>call <SID>hide_deol(tabpagenr())<CR>

    nnoremap <buffer>         <C-o> <Nop>
    nnoremap <buffer>         <C-i> <Nop>

    call s:deoledit_abbrev()

"   " XXX: 自動で行補完したい

    iabbrev <buffer> poe poetry

    resize 5
    setlocal winfixheight
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
" s:deol_kill_editor([save_history])
" ====================
function! s:deol_kill_editor(...) abort
    let l:save_history = get(a:, 1, 1)

    let l:deol = s:get_deol()
    " まだ、作られていない場合、終わり
    if empty(l:deol)
        return
    endif

    " 履歴を追加
    if l:save_history
        call s:save_history(l:deol.edit_bufnr)
    endif

    " バッファがあれば削除
    call s:bufdelete_if_exists(l:deol.edit_bufnr)

    call win_gotoid(bufwinid(l:deol.bufnr))
endfunction


" ====================
" deol を表示
" 
" s:show_deol(tabnr[, command])
" ====================
function! s:show_deol(tabnr, ...) abort
    let l:command = get(a:, 1, &shell)

    let l:deol = s:get_deol(a:tabnr)

    botright 25new
    setlocal winfixheight

    if empty(l:deol) || !bufexists(l:deol.bufnr)
        " 新規作成
        call deol#start(printf('-edit -cwd=%s -command=%s -edit-filetype=deoledit', getcwd(), l:command))
    else
        " 既存を使用
        try
            " うまくできなかったため、エラーは無視する
            execute 'buffer +normal!\ i ' . l:deol.bufnr
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
    let l:deol = s:get_deol(a:tabnr)
    if empty(l:deol)
        " まだ、作られていない場合、終わり
        return
    endif

    if s:is_show_deol_edit()
        call s:deol_kill_editor()
    endif

    call win_gotoid(bufwinid(l:deol.bufnr))
    if l:deol.bufnr ==# bufnr()
        execute 'hide'
    endif

endfunction


function! s:is_show_deol(tabnr) abort
    let l:deol = s:get_deol(a:tabnr)
    if empty(l:deol)
        " まだ、作られていない場合、終わり、表示すらされないため
        return 0
    endif

    if empty(win_findbuf(l:deol.bufnr))
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
    let l:tabnr = get(a:, 1, tabpagenr())
    let l:deol = s:get_deol(a:tabnr)
    if empty(l:deol)
        " まだ、作られていない場合、終わり、表示すらされないため
        return 0
    endif

    " リストが返されるため、[] としている
    return win_findbuf(l:deol.edit_bufnr) ==# [l:deol.edit_winid]
endfunction


" ====================
" tab の deol を取得
"
" s:get_deol([tabnr])
" ====================
function! s:get_deol(...) abort
    let l:tabnr = get(a:, 1, tabpagenr())
    return gettabvar(l:tabnr, 'deol', {})
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
" 履歴に保存
"
" s:save_history(bufnr)
" ====================
function! s:save_history(bufnr) abort
    let l:history_path = expand(g:deol#shell_history_path)
    if !filereadable(l:history_path)
        return
    endif

    let l:history = readfile(l:history_path)[-g:deol#shell_history_max :]
    " let l:history = map(l:history,
    " \   'substitute(v:val, "^\\%(\\d\\+/\\)\\+[:[:digit:]; ]\\+\\|^[:[:digit:]; ]\\+", "", "g")')

    " XXX: 履歴にないものだけ追加したい
    let l:lines = filter(getbufline(a:bufnr, 1, '$'), 
    \       'index(l:history, v:val) ==# -1 && !empty(trim(v:val))')

    call writefile(l:lines, l:history_path, 'a')
endfunction
