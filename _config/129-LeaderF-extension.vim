scriptencoding utf-8

" 書き方は以下を参照
" * https://github.com/Yggdroot/LeaderF/issues/144#issuecomment-540008950
" * http://bit.ly/2NdiX1x

" packadd
" mrw
" sonictemplate
" vim-nayvy
" ghq


let s:Filepath = vital#vital#import('System.Filepath')

let g:Lf_Extensions = get(g:, 'Lf_Extensions', {})

function! s:func(func_name) abort
    " function('<SNR>476_sample_func') -> <SNR>476_sample_func
    return string(function(a:func_name))[10:-3]
endfunction

" a:linesは [[str, str], [str, str], ...] のようなリスト
" 例)
"   :echo s:space_between([['mac', 'text1'], ['windows', 'text2']])
" [
" \ 'mac      | text1',
" \ 'windows  | text2',
" ]
function! s:space_between(line_items) abort
    let l:result = []
    " 1つ目の要素の最大の長さを返す
    let l:max_len = max(map(copy(a:line_items), {_,x -> strdisplaywidth(x[0])}) + [0])
    for l:line_item in a:line_items
        let l:space = l:max_len - strdisplaywidth(l:line_item[0])
        call add(l:result, printf('%s%s | %s', l:line_item[0], repeat(' ', l:space), l:line_item[1]))
    endfor
    return l:result
endfunction

" ============================================================================
" packadd
" ============================================================================
function! s:packadd_source(args) abort
    let l:result = []
    for path in split(globpath(&packpath, '/pack/*/opt/*'))
        if isdirectory(path)
            call add(l:result, fnamemodify(path, ':t'))
        endif
    endfor
    return l:result
endfunction

function! s:packadd_accept(line, args) abort
    execute 'packadd '.a:line
endfunction

let g:Lf_Extensions.packadd = {
\   'source': s:func('s:packadd_source'),
\   'accept': s:func('s:packadd_accept'),
\}
command! Tpackadd Leaderf packadd --popup



" ============================================================================
" git switch
" ============================================================================
" ---------------------
" accept
" ---------------------
function! s:switch_accept(line, args) abort
    call system('git switch ' . a:line)
    echo printf(" Switched to branch '%s'", a:line)
endfunction

" ---------------------
" format_list
" ---------------------
function! s:switch_format_list(list, args) abort
    return filter(copy(a:list), 'v:val[0] !=# "*"')
endfunction

" ---------------------
" format_line
" ---------------------
function! s:switch_format_line(line, args) abort
    return trim(a:line)
endfunction

let g:Lf_Extensions.switch = {
\   'source': {'command': 'git branch'},
\   'accept':      s:func('s:switch_accept'),
\   'format_list': s:func('s:switch_format_list'),
\   'format_line': s:func('s:switch_format_line'),
\}


" ============================================================================
" mrw
" ============================================================================
"
" function! s:mrw_source(args) abort
"     let l:files = mrw#read_cachefile(expand('%'))
"     let l:result = []
"     " from mrw.vim
"     let l:max_filename_len = max(map(copy(l:files), {i,x -> strdisplaywidth(fnamemodify(x, ':p:t'))}) + [0])
"     for l:file in l:files
"         let l:name = fnamemodify(l:file, ':p:t')
"         let l:space = l:max_filename_len - strdisplaywidth(l:name)
"         call add(l:result, printf('%s%s "%s"', l:name, repeat(' ', l:space), fnamemodify(l:file, ':p:h')))
"     endfor
"     return l:result
" endfunction
"
" function! s:mrw_get_digest(line, mode) abort
"     if a:mode ==# 0
"         return [a:line, 0]
"     elseif a:mode ==# 1
"         let l:end = stridx(a:line, ' ')
"         return [a:line[:l:end-1], 0]
"     else
"         let l:start = stridx(a:line, ' "')
"         return [a:line[l:start+2: -1], strlen(a:line) - 1]
"     endif
" endfunction
"
" function! s:mrw_accept(line, args) abort
"     let l:path = s:mrw_get_digest(a:line, 2)[0][:-2]
"     \           . '/'
"     \           . s:mrw_get_digest(a:line, 1)[0]
"     exec 'drop ' . l:path
" endfunction
"
" let g:Lf_Extensions.mrw = {
" \   'source':     s:func('s:mrw_source'),
" \   'accept':     s:func('s:mrw_accept'),
" \   'get_digest': s:func('s:mrw_get_digest'),
" \   'supports_name_only': 1,
" \}
"
"
" " ============================================================================
" " todo
" " ============================================================================
" let s:todo_dict = {
" \   'cancel':           'call todo#ToggleMarkAsDone("Cancelled")',
" \   'done':             'call todo#ToggleMarkAsDone("")',
" \   'add_due':          "normal! A due:\<C-R>=strftime('%Y-%m-%d')\<CR>\<Esc>0"
" \}
"
" function! s:todo_source(args) abort
"     return keys(s:todo_dict)
" endfunction
"
" function! s:todo_accept(line, args) abort
"     silent execute s:todo_dict[a:line]
" endfunction
"
" let g:Lf_Extensions.todo = {
" \   'source': s:func('s:todo_source'),
" \   'accept': s:func('s:todo_accept'),
" \}



