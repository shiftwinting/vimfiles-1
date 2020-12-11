scriptencoding utf-8

UsePlugin 'deol.nvim'

" \%(\) : 部分正規表現として保存しない :help /\%(\)
let g:deol#prompt_pattern = 
\   '^\%(PS \)\?' .
\   '[^#>$ ]\{-}' .
\   '\%(' .
\       '> \?'  . '\|' .
\       '# \? ' . '\|' . 
\       '\$' .
\       '\$ ' .
\   '\)'

" コマンドの履歴
let g:deol#shell_history_path = has('nvim') ? expand('~/.zsh_history') : expand('~/deol_history')

" job_start() へのオプション
let g:deol#extra_options = {
\   'term_kill': 'kill',
\}

let s:deol_term_command = 'zsh'

command! ShowDeol call <SID>show_deol(tabpagenr())

nnoremap <silent><A-t> :<C-u>call ToggleDeol()<CR>
tnoremap <silent><A-t> <C-\><C-n>:<C-u>call ToggleDeol()<CR>

" ====================
" deol を表示
" 
" s:show_deol(tabnr[, command])
" ====================
function! s:show_deol(tabnr, ...) abort
    let l:command = get(a:, 1, &shell)
    let l:filetype = get(a:, 2, 'deoledit')

    botright 25new
    setlocal winfixheight

    if !exists('t:deol') || !bufexists(t:deol.bufnr)
        " 新規作成
        execute 'Deol -edit -no-start-insert -command=' . l:command . ' -edit-filetype=' . l:filetype
    else
        Deol -edit -no-start-insert
    endif
endfunction


augroup MyDeol
    autocmd!
augroup END

autocmd MyDeol Filetype   deol     call <SID>deol_settings()
autocmd MyDeol Filetype   deoledit call <SID>deol_editor_settings()
autocmd MyDeol DirChanged *        call <SID>deol_cd()


" ====================
" DirChanged:
" ====================
function! s:DirChanged(file) abort
    call t:deol.cd(a:file)
endfunction

function! s:deol_settings() abort
    if has('nvim')
        tnoremap <buffer><silent> <A-e> <C-\><C-N>:call deol#edit()<CR>
        inoremap <buffer><silent> <A-e> <C-\><C-N>:call deol#edit()<CR>
        tnoremap <buffer>         <A-h> <C-\><C-N><C-w>h
        tnoremap <buffer>         <A-j> <C-\><C-N><C-w>j
        tnoremap <buffer>         <A-k> <C-\><C-N><C-w>k
        tnoremap <buffer>         <A-l> <C-\><C-N><C-w>l
        inoremap <buffer>         <A-h> <C-\><C-N><C-w>h
        inoremap <buffer>         <A-j> <C-\><C-N><C-w>j
        inoremap <buffer>         <A-k> <C-\><C-N><C-w>k
        inoremap <buffer>         <A-l> <C-\><C-N><C-w>l
    else
        tnoremap <buffer><silent>       <A-e> <C-w>:call         deol#edit()<CR>
    endif
    " nnoremap <buffer><silent>       <A-e> <Esc>:<C-u>normal! i<CR>
    nnoremap <buffer><silent>       <A-e> <Esc>:<C-u>call deol#edit()<CR>
    nnoremap <buffer><silent>       <A-e> <Esc>:call         <SID>hide_deol(tabpagenr())<CR>

    " " "\<Right>" じゃだめだった
    " nnoremap <buffer><silent><expr> A     'i' . repeat("<Right>", len(getline('.')))
    " nnoremap <buffer><silent><expr> I     'i' . repeat("<Left>",  len(getline('.')))

    " 不要なマッピングを削除
    nnoremap <buffer>               <C-o> <Nop>
    nnoremap <buffer>               <C-i> <Nop>
    nnoremap <buffer>               <C-e> <Nop>
    nnoremap <buffer>               <C-z> <Nop>
    nnoremap <buffer>               e     e

    " " :q --- QuitPre -> WinLeave
    " autocmd MyDeol QuitPre  <buffer> call <SID>QuitPre()
    " autocmd MyDeol WinLeave <buffer> call <SID>WinLeave()

    " git dirty とかで飛べるようにするため
    " setlocal path+=FugitiveWorkTree()

endfunction


