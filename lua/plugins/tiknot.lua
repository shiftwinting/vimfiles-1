if vim.api.nvim_call_function('FindPlugin', {'tiknot.nvim'}) == 0 then do return end end


require'tiknot'.setup {
  hide_on_winleave = true,

  on_open = function(state)
    vim.api.nvim_buf_set_keymap(
      state.buf,
      'n', 'si', '<Cmd>lua require"tiknot".hide()<CR>',
      { noremap = true, silent = true }
    )
  end

}

vim.api.nvim_set_keymap(
  'n', 'si', '<Cmd>lua require"tiknot".open()<CR>',
  { noremap = true, silent = true }
)
