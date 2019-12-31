scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/deol.vim'))
    finish
endif

" XXX: 参考にする https://git.io/JeKIn

" \%(\) : 部分正規表現として保存しない :help /\%(\)
" \%(>\|# \?\|\$\) :  > # $ 
let g:deol#prompt_pattern = '[^#>$ ]\{-}\%(>\|# \?\|\$\)'

" コマンドの履歴
let g:deol#shell_history_path = expand('~/deol_history')

augroup MyDeol
    autocmd!
    autocmd Filetype deol call DeolSettings()
    " expand('<afile>') とする
    autocmd BufWinEnter * if expand('<afile>') ==# 'deol-edit' | call DeolEditorSettings() | endif
    autocmd DirChanged * if !empty(gettabvar(tabpagenr(), 'deol', {})) | call deol#cd(expand('<afile>')) | endif
augroup END

function! DeolSettings() abort
    tmap     <buffer><silent> <A-e> <C-w>:call deol#edit()<CR>
    nmap     <buffer><silent> <A-e> <Esc>:call HideDeol(tabpagenr())<CR>
    nmap     <buffer><silent> <A-t> <Esc>:call HideDeol(tabpagenr())<CR>

    " "\<Right>" じゃだめだった
    nnoremap <buffer><silent><expr> A
    \   'i' . repeat("<Right>", len(getline('.')))
    nnoremap <buffer><silent><expr> I
    \   'i' . repeat("<Left>", len(getline('.')))

    " 不要なマッピングを削除
    nnoremap <buffer>         <C-o> <Nop>
    nnoremap <buffer>         <C-i> <Nop>
    nnoremap <buffer>         <C-e> <Nop>
    nnoremap <buffer>         <C-z> <Nop>
    nnoremap <buffer>         e     <Nop>
endfunction

function! DeolEditorSettings() abort
    imap <buffer><silent> <C-q> <Esc>:call DeolKillEditor()<CR>
    imap <buffer><silent> <A-e> <Esc>:call DeolKillEditor()<CR>
    nmap <buffer><silent> <C-q> :<C-u>call DeolKillEditor()<CR>
    nmap <buffer><silent> <A-e> :<C-u>call DeolKillEditor()<CR>

    imap <buffer><silent> <A-t> <Esc>:call HideDeol(tabpagenr())<CR>
    nmap <buffer><silent> <A-t> :<C-u>call HideDeol(tabpagenr())<CR>

    nnoremap <buffer>         <C-o> <Nop>
    nnoremap <buffer>         <C-i> <Nop>

    " CR のマッピングを上書きしないようにする
    let b:pear_tree_map_special_keys = 0

    setlocal winfixheight
endfunction


" タブが閉じられたとき、TabLeave -> TabClosed の順で実行される
" TabLeave  : g:last_tab に保存しておく
" TabClosed : g:last_tab の t:deol を削除

" TODO: 最後のタブだった場合、どうするか

augroup MyDeolTabClosed
    autocmd!
    autocmd TabLeave * let g:last_tab_deol = gettabvar(tabpagenr(), 'deol', {})
    autocmd TabClosed * call DeolTabClosed()
augroup END

function! DeolTabClosed() abort
    if !exists('g:last_tab_deol') || empty(g:last_tab_deol)
        return
    endif

    " XXX: kill で終了するようにしているため、少し危なっかしいかも？
    call term_setkill(g:last_tab_deol.bufnr, 'kill')

    if bufexists(g:last_tab_deol.bufnr)
        echomsg g:last_tab_deol.bufnr
        execute 'bdelete! ' . g:last_tab_deol.bufnr
    endif
    " if bufexists(g:last_tab_deol.edit_bufnr)
    "     echomsg g:last_tab_deol.edit_bufnr
    "     execute 'bdelete! ' . g:last_tab_deol.edit_bufnr
    " endif

    unlet g:last_tab_deol
endfunction

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

function! DeolKillEditor() abort
    let l:deol = gettabvar(tabpagenr(), 'deol', {})
    if empty(l:deol)
        " まだ、作られていない場合、終わり
        return
    endif

    " 履歴を追加
    call s:save_history(l:deol.edit_bufnr)
    execute 'bdelete! ' . l:deol.edit_bufnr
    call win_gotoid(bufwinid(l:deol.bufnr))
endfunction

function! ShowDeol(tabnr, ...) abort
    let l:deol = gettabvar(a:tabnr, 'deol', {})

    if a:0 ==# 1
        let l:command = a:1
    else
        let l:command = &shell
    endif

    botright 25new
    setlocal winfixheight

    if empty(l:deol) || !bufexists(l:deol.bufnr)
        call deol#start(printf('-edit -cwd=%s -command=%s', getcwd(), l:command))
    else
        " 復活
        try
            " うまくできなかったため、エラーは無視する
            execute 'buffer +normal!\ i ' . l:deol.bufnr
        catch /.*/
            " ignore
        endtry
        call deol#edit()
    endif
endfunction


function! HideDeol(tabnr) abort
    let l:deol = gettabvar(a:tabnr, 'deol', {})
    if empty(l:deol)
        " まだ、作られていない場合、終わり
        return
    endif

    " リストが返されるため
    if win_findbuf(l:deol.edit_bufnr) ==# [l:deol.edit_winid]
        call DeolKillEditor()
    endif

    call win_gotoid(bufwinid(l:deol.bufnr))
    if l:deol.bufnr ==# bufnr()
        execute 'hide'
    endif

endfunction


function! IsShowDeol(tabnr) abort
    let l:deol = gettabvar(a:tabnr, 'deol', {})
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


function! ToggleDeol(tabnr) abort
    if IsShowDeol(a:tabnr)
        call HideDeol(a:tabnr)
    else
        call ShowDeol(a:tabnr)
    endif
endfunction


command! DeolOpen :<C-u>Deol<CR>
command! ToggleDeol call ToggleDeol(tabpagenr())
nnoremap <silent><A-t> :<C-u>ToggleDeol<CR>
tnoremap <silent><A-t> <C-\><C-n>:<C-u>ToggleDeol<CR>

