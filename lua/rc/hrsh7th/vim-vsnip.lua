if vim.api.nvim_call_function('FindPlugin', {'vim-vsnip'}) == 0 then do return end end

local g = vim.g

-- see https://github.com/tami5/nvim/blob/664e43360cc47e0db8ef9b497ea0dd9381bfa8cb/fnl/auto/completion.fnl
g.vsnip_snippet_dir = (vim.fn.stdpath 'config') .. '/snippets/vsnip'
g.vsnip_namespace = 'vsnip_'
