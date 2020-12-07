if vim.api.nvim_call_function('FindPlugin', {'scrollbar.nvim'}) == 0 then do return end end

vim.g.scrollbar_shape = {
  head = ' ',
  body = ' ',
  tail = ' '
}

vim.cmd([[hi! Scrollbar guibg=#ebdbb2]])
vim.g.scrollbar_highlight = {
  head = 'MyScrollbarHi',
  body = 'MyScrollbarHi',
  tail = 'MyScrollbarHi',
}

vim.g.scrollbar_width = 1
vim.g.scrollbar_right_offset = 1


vim.cmd([[augroup my-scrollbar]])
vim.cmd([[  autocmd!]])
vim.cmd([[  autocmd CursorMoved,BufEnter,WinEnter,CursorHold  * silent! lua require'scrollbar'.show()]])
vim.cmd([[  autocmd BufLeave,WinLeave,QuitPre                 * silent! lua require'scrollbar'.clear()]])
vim.cmd([[augroup end]])
