UsePlugin 'scrollbar.nvim'
scriptencoding utf-8

augroup my-scrollbar
    autocmd!
    autocmd BufEnter * silent! lua require('scrollbar').show()
    autocmd BufLeave * silent! lua require('scrollbar').clear()

    autocmd CursorMoved * silent! lua require('scrollbar').show()
    autocmd VimResized  * silent! lua require('scrollbar').show()
augroup END

let g:scrollbar_excluded_filetypes = ['lir', 'vista_kind', 'vista']

let g:scrollbar_shape = {
\   'head': '',
\   'tail': '',
\}

let g:scrollbar_highlight = {
\   'head': 'String',
\   'body': 'String',
\   'tail': 'String',
\}