function! s:deol_editor_settings() abort
    command! -buffer -range -bang SendEditor call <SID>send_editor(<line1>, <line2>, <bang>0)

    " if exists('t:deol_repl')
    "     return
    " endif

    " autocmd MyDeol TextChangedI,TextChangedP <buffer> call <SID>sign_place()

    inoremap <buffer><silent> <A-e> <Esc>:call <SID>deol_kill_editor()<CR>
    nnoremap <buffer><silent> <A-e> :<C-u>call <SID>deol_kill_editor()<CR>
    inoremap <buffer><silent> <A-t> <Esc>:call <SID>hide_deol(tabpagenr())<CR>
    nnoremap <buffer><silent> <A-t> :<C-u>call <SID>hide_deol(tabpagenr())<CR>

    nnoremap <buffer>         <C-o> <Nop>
    nnoremap <buffer>         <C-i> <Nop>

    nnoremap <buffer><silent> <CR>  :<C-u>SendEditor<CR>
    inoremap <buffer><silent> <CR>  <Esc>:SendEditor!<CR>
    vnoremap <buffer><silent> <CR>  :SendEditor<CR>

    nnoremap <buffer><silent> cd :<C-u>Leaderf fd_dir --popup<CR>

    resize 5
    setlocal winfixheight

    " call s:sign_place()

    setlocal filetype=zsh

endfunction


function! s:deol_cd() abort
    call deol#cd(fnamemodify(expand('<afile>'), ':p:h'))
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
        call s:show_deol(l:tabnr, s:deol_term_command)
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
        " call deol#kill_editor()
    endif

    call win_gotoid(bufwinid(t:deol.bufnr))
    if t:deol.bufnr ==# bufnr()
        execute 'hide'
    endif

endfunction


function! s:is_show_deol(tabnr) abort
    if !exists('t:deol')
        " まだ、作られていない場合、終わり、表示すらされないため
        return v:false
    endif

    if empty(win_findbuf(t:deol.bufnr))
        " バッファが表示されているウィンドウが見つからない
        return v:false
    endif
    return v:true
endfunction


" ====================
" deol-edit が表示されているか
"
" s:is_show_deol_edit([tabnr])
" ====================
function! s:is_show_deol_edit(...) abort
    if !exists('t:deol')
        " まだ、作られていない場合、終わり、表示すらされないため
        return v:false
    endif

    " 全タブの edit_bufnr のウィンドウを返す
    let l:winid_list = win_findbuf(t:deol.edit_bufnr)
    " カレントタブのウィンドウを取得
    call filter(l:winid_list, 'win_id2tabwin(v:val)[0] ==# tabpagenr()')
    if empty(l:winid_list)
        return v:false
    endif

    return l:winid_list[0] ==# t:deol.edit_winid
endfunction

" ====================
" バッファがあれば、削除する
" ====================
function! s:bufdelete_if_exists(bufnr) abort
    if bufexists(a:bufnr)
        execute 'silent! bdelete! ' . a:bufnr
    endif
endfunction


" ====================
" editor の行を送信
" 
" s:send_editor([insert_mode])
" ====================
function! s:send_editor(line1, line2, new_line) abort
    let l:lines = getline(a:line1, a:line2)

    if !has('nvim')
        for l:line in l:lines
            call s:save_history_line(l:line)
        endfor
    endif

    exec printf("%d,%dnormal \<Plug>(deol_execute_line)", a:line1, a:line2)

    " 複数行なら、最後の行にジャンプ
    if !empty(visualmode()) && a:line1 !=# a:line2
        normal! '>
    endif

    if a:new_line
        " 行挿入 (o)
        call feedkeys('o', 'n')
    else
        if !empty(visualmode()) && a:line1 !=# a:line2
            normal! '>j
        endif
    endif
endfunction


" ====================
" 履歴に保存
" ====================
function! s:save_history_line(line) abort
    if empty(a:line)
        return
    endif

    " すでに履歴にあったら末尾に移動する
    let l:history = readfile(g:deol#shell_history_path)
    if len(l:history) > g:deol#shell_history_max
        " [1, 2, 3, 4, 5][-3:] ==# [3, 4, 5]
        let l:history = l:history[-g:deol#shell_history_max:]
    endif
    let l:idx = index(l:history, a:line)
    if l:idx > -1
        " 削除
        call remove(l:history, l:idx)
    endif
    call add(l:history, a:line)
    call writefile(l:history, g:deol#shell_history_path)
endfunction
