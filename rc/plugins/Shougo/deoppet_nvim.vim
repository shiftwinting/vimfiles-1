scriptencoding utf-8
UsePlugin 'deoppet.nvim'

call deoppet#initialize()
call deoppet#custom#option('snippets', map(globpath(&runtimepath, 'neosnippets', 1, 1) + [expand('$MYVIMFILES/snippets')], "{ 'path': v:val }"))

imap <expr><C-k> deoppet#expandable()? '<Plug>(deoppet_expand)' : '<Plug>(deoppet_jump_forward)'
smap <expr><C-k> deoppet#expandable()? '<Plug>(deoppet_expand)' : '<Plug>(deoppet_jump_forward)'
