scriptencoding utf-8

" XXX: 参考にする https://git.io/JeKIn

" \%(\) : 部分正規表現として保存しない :help /\%(\)
let g:deol#prompt_pattern = 
\   '^\%(PS \)\?' .
\   '[^#>$ ]\{-}' .
\   '\%(' .
\       '> \?'  . '\|' .
\       '# \? ' . '\|' . 
\       '\$' .
\   '\)'

" コマンドの履歴
let g:deol#shell_history_path = expand('~/deol_history')

" job_start() へのオプション
let g:deol#extra_options = {
\   'term_kill': 'kill',
\}

" プロンプト
let s:deol_prompt_sign = '$ '

let s:deol_term_command = 'cmd.exe'

" 履歴ファイルを読めるか
let s:can_read_history_file = filereadable(g:deol#shell_history_path)


nnoremap <silent><A-t> :<C-u>call ToggleDeol()<CR>
tnoremap <silent><A-t> <C-\><C-n>:<C-u>call ToggleDeol()<CR>
nnoremap <Space>re :<C-u>DeolRepl py<CR>


augroup MyDeol
    autocmd!
augroup END

autocmd MyDeol Filetype   deol     call <SID>deol_settings()
autocmd MyDeol Filetype   deoledit call <SID>deol_editor_settings()
autocmd MyDeol DirChanged *        call <SID>deol_cd()


" :q --- QuitPre -> WinLeave
" ====================
" QuitPre:
" ====================
function! s:QuitPre() abort
    " :q したら、deol_quited に 1 をセット
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


" ====================
" DirChanged:
" ====================
function! s:DirChanged(file) abort
    call t:deol.cd(a:file)
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

    " " "\<Right>" じゃだめだった
    " nnoremap <buffer><silent><expr> A     'i' . repeat("<Right>", len(getline('.')))
    " nnoremap <buffer><silent><expr> I     'i' . repeat("<Left>",  len(getline('.')))

    " 不要なマッピングを削除
    nnoremap <buffer>               <C-o> <Nop>
    nnoremap <buffer>               <C-i> <Nop>
    nnoremap <buffer>               <C-e> <Nop>
    nnoremap <buffer>               <C-z> <Nop>
    nnoremap <buffer>               e     <Nop>

    " :q --- QuitPre -> WinLeave
    autocmd MyDeol QuitPre  <buffer> call <SID>QuitPre()
    autocmd MyDeol WinLeave <buffer> call <SID>WinLeave()

    " git dirty とかで飛べるようにするため
    " setlocal path+=FugitiveWorkTree()

endfunction


function! s:deol_editor_settings() abort
    command! -buffer -range -bang SendEditor call <SID>send_editor(<line1>, <line2>, <bang>0)

    if exists('t:deol_repl')
        return
    endif

    autocmd MyDeol TextChangedI,TextChangedP <buffer> call <SID>sign_place()

    inoremap <buffer><silent> <A-e> <Esc>:call <SID>deol_kill_editor()<CR>
    nnoremap <buffer><silent> <A-e> :<C-u>call <SID>deol_kill_editor()<CR>

    inoremap <buffer><silent> <A-t> <Esc>:call <SID>hide_deol(tabpagenr())<CR>
    nnoremap <buffer><silent> <A-t> :<C-u>call <SID>hide_deol(tabpagenr())<CR>

    nnoremap <buffer>         <C-o> <Nop>
    nnoremap <buffer>         <C-i> <Nop>

    nnoremap <buffer><silent> <CR>  :<C-u>SendEditor<CR>
    inoremap <buffer><silent> <CR>  <Esc>:SendEditor!<CR>
    vnoremap <buffer><silent> <CR>  :SendEditor<CR>

    nnoremap <buffer><silent> <Sapce>fl :<C-u>Leaderf line --popup<CR>

    iabbrev <buffer> poe poetry

    inoreabbrev <buffer><expr> py3   deol#abbrev('py3',   'py3',   'py -3')
    inoreabbrev <buffer><expr> pip   deol#abbrev('pip',   'pip',   'py -3 -m pip')
    inoreabbrev <buffer><expr> pipup deol#abbrev('pipup', 'pipup', 'py -3 -m pip install --upgrade')

    inoreabbrev <buffer><expr> h deol#abbrev('h', 'h', 'hub')
    inoreabbrev <buffer><expr> pr deol#abbrev('hub pr', 'pr', 'pr-new')

    resize 5
    setlocal winfixheight

    call s:sign_place()

    " setlocal completefunc=vimrc#git#aliases#complete

endfunction


function! s:deol_cd() abort
    " もし、REPL なら、実行しない
    if exists('t:deol_repl')
        return
    endif
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

    if !exists('t:deol_repl')
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



" ====================
" --------------------
" sign
" --------------------
" ====================

" sign の定義
call sign_define('my_deol_prompt', {
\   'text': s:deol_prompt_sign,
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



" " ==========
" " deol-repl.vim
"
" command! -nargs=1 DeolRepl call <SID>repl_open(<f-args>)
"
" let s:repl_types = {
" \   'py': {
" \       'cmd': 'py\ -3',
" \       'filetype': 'python',
" \       'tabpagenr': -1,
" \       'term_name': 'Python REPL',
" \       'default_imports': [
" \           'import re',
" \           'from pprint import pprint as pp',
" \       ]
" \   }
" \}
"
" " 
" " REPL open
" "
" function! s:repl_open(type) abort
"     " すでにあれば、それを開く
"     let l:repl_tabnr = s:repl_find(a:type)
"     if l:repl_tabnr != -1
"         exec l:repl_tabnr.'tabn'
"         return
"     endif
"
"     tabe
"     let t:deol_repl = {}
"     let t:deol_repl.type = a:type
"
"     let l:info = s:repl_types[a:type]
"     let [g:deol#shell_history_path, l:hist_path] = ['', g:deol#shell_history_path]
"     let l:cwd = getcwd()
"     let b:deol_extra_options = {
"     \   'term_name': l:info.term_name,
"     \   'cwd': getcwd()
"     \}
"     try
"         " 同じディレクトリの場合、同じ edit_buffer が使われてしまうため
"         " cwd 保存 -> temp に cd => deol#start() -> cwd 復元
"         call chdir(fnamemodify(tempname(), ':p:h'))
"         call deol#start(printf('%s -no-start-insert -edit -edit-filetype=%s', l:info.cmd, l:info.filetype))
"     finally
"         call chdir(l:cwd)
"         let g:deol#shell_history_path = l:hist_path
"     endtry
"
"     " 全行削除
"     %d _
"     wincmd H
"     call <SID>repl_settings()
"
"     let l:imports = get(l:info, 'default_imports', [])
"     if len(l:imports) > 0
"         call append(0, l:imports)
"         normal! G
"     endif
" endfunction
"
" "
" " tabpagenr を返す
" "   見つからない場合、-1 を返す
" "
" function! s:repl_find(type) abort
"     for l:tabnr in range(1, tabpagenr('$'))
"         let l:deol_repl = gettabvar(l:tabnr, 'deol_repl', {})
"         if get(l:deol_repl, 'type', '') ==# a:type
"             return l:tabnr
"         endif
"     endfor
"     return -1
" endfunction
"
" function! s:repl_settings() abort
"     if !exists('t:deol_repl')
"         return
"     endif
"
"     command! -buffer -range -bang SendEditor call <SID>repl_send_editor(<line1>, <line2>, <bang>0)
"
"     imap     <buffer><expr>         <CR>  <SID>CR()
"     inoremap <buffer><expr>         <M-j> <SID>deol_repl_cr_mode_toggle()
"     nnoremap <buffer>               <M-j> <Esc>:call <SID>deol_repl_cr_mode_toggle()
"     nnoremap <buffer><silent>       <CR>  :<C-u>SendEditor<CR>
"     vnoremap <buffer><silent>       <CR>  :SendEditor<CR>
"     nnoremap <buffer><silent><expr> o     <SID>o()
"     nnoremap <buffer><silent>       <C-Enter> :<SID>send_empty_line()<CR>
"     nnoremap <buffer><silent>       <M-t> <Nop>
"     nnoremap <buffer><silent>       <M-e> <Nop>
" endfunction
"
" function! s:o() abort
"     if empty(getline('.'))
"         return 'o'
"     endif
"     return ":SendEditor!\<CR>"
" endfunction
"
" function! s:CR() abort
"     let l:line = getline('.')
"     " 行の末尾にカーソルがある場合
"     let l:endpos = empty(trim(l:line[getpos('.')[2]-1 :]))
"     let l:empty_line = empty(getline('.'))
"     if s:deol_repl_cr_send() && endpos && !l:empty_line
"         return "\<Plug>(deol_execute_line)"
"     endif
"     return "\<CR>"
" endfunction
"
" function! s:deol_repl_cr_send_enable() abort
"     let b:deol_repl_cr_send = v:true
"     echohl Todo
"     echo ' [DeolREPL] <CR> send enabled.'
"     echohl None
" endfunction
"
" function! s:deol_repl_cr_send_disable() abort
"     let b:deol_repl_cr_send = v:false
"     echohl Todo
"     echo ' [DeolREPL] <CR> send disabled.'
"     echohl None
" endfunction
"
" function! s:deol_repl_cr_mode_toggle() abort
"     if s:deol_repl_cr_send()
"         call s:deol_repl_cr_send_disable()
"     else
"         call s:deol_repl_cr_send_enable()
"     endif
"     return ''
" endfunction
"
" function! s:deol_repl_cr_send() abort
"     return getbufvar(bufnr(), 'deol_repl_cr_send', v:false)
" endfunction
"
"
" " ====================
" " editor の行を送信
" " 
" " s:send_editor([insert_mode])
" " ====================
" function! s:repl_send_editor(line1, line2, new_line) abort
"     let l:lines = getline(a:line1, a:line2)
"
"     " 空行のみだった場合、終わり
"     let l:empty_only = v:true
"     for l:line in l:lines
"         if !empty(l:line)
"             let l:empty_only = v:false
"             break
"         endif
"     endfor
"     if l:empty_only
"         return
"     endif
"
"     if !exists('t:deol_repl')
"         for l:line in l:lines
"             call s:save_history_line(l:line)
"         endfor
"     endif
"
"     for l:line in getline(a:line1, a:line2)
"         call t:deol.jobsend(l:line . "\<CR>")
"     endfor
"     " exec printf("%d,%dnormal \<Plug>(deol_execute_line)", a:line1, a:line2)
"
"     " 複数行なら、最後の行にジャンプ
"     if !empty(visualmode()) && a:line1 !=# a:line2
"         normal! '>
"     endif
"
"     if a:new_line
"         " 行挿入 (o)
"         call feedkeys('o', 'n')
"     else
"         if !empty(visualmode()) && a:line1 !=# a:line2
"             normal! '>j
"         endif
"     endif
" endfunction
"
" function! s:send_empty_line() abort
"     call t:deol.jobsend("\<CR>")
" endfunction
