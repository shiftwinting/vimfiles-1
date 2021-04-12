if vim.api.nvim_call_function('FindPlugin', {'ido'}) == 0 then do return end end

local ido = require'ido'
local config = require'ido.config'

config.set {
  prompt = '>>> ',
  keys = {
    ['<C-f>'] = 'ido.cursor.forward',
    ['<C-b>'] = 'ido.cursor.backward',
    ['<C-a>'] = 'ido.cursor.line_start',
    ['<C-e>'] = 'ido.cursor.line_end',

    ['<C-j>'] = 'ido.result.next',
    ['<C-k>'] = 'ido.result.prev',

    ['<C-d>'] = 'ido.delete.forward',
    ['<BS>'] = 'ido.delete.backward',
    ['<C-h>'] = 'ido.delete.backward',
    ['<C-u>'] = 'ido.delete.line_start',

    ['<Tab>'] = 'ido.accept.suggestion',
    ['<CR>'] = 'ido.accept.selected',
    ['<Esc>'] = 'ido.event.exit',
  },
  -- renderer = 'xido/vertical_mode'
}

local M = {}


local map = function(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(mode, lhs, rhs, vim.tbl_extend('keep', opts or {}, { silent = true, noremap = true }))
end

M.filetypes = function()
  vim.bo.filetype = ido.start{
    items = vim.fn.getcompletion('', 'filetype')
  }
end

M.sonictemplate = function()
  local input = ido.start {
    items = vim.fn['sonictemplate#complete']('', '', ''),
  }
  if input == nil or #input == 0 then
    return
  end
  vim.cmd('Template ' .. input)
end

M.deol_commands = function()
  local commands = {
    ['new branch'] = 'git switch -c '
  }
  local input = ido.start {
    items = vim.tbl_keys(commands)
  }
  if input == nil or #input == 0 then
    return
  end

  vim.fn.setline(vim.fn.line('.'), commands[input])
  vim.cmd 'startinsert!'
end

map('n', '<Space>ft', '<Cmd>lua require"plugins/ido_nvim".filetypes()<CR>')
map('n', '<Space>;t', '<Cmd>lua require"plugins/ido_nvim".sonictemplate()<CR>')
map('n', '<Space><Space>', '<Cmd>lua require"plugins/ido_nvim".deol_commands()<CR>')

return M
