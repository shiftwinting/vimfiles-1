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




function! s:abs_path() abort
    return gina#core#repo#abspath(gina#core#get_or_fail(), '')
endfunction


" ====================
" status
" ====================
nnoremap <Space>gs :<C-u>Gina status<CR><C-w>T

let g:gina#command#status#use_default_mappings = 0

call gina#custom#action#alias('status', 'redit', 'edit:right')

call gina#custom#command#option('status', '--short')
call gina#custom#command#option('status', '--branch')
call gina#custom#command#option('status', '--opener', 'split')
call gina#custom#command#option('status', '--group', 'gina-status')

call gina#custom#mapping#nmap(
\   'status', 'P',
\   ':<C-u>call Gina_close_not_status_viewr()<CR>:call gina#action#call("edit:right")<CR>',
\   {'noremap': 1, 'silent': 1}
\)

call gina#custom#mapping#nmap(
\   'status', '<CR>',
\   ':<C-u>call gina#action#call("edit")<CR>',
\   {'noremap': 1, 'silent': 1}
\)

call gina#custom#mapping#nmap(
\   'status', 'o',
\   ':<C-u>call gina#action#call("edit")<CR>',
\   {'noremap': 1, 'silent': 1}
\)

call gina#custom#mapping#nmap(
\   'status', 's',
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
\   ':<C-u>call gina#action#call("index:discard")<CR>',
\   {'noremap': 1, 'silent': 1}
\)

call gina#custom#mapping#nmap(
\   'status', 'R',
\   ':<C-u>Gina status<CR>',
\   {'noremap': 1, 'silent': 1}
\)
"
" " diff プレビューを閉じる
" " patch の時使う
" function! Gina_close_diff_preview() abort
"     let l:buflist = tabpagebuflist()
"     for l:bufnr in l:buflist
"         if bufname(l:bufnr) =~# '\$$'
"             exec 'bd' l:bufnr
"         endif
"     endfor
" endfunction

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



" ====================
" commit
" ====================
call gina#custom#command#option('commit', '--opener', 'split')