" ============================================================================
" sonictemplate
" TODO: Preview する (どのファイル化を検索するロジック難しそう？)
" ============================================================================
function! s:sonictemplate_source(args) abort
    return sonictemplate#complete('', '', '')
endfunction

function! s:sonictemplate_accept(line, args) abort
    execute 'Template '.a:line
endfunction

let g:Lf_Extensions.sonictemplate = {
\   'source': s:func('s:sonictemplate_source'),
\   'accept': s:func('s:sonictemplate_accept'),
\}




" ============================================================================
" vim-nayvy
" ============================================================================


if !empty(globpath(&rtp, 'autoload/nayvy.vim'))


py3 << EOF

import vim
from nayvy_vim_if import *

def nayvy_list_imports_no_color() -> List[str]:
    ''' List all available imports
    '''
    filepath = vim.eval('expand("%")')
    stmt_map = init_import_stmt_map(filepath)
    if stmt_map is None:
        return []
    return [
        single_import.to_line(color=False)
        for _, single_import in stmt_map.items()
    ]

EOF


function! s:nayvy_source(args) abort
    return py3eval('nayvy_list_imports_no_color()')
endfunction


function! s:nayvy_accept(line, args) abort
    let l:names = [split(a:line, ' : ')[0]]
    let l:py_expr = 'nayvy_import(' . string(l:names) . ')'
    call py3eval(l:py_expr)
endfunction


function! s:nayvy_get_digest(line, mode) abort
    if a:mode ==# 0
        return [a:line, 0]
    elseif a:mode ==# 1
        let l:end = stridx(a:line, ' : ')
        return [a:line[:l:end-1], 0]
    else
        let l:start = stridx(a:line, ' : ')
        return [a:line[l:start : -1], strlen(a:line)]
    endif
endfunction


let g:Lf_Extensions.nayvy = {
\   'source': s:func('s:nayvy_source'),
\   'accept': s:func('s:nayvy_accept'),
\   'supports_name_only': 1,
\   'get_digest': s:func('s:nayvy_get_digest')
\}

endif


" ============================================================================
" ghq
" ============================================================================
function! s:ghq_accept(line, args) abort
    let l:path = $GHQ_ROOT . '/github.com/' . a:line
    execute 'tabe | tcd ' . l:path
endfunction

function! s:ghq_format_line(line, args) abort
    " 'github.com ' 以降を取得
    return a:line[11:]
endfunction

let g:Lf_Extensions.ghq = {
\   'source': {'command': 'ghq list'},
\   'accept': s:func('s:ghq_accept'),
\   'format_line': s:func('s:ghq_format_line'),
\}


" ============================================================================
" gv
" ============================================================================

" --------------------
" source
" --------------------
function! s:gv_source(...) abort
    if &filetype !=# 'GV'
        return []
    endif

    return [
    \   'CherryPick',
    \   'CreateBranch',
    \]
endfunction

" --------------------
" accept
" --------------------
function! s:gv_accept(line, args) abort
    call feedkeys(':' . a:line, 'n')
