if vim.api.nvim_call_function('FindPlugin', {'lir.nvim'}) == 0 then do return end end

local a = vim.api

local lir = require 'lir'
local float = require 'lir.float'
local utils = require 'lir.utils'
local uv = vim.loop
local Path = require 'plenary.path'

-- local mmv = require 'lir.mmv.actions'.mmv
local b_actions = require 'lir.bookmark.actions'
local mark_actions = require 'lir.mark.actions'
local mark_utils = require 'lir.mark.utils'
local clipboard_actions = require'lir.clipboard.actions'

local actions = require'lir.actions'

local states = {
  -- last_buf_ft
}

local function esc_path(path)
  return vim.fn.shellescape(vim.fn.fnamemodify(path, ':p'), true)
end

local lcd = function(path)
  vim.cmd(string.format([[silent execute (haslocaldir() ? 'lcd' : 'cd') '%s']], path))
end

local function feedkeys(key)
  a.nvim_feedkeys(a.nvim_replace_termcodes(key, true, false, true), 'n', true)
end
--
-- local function cp(context)
--   local path = context.dir .. context:current_value()
--   local cmd = string.format([[:!cp %s %s]], esc_path(path), esc_path(context.dir))
--   a.nvim_feedkeys(cmd, 'n', true)
-- end

local function yank_win_path(context)
  local ctx = lir.get_context()
  local path = vim.fn.expand(ctx.dir .. ctx:current_value())
  local winpath = [[\\wsl$\Ubuntu-18.04]] .. path:gsub('/', '\\')
  vim.fn.setreg(vim.v.register, winpath)
  print('Yank path: ' .. winpath)
end

local function newfile()
  local save_curdir = vim.fn.getcwd()
  lcd(lir.get_context().dir)
  local name = vim.fn.input('New file: ', '', 'file')
  lcd(save_curdir)

  if name == '' then
    return
  end

  if name == '.' or name == '..' then
    utils.error('Invalid file name: ' .. name)
    return
  end

  -- . が入っていない or / が入っていないなら
  -- ディレクトリとして入力したかもしれないから、確認する
  if not name:match('%.') and not name:match('/') then
    if vim.fn.confirm("Directory?", "&Yes\n&No", 2) == 1 then
      -- ディレクトリ
      name = name .. '/'
    end
  end

  local path = Path:new(lir.get_context().dir .. name)
  if string.match(name, '/$') then
    -- mkdir()
    name = name:gsub('/$', '')
    path:mkdir({
      parents = true,
      mode = tonumber('700', 8),
      exists_ok = false
    })
  else
    -- touch()
    path:touch({
      parents = true,
      mode = tonumber('644', 8),
    })
  end

  actions.reload()

  -- このディレクトリ配下にあう名前を取得する
  local lnum = lir.get_context():indexof(name:match('^[^/]+'))
  if lnum then
    vim.cmd(tostring(lnum))
  end
end

function cd()
  local ctx = lir.get_context()
  actions.cd()
  vim.fn['deol#cd'](ctx.dir)
end

function rm()
  local ctx = lir.get_context()
  -- 選択されているものを取得する
  local marked_items = ctx:get_marked_items()
  if #marked_items == 0 then
    utils.error('Please mark one or more.')
    -- -- 選択されていなければ、カレント行を削除
    -- local path = ctx.dir .. ctx:current_value()
    -- vim.fn.system('gomi ' .. esc_path(path))
    -- actions.reload()
    return
  end

  local path_list = vim.tbl_map(function(items)
    return esc_path(items.fullpath)
  end, marked_items)
  -- for _, f in ipairs(marked_items) do
  --     -- TODO:
  --     -- 確認する
  --     -- "これ以降、同じ" みたいなこともしたい
  -- end
  if vim.fn.confirm("Delete files?", "&Yes\n&No", 2) ~= 1 then
    return
  end
  vim.fn.system('gomi ' .. vim.fn.join(path_list))
  actions.reload()
end

function nop()
end

