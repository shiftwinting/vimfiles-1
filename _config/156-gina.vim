scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/gina.vim'))
    finish
endif

" :h gina-actions

" 参考
" https://github.com/kodai12/dotfiles/blob/c8e32e5a6e51a5fd4d10e84c8c798ad67c6cd9f4/nvim/plugins/gina.rc.vim
" https://github.com/ptn/dotfiles/blob/e38c9b67ae20ca6d472b885ed4e4636fe99a1d7e/vimrc#L452

" ====================
" action#alias
" ====================
" " /{pattern} で正規表現で書ける？
" call gina#custom#action#alias(
" \   '/*', 'redit',
" \   'edit:right'
" \

" ====================
" action#shorten
" ====================
" " gina-status で show: を省略できるようになる
" "    show:preview => preview
"  call gina#custom#action#shorten('status', 'show')w


" ====================
" option https://bit.ly/3aoRliN
" ====================
" XXX: --no-short にする場合
" call gina#custom#command#option('status', '--short', 1)




function! s:abspath() abort
    return gina#core#repo#abspath(gina#core#get_or_fail(), '')
endfunction

function! s:get_current_buffer_relpath() abort
    let curpath = substitute(expand('%:p'), '\', '/', 'g')
    let relpath = substitute(curpath, s:abspath(), '', '')
    return relpath
endfunction

nnoremap [gina] <Nop>
nmap <Space>g [gina]

nnoremap [gina]s :<C-u>Gina status<CR><C-w>T
nnoremap [gina]b :<C-u>Gina blame<CR>
" nnoremap [gina]p :<C-u><C-r>=printf('Gina patch %s', <SID>get_current_buffer_relpath())<CR><CR>

" ====================
" status
" ====================

let g:gina#command#status#use_default_mappings = 0

call gina#custom#action#alias('status', 'redit', 'edit:right')

call gina#custom#command#option('status', '--short')
call gina#custom#command#option('status', '--branch')
call gina#custom#command#option('status', '--opener', 'split')
call gina#custom#command#option('status', '--group', 'gina-status')

" set diffopt+=vertical をしておく
call gina#custom#mapping#nmap(
\   'status', 'pp',
\   ':call gina#action#call("patch:tab")<CR>',
\   {'noremap': 1, 'silent': 1}
\)

call gina#custom#mapping#nmap(
\   'status', '<CR>',
\   ':<C-u>call gina#action#call("edit:tab")<CR>',
\   {'noremap': 1, 'silent': 1}
\)

call gina#custom#mapping#nmap(
\   'status', 'o',
\   ':<C-u>call gina#action#call("edit:tab")<CR>',
\   {'noremap': 1, 'silent': 1}
\)

call gina#custom#mapping#nmap(
\   'status', '-',
\   ':<C-u>call gina#action#call("index:toggle")<CR>',
\   {'noremap': 1, 'silent': 1}
\)

call gina#custom#mapping#nmap(
\   'status', 'cc',
\   ':<C-u>Gina commit<CR>',
\   {'noremap': 1, 'silent': 1}
\)

call gina#custom#mapping#nmap(
\   'status', 'ca',
\   ':<C-u>Gina commit --amend<CR>',
\   {'noremap': 1, 'silent': 1}
\)

call gina#custom#mapping#nmap(
\   'status', '=',
\   ':<C-u>call Gina_close_not_status_viewr()<CR>:call gina#action#call("diff:vsplit")<CR><C-w><C-w>',
\   {'noremap': 1, 'silent': 1}
\)

call gina#custom#mapping#nmap(
\   'status', 'a',
\   ':<C-u>call gina#action#call("builtin:choice")<CR>',
\   {'noremap': 1, 'silent': 1}
\)

call gina#custom#mapping#nmap(
\   'status', 'x',
\   '<Plug>(gina-index-discard)',
\   {'noremap': 1, 'silent': 1}
\)

call gina#custom#mapping#nmap(
\   'status', 'R',
\   ':<C-u>Gina status<CR>',
\   {'noremap': 1, 'silent': 1}
\)


" status 以外を閉じる
function! Gina_close_not_status_viewr() abort
    let l:buflist = tabpagebuflist()
    for l:bufnr in l:buflist
        if bufname(l:bufnr) !~# ':status$'
            exec 'bd' l:bufnr
        endif
    endfor
endfunction

" ====================
" diff
" ====================
call gina#custom#command#option('diff', '--opener', 'vsplit')
call gina#custom#command#option('diff', '--group',  'gina-diff')

" ====================
" log
" ====================
call gina#custom#command#option('log',    '--group', 'gina-log')
call gina#custom#command#option('log',    '--graph')



" ====================
" commit
" ====================
call gina#custom#command#option('commit', '--opener', 'split')


" ====================
" blame
" ====================
let g:gina#command#blame#formatter#format = '%su%=on %ti by %au %ma%in'
let g:gina#command#blame#formatter#timestamp_format1 = '%Y-%m-%d'
let g:gina#command#blame#formatter#timestamp_format2 = '%Y-%m-%d'
let g:gina#command#blame#formatter#timestamp_months = 0

call gina#custom#mapping#nmap(
\   'blame', 'j',
\   'j<Plug>(gina-blame-echo)'
\)

call gina#custom#mapping#nmap(
\   'blame', 'k',
\   'k<Plug>(gina-blame-echo)'
\)

call gina#custom#mapping#nmap(
\   'blame', '<CR>',
\   ':call gina#action#call(''show:commit:tab'')<CR>',
\   {'noremap': 1, 'silent': 1}
\)


" ====================
" patch
" ====================

" 以下のような配置になる
" +--------+---------+----------+
" |        |         |          |
" |        |         |          |
" |  HEAD  |  INDEX  | WORKTREE |
" |        |         |          |
" |        |         |          |
" +--------+---------+----------+

" --------------
" HEAD/WORKTREE
" --------------
" INDEX に put 取得
call gina#custom#mapping#nmap(
\   'patch', 'dp',
\   '<Plug>(gina-diffput)',
\   {'noremap': 1, 'silent': 1}
\)

" --------------
" WORKTREE
" --------------
" INDEX から get 取得
call gina#custom#mapping#nmap(
\   'patch', 'dg',
\   '<Plug>(gina-diffget)',
\   {'noremap': 1, 'silent': 1}
\)

" --------------
" INDEX
" --------------
" HEAD から get
call gina#custom#mapping#nmap(
\   'patch', 'dh',
\   '<Plug>(gina-diffget-l)',
\   {'noremap': 1, 'silent': 1}
\)

" WORKTREE から get
call gina#custom#mapping#nmap(
\   'patch', 'dh',
\   '<Plug>(gina-diffget-r)',
\   {'noremap': 1, 'silent': 1}
\)
