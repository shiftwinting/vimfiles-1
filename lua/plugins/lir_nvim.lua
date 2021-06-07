if vim.api.nvim_call_function('FindPlugin', { 'lir.nvim' }) == 0 then
  do
    return
  end
end

local a = vim.api

local lir = require('lir')
local mmv = require('lir.mmv.actions').mmv
local b = require('lir.bookmark.actions')
local m = require('lir.mark.actions')
local c = require('lir.clipboard.actions')

local actions = require('lir.actions')
local xactions = require('xlir.actions')

require('lir.git_status').setup({
  show_ignored = true,
})

local states = {
  -- last_buf_ft
}

local function feedkeys(key)
  a.nvim_feedkeys(a.nvim_replace_termcodes(key, true, false, true), 'n', true)
end

local function nop()
end

local explorer = function()
  local ctx = lir.get_context()
  vim.fn.system(string.format('xdg-open %s', ctx.dir))
end

-- local wipeout = function()
--   local ctx = lir.get_context()
--   local bufnr = vim.fn.bufnr(ctx:current_value())
--   if bufnr ~= -1 then
--     vim.api.nvim_buf_delete(bufnr, {force = true})
--   end
--   actions.delete()
-- end

require('lir').setup({
  show_hidden_files = false,
  devicons_enable = true,
  mappings = {
    ['u'] = nop,
    ['U'] = nop,
    ['o'] = nop,
    ['r'] = nop,
    ['p'] = nop,
    ['i'] = nop,
    ['I'] = nop,
    ['x'] = nop,
    ['S'] = nop,

    ['l'] = actions.edit,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,
    ['<C-g>'] = xactions.goto_git_root,
    ['h'] = actions.up,
    ['q'] = actions.quit,

    ['cd'] = function()
      feedkeys(':e ')
    end,
    ['K'] = xactions.newfile,
    ['R'] = xactions.rename,
    ['@'] = xactions.cd,

    ['<A-t>'] = xactions.open_deol,

    ['Y'] = actions.yank_path,
    ['.'] = actions.toggle_show_hidden,

    ['~'] = function()
      vim.cmd('edit ' .. vim.fn.expand('$HOME'))
    end,

    ['B'] = b.list,
    ['ba'] = b.add,

    ['J'] = function()
      m.toggle_mark()
      vim.cmd('normal! j')
    end,
    ['C'] = c.copy,
    ['X'] = c.cut,
    ['P'] = c.paste,
    ['D'] = xactions.gomi,
    -- python3 -m pip install --user --upgrade neovim-remote
    ['M'] = mmv,

    ['yy'] = require('plugins.telescope.lir_yank_path'),

    ['!'] = explorer,
  },
  float = {
    size_percentage = 0.5,
    winblend = 0,
    border = true,
    borderchars = { '+', '─', '+', '│', '+', '─', '+', '│' },

    shadow = false,
  },
  hide_cursor = true,
})

require('lir.bookmark').setup({
  bookmark_path = '~/.lir_bookmark',
  mappings = {
    ['l'] = b.edit,
    ['<C-s>'] = b.split,
    ['<C-v>'] = b.vsplit,
    ['<C-t>'] = b.tabedit,
    ['<C-e>'] = b.open_lir,
    ['B'] = b.open_lir,
    ['q'] = b.open_lir,
  },
})

_G.x_lir_init = function()
  local dir = nil
  local bufname = vim.fn.bufname()
  states.last_buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  if bufname:match('deol%-edit@') or bufname:match('term://') then
    dir = vim.fn.getcwd()
  end
  require('lir.float').toggle(dir)
end

_G.x_lir_init = function()
  local dir = nil
  local bufname = vim.fn.bufname()
  states.last_buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')

  if bufname:match('deol%-edit@') or bufname:match('term://') then
    dir = vim.fn.getcwd()
  end
  require('lir.float').toggle(dir)
end

vim.api.nvim_set_keymap(
  'n',
  '<C-e>',
  '<Cmd>lua _G.x_lir_init()<CR>',
  { silent = true, noremap = true }
)

vim.api.nvim_set_keymap(
  'n',
  '<C-e>',
  '<Cmd>lua _G.x_lir_init()<CR>',
  { silent = true, noremap = true }
)

function _G.LirSettings()
  a.nvim_buf_set_keymap(
    0,
    'x',
    'J',
    ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
    {
      noremap = true,
      silent = true,
    }
  )

  vim.api.nvim_echo({
    { vim.fn.expand('%:p:h:h') .. '/', 'Normal' },
    { vim.fn.expand('%:p:h:t'), 'Title' },
  }, false, {})
end

vim.cmd([[augroup lir-settings]])
vim.cmd([[  autocmd!]])
vim.cmd([[  autocmd Filetype lir :lua LirSettings()]])
vim.cmd([[augroup END]])
