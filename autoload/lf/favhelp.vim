scriptencoding utf-8

" ============================================================================
" よく使うヘルプ
" ============================================================================

let s:fav_helps = [
\   ['function-list',      '関数一覧'],
\   ['user-commands',      'command の書き方'],
\   ['autocmd-events',     'autocmd 一覧'],
\   ['E500',               '<cword> とか <afile> とか'],
\   ['usr_41',             'Vim script 基本'],
\   ['pattern-overview',   '正規表現'],
\   ['eval',               'Vim script [tips]'],
\   ['ex-cmd-index',       '":"のコマンド'],
\   ['filename-modifiers', ':p とか :h とか'],
\   ['index',              '各モードのマッピング'],
\   ['popup-window',       'ポップアップのヘルプ'],
\   ['job-options',        'job のオプション集'],
\]

function! lf#favhelp#source_type() abort
    return 'funcref'
endfunction

function! lf#favhelp#source(args) abort
    return lf#space_between(s:fav_helps)
endfunction

function! s:favhelp_accept(line, args) abort
    exec 'help ' . trim(split(a:line, '|')[0])
endfunction

function! lf#favhelp#highlights_def() abort
    return {
    \   'Lf_hl_favhelp_comment': '|\zs .*$',
    \}
endfunction

function! lf#favhelp#highlights_cmd() abort
    return [
    \   'hi link Lf_hl_favhelp_comment Comment',
    \]
endfunction


" XXX: プレビューしたい

" \   'preview': s:func('s:favhelp_preview'),
" \   'before_enter': s:func('s:favhelp_before_enter'),

" let s:favhelp = {
" \   'help_tags': {},
" \   'preview_bufnr': -1,
" \}

" function! s:favhelp_before_enter(args) abort
"     " プレビューのところでやるとカーソル移動が遅くなるから
"     let l:bufnr = bufadd('lf_favhelp_preview') 
"     silent! call bufload(l:bufnr)
"
"     try
"         " from instance.py
"         call setbufvar(l:bufnr, '&buflisted',   0)
"         call setbufvar(l:bufnr, '&buftype',     'nofile')
"         call setbufvar(l:bufnr, '&bufhidden',   'hide')
"         call setbufvar(l:bufnr, '&undolevels',  -1)
"         call setbufvar(l:bufnr, '&swapfile',    0)
"         call setbufvar(l:bufnr, '&filetype',    'help')
"     catch /*/
"         " pass
"     endtry
"
"     let s:favhelp = {
"     \   'help_tags': s:make_help_tags(),
"     \   'preview_bufnr': l:bufnr,
"     \}
" endfunction
"
" function! s:make_help_tags() abort
"     if !empty(s:favhelp.help_tags)
"         return s:favhelp.help_tags
"     endif
"
"     let l:help_tags = {}
"     for dir in split(&runtimepath, ',')
"         let l:tags_file = s:Filepath.join(dir, 'doc', 'tags')
"         if filereadable(l:tags_file)
"             let l:lines = readfile(l:tags_file)
"             for l:line in l:lines
"                 let [l:tag, l:file] = split(l:line)[:1]
"                 let l:help_tags[l:tag] = {
"                 \   'dir': dir,
"                 \   'file': l:file
"                 \}
"             endfor
"         endif
"     endfor
"     return l:help_tags
" endfunction

" function! s:favhelp_preview(orig_buf_nr, orig_cursor, line, arguments) abort
"     " どうやって表示しよう
" endfunction
