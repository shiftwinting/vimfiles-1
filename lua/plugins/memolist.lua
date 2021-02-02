-- なければ作る
if vim.fn.isdirectory(os.getenv('HOME') .. '/memo') ~= 1 then
  vim.fn.mkdir(os.getenv('HOME') .. '/memo')
end

vim.g.memolist_path = '~/memo'

vim.cmd [[nnoremap <Space>mn <Cmd>MemoNew<CR>]]

