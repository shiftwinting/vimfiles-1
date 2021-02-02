-- https://github.com/kitagry/vs-snippets をみて

local g = vim.g

-- see https://github.com/tami5/nvim/blob/664e43360cc47e0db8ef9b497ea0dd9381bfa8cb/fnl/auto/completion.fnl
g.vsnip_snippet_dir = (vim.fn.stdpath 'config') .. '/snippets/vsnip'
g.vsnip_namespace = 'vsnip_'

vim.cmd([[imap <expr> <C-k> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>']])
vim.cmd([[smap <expr> <C-k> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>']])
