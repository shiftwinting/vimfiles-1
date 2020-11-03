scriptencoding utf-8
UsePlugin 'deoppet.nvim'

call deoppet#initialize()
call deoppet#custom#option('snippets_dirs', globpath(&runtimepath, 'neosnippets', 1, 1) + [expand('$MYVIMFILES/snippets')])

imap <C-k> <Plug>(deoppet_expand)
imap <C-f> <Plug>(deoppet_jump_forward)
