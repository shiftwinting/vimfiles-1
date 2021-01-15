if vim.api.nvim_call_function('FindPlugin', {'ido.nvim'}) == 0 then do return end end

do return end

ido_decorations['separator']   = '\n    '
ido_decorations['matchstart']  = '\n'
ido_decorations['marker']      = ' -> '
ido_decorations['moreitems']   = ''
ido_limit_lines                = false

ido_keybindings = {
  ["\\<Escape>"]  = 'ido_close_window',
  ["\\<C-c>"]  = 'ido_close_window',
  ["\\<Return>"]  = 'ido_accept',

  ["\\<Left>"]    = 'ido_cursor_move_left',
  ["\\<Right>"]   = 'ido_cursor_move_right',
  ["\\<C-b>"]     = 'ido_cursor_move_left',
  ["\\<C-f>"]     = 'ido_cursor_move_right',

  ["\\<BS>"]      = 'ido_key_backspace',
  ["\\<C-h>"]     = 'ido_key_backspace',
  ["\\<C-d>"]     = 'ido_key_delete',

  ["\\<C-a>"]     = 'ido_cursor_move_begin',
  ["\\<C-e>"]     = 'ido_cursor_move_end',

  ["\\<Tab>"]     = 'ido_complete_prefix',
  ["\\<C-j>"]     = 'ido_next_item',
  ["\\<C-k>"]     = 'ido_prev_item'
}

-- ido_keybindings を変更したら呼ぶ必要がある
ido_load_keys()


-- nvim_apply_mappings({
--   ['n<Space>ft'] = {function()
--     ido_complete({
--       items = vim.fn.getcompletion('', 'filetype'),
--       on_enter = function(selection)
--         vim.cmd('setfiletype ' .. selection)
--       end
--     })
--   end}
-- }, {silent = false; noremap = true})
