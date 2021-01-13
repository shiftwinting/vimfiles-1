if vim.api.nvim_call_function('FindPlugin', {'vim-git-commit-prefix'}) == 0 then do return end end

vim.g.git_commit_prefix_lang = 'ja'
