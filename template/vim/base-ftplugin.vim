scriptencoding utf-8

if exists('b:did_ftplugin_tmg')
    finish
endif

let b:did_ftplugin_tmg = 1

{{_cursor_}}



" ====================
" mappings
" ====================



" ====================
" options
" ====================



" ====================
" autocmds
" ====================
augroup My_ft_{{_expr_:&ft}}
    autocmd!
augroup END

