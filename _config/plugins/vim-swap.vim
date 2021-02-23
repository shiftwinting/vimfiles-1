scriptencoding utf-8
UsePlugin 'vim-swap'

nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)
nmap gs <Plug>(swap-interactive)

" " なんか、警告が出る...
" omap i, <Plug>(swap-textobject-i)
" xmap i, <Plug>(swap-textobject-i)
" omap a, <Plug>(swap-textobject-a)
" xmap a, <Plug>(swap-textobject-a)