function edit_or_split()
  if states.last_buf_ft == 'deoledit' or states.last_buf_ft == 'deol' then
    actions.split()
  else
    actions.edit()
  end
end

function _G.LirSettings()
  a.nvim_buf_set_keymap(0, 'x', 'J', ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>', {noremap = true, silent = true})
  -- a.nvim_buf_set_keymap(0, 'n', 'J', ':<C-u>call v:lua.LirToggleMark("n")<CR>', {noremap = true, silent = true})
  vim.api.nvim_echo({{vim.fn.expand('%:p:h:h') .. '/', 'Normal'}, {vim.fn.expand('%:p:h:t'), 'Title'}}, false, {})

  -- vim.cmd [[augroup LirCloseOnWinLeave]]
  -- vim.cmd [[  autocmd!]]
  -- vim.cmd [[  autocmd WinLeave <buffer>  if get(w:, 'lir_is_float', v:false) | call nvim_win_close(0, v:true) | endif]]
  -- vim.cmd [[augroup END]]
end

vim.cmd [[augroup lir-settings]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd Filetype lir :lua LirSettings()]]
vim.cmd [[augroup END]]

require 'lir'.setup {
  show_hidden_files = false,
  devicons_enable = true,
  mappings = {
    ['u']     = nop,
    ['U']     = nop,
    ['o']     = nop,
    ['r']     = nop,
    ['p']     = nop,
    ['i']     = nop,
    ['I']     = nop,
    ['x']     = nop,
    ['s']     = nop,
    ['S']     = nop,

    ['l']     = actions.edit,
    -- ['l']     = edit_or_split,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,

    -- ['l'] = function()
    --   local ctx = lir.get_context()
    --   local current = ctx:current()
    --   if string.match(current.value, '[^.]+$') == 'mp4' then
    --     vim.fn.system('xdg-open ' .. current.fullpath)
    --     return
    --   end
    --   actions.edit()
    -- end,

    ['h']     = actions.up,
    ['q']     = actions.quit,

    ['cd']    = function()
      feedkeys(':e ')
    end,
    ['K']     = newfile,
    ['R']     = actions.rename,
    ['@']     = cd,
    ['Y']     = actions.yank_path,
    ['.']     = actions.toggle_show_hidden,
    ['~']     = function() vim.cmd('edit ' .. vim.fn.expand('$HOME')) end,
    ['W']     = yank_win_path,
    ['B']     = b_actions.list,
    ['ba']    = b_actions.add,

    ['J'] = function()
      mark_actions.toggle_mark()
      vim.cmd('normal! j')
    end,
    ['C'] = clipboard_actions.copy,
    ['X'] = clipboard_actions.cut,
    ['P'] = clipboard_actions.paste,
    ['D'] = rm,
  },
  float = {
    size_percentage = 0.5,
    winblend = 0,
    border = true,
    -- borderchars = {"-" , "|" , "-" , "|" , "+" , "+" , "+" , "+"},
    borderchars = {'+', '-', '+', '|', '+', '-', '+', '|'},
    shadow = true
  },
  hide_cursor = true
}

require'lir.bookmark'.setup {
  bookmark_path = '~/.lir_bookmark',
  mappings = {
    ['l']     = b_actions.edit,
    ['<C-s>'] = b_actions.split,
    ['<C-v>'] = b_actions.vsplit,
    ['<C-t>'] = b_actions.tabedit,
    ['<C-e>'] = b_actions.open_lir,
    ['B']     = b_actions.open_lir,
    ['q']     = b_actions.open_lir,
  }
}

_G.x_lir_init =  function()
  local dir = nil
  local bufname = vim.fn.bufname()
  states.last_buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  if bufname:match('deol%-edit@') or bufname:match('term://') then
    dir = vim.fn.getcwd()
  end
  require'lir.float'.toggle(dir)
end
vim.api.nvim_set_keymap('n', '<C-e>', '<Cmd>lua _G.x_lir_init()<CR>', {silent = true; noremap = true})