endfunction

let g:Lf_Extensions.gv = {
\   'source': s:func('s:gv_source'),
\   'accept': s:func('s:gv_accept'),
\}


" ============================================================================
" git 内の編集しているファイル
" ============================================================================

" function! s:dirty_accept(line, args) abort
"     let l:file = matchstr(a:line, '^ \s\zs.*')
"     " split やら tab やらに対応する
"     exec 'edit ' . FugitiveWorkTree() . '/' . l:file
" endfunction
"
"
" function! s:dirty_format_line(line, args) abort
"     return a:line[3:]
" endfunction
"
" let g:Lf_Extensions.dirty = {
" \   'source': {'command': 'git status --porcelain -uall'},
" \   'accept': s:func('s:dirty_format_line'),
" \   'support_multi': v:true,
" \}

" ============================================================================
" neosnippet
" ============================================================================
let s:neosnippet = {
\   'source': {},
\   'col': 0,
\   'ft': '',
\   'preview_bufnr': -1,
\}

function! s:neosnippet_source(...) abort
    let l:snippets = neosnippet#helpers#get_completion_snippets()
    let s:neosnippet.source = l:snippets
    return keys(l:snippets)
endfunction

function! s:neosnippet_accept(line, args) abort
    " from neosnippet.vim
    let l:cur_text = neosnippet#util#get_cur_text()
    let l:cur_keyword_str = matchstr(l:cur_text, '\S\+$')
    call neosnippet#view#_expand(
    \   l:cur_text . a:line[len(l:cur_keyword_str)], s:neosnippet.col, a:line)
endfunction

" TODO: 展開後の preview
" `` な部分を展開する
function! s:neosnippet_preview(orig_buf_nr, orig_cursor, line, arguments) abort
    let l:info = get(s:neosnippet.source, a:line, {})
    let l:lines = split(get(l:info, 'snip', ''), "\n")
    silent call deletebufline(s:neosnippet.preview_bufnr, 1, '$')
    silent call setbufline(s:neosnippet.preview_bufnr, 1, l:lines)
    " [buf_number, line_num, jump_cmd]
    return [s:neosnippet.preview_bufnr, 1, '']
endfunction

function! s:neosnippet_before_enter(args) abort
    " プレビューのところでやるとカーソル移動が遅くなるから
    let l:bufnr = bufadd('lf_neosnippet_preview') 
    silent! call bufload(l:bufnr)

    try
        " from instance.py
        call setbufvar(l:bufnr, '&buflisted',   0)
        call setbufvar(l:bufnr, '&buftype',     'nofile')
        call setbufvar(l:bufnr, '&bufhidden',   'hide')
        call setbufvar(l:bufnr, '&undolevels',  -1)
        call setbufvar(l:bufnr, '&swapfile',    0)
        call setbufvar(l:bufnr, '&filetype',    &filetype)
    catch /*/
        " pass
    endtry

    let s:neosnippet.col = col('.')
    let s:neosnippet.preview_bufnr = l:bufnr
endfunction

let g:Lf_Extensions.neosnippet = {
\   'source': s:func('s:neosnippet_source'),
\   'accept': s:func('s:neosnippet_accept'),
\   'preview': s:func('s:neosnippet_preview'),
\   'before_enter': s:func('s:neosnippet_before_enter'),
\}

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


function! s:favhelp_accept(line, args) abort
    exec 'help ' . split(a:line, ' ')[0]
endfunction


" function! s:favhelp_preview(orig_buf_nr, orig_cursor, line, arguments) abort
"     " どうやって表示しよう
" endfunction

let g:Lf_Extensions.favhelp = {
\   'source': s:space_between(s:fav_helps),
\   'accept': s:func('s:favhelp_accept'),
\   'highlights_def': {
\       'Lf_hl_favhelp_comment': '|\zs .*$'
\   },
\   'highlights_cmd': [
\       'hi link Lf_hl_favhelp_comment Comment'
\   ],
\}
" \   'preview': s:func('s:favhelp_preview'),
" \   'before_enter': s:func('s:favhelp_before_enter'),
