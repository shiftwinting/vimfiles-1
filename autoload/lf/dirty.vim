scriptencoding utf-8

" ============================================================================
" git 内の編集しているファイル
" ============================================================================

let s:Filepath = vital#vital#import('System.Filepath')

let s:info = {
\   'preview_bufnr': -1,
\   'lines': [],
\   'job': v:null,
\   'worktree': ''
\}

function! lf#dirty#source_type() abort
    return 'commnad_funcref'
endfunction

function! lf#dirty#source(args) abort
    return 'git status --porcelain -uall'
endfunction

function! lf#dirty#accept(line, args) abort
    let l:file = split(a:line, ' ')[1]
    " TODO: split やら tab やらに対応する
    exec 'edit ' . s:Filepath.to_slash(expand(s:info.worktree . '/' . l:file))
endfunction

function! s:add_line(ch, msg) abort
    " 先頭の行はいらない
    if a:msg =~# '^\(diff \|index \|--- a\|+++ b\)'
        return
    endif
    call add(s:info.lines, a:msg)
endfunction

function! s:setline_preview_buf(lines, ft) abort
    if !bufexists(s:info.preview_bufnr)
        return
    endif
    " 結果をセットする
    call setbufvar(s:info.preview_bufnr, '&ft', a:ft)
    silent call deletebufline(s:info.preview_bufnr, 1, '$')
    silent call setbufline(s:info.preview_bufnr, 1, a:lines)
endfunction

function! lf#dirty#preview(orig_buf_nr, orig_cursor, line, arguments) abort
    if s:info.job != v:null
        call job_stop(s:info.job, "kill")
    endif
    let s:info.lines = []

    let l:file = split(a:line, ' ')[1]
    if a:line =~# '^?? '
        " 知らないファイルは普通に表示
        let l:path = s:info.worktree . '/' . l:file
        if filereadable(l:path)
            call s:setline_preview_buf(readfile(l:path), 'text')
        else
            call s:setline_preview_buf(["Could not read file."], 'text')
        endif
    else
        call s:setline_preview_buf(['...'], 'text')
        " --staged をつけると、インデックスと最新のコミットとの変更点を表示
        let l:opts = a:line =~# '^M ' ? '--staged' : ''
        let l:cmd = printf('git diff %s %s', l:opts, l:file)

        let s:info.job = job_start([&shell, &shellcmdflag, l:cmd], {
        \   'close_cb': {ch->s:setline_preview_buf(s:info.lines, 'diff')},
        \   'out_cb': funcref('s:add_line'),
        \})
    endif
    return [s:info.preview_bufnr, 1, '']
endfunction

function! lf#dirty#before_enter(args) abort
    " プレビューのところでやるとカーソル移動が遅くなるから
    echomsg '2'
    let l:bufnr = bufadd('lf_dirty_preview') 
    echomsg '1'
    silent! call bufload(l:bufnr)
    echomsg '3'

    try
        " from instance.py
        call setbufvar(l:bufnr, '&buflisted',   0)
        call setbufvar(l:bufnr, '&buftype',     'nofile')
        call setbufvar(l:bufnr, '&bufhidden',   'hide')
        call setbufvar(l:bufnr, '&undolevels',  -1)
        call setbufvar(l:bufnr, '&swapfile',    0)
        " call setbufvar(l:bufnr, '&filetype',    'diff')
    catch /*/
        " pass
    endtry

    echomsg '4'
    let s:info = {
    \   'preview_bufnr': l:bufnr,
    \   'lines': [],
    \   'job': 0,
    \   'worktree': vimrc#git#worktree(),
    \}
    echomsg s:info
endfunction

function! lf#dirty#highlights_def() abort
    return {
    \   'Lf_hl_dirty_updated_index': '^M  .*$',
    \   'Lf_hl_dirty_change': '^.M .*$',
    \   'Lf_hl_dirty_untracked': '^?? .*$',
    \   'Lf_hl_dirty_delete': '^[D ][D ] .*$',
    \}
endfunction

function! lf#dirty#highlights_cmd() abort
    return [
    \   'hi Lf_hl_dirty_updated_index guifg=#A3BE8C',
    \   'hi Lf_hl_dirty_change        guifg=#D08770',
    \   'hi Lf_hl_dirty_untracked     guifg=#81A1C1',
    \   'hi Lf_hl_dirty_delete        guifg=#BF616A',
    \]
endfunction
