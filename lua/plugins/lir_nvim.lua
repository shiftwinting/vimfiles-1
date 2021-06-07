if vim.api.nvim_call_function('FindPlugin', {'lir.nvim'}) == 0 then do return end end

local a = vim.api
local Job = require'plenary.job'

local lir = require 'lir'
-- local float = require 'lir.float'
local utils = require 'lir.utils'
-- local uv = vim.loop
local Path = require 'plenary.path'
local config = require 'lir.config'

local mmv = require 'lir.mmv.actions'.mmv
local b_actions = require 'lir.bookmark.actions'
local mark_actions = require 'lir.mark.actions'
-- local mark_utils = require 'lir.mark.utils'
local clipboard_actions = require'lir.clipboard.actions'

local actions = require'lir.actions'


require'lir.git_status'.setup({
  show_ignored = true
})


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

-- local function yank_win_path(context)
--   local ctx = lir.get_context()
--   local path = vim.fn.expand(ctx.dir .. ctx:current_value())
--   local winpath = [[\\wsl$\Ubuntu-18.04]] .. path:gsub('/', '\\')
--   vim.fn.setreg(vim.v.register, winpath)
--   print('Yank path: ' .. winpath)
-- end

local no_confirm_patterns = {
  '^LICENSE$',
  '^Makefile$',
  '^Dockerfile$',
}

local need_confirm = function(filename)
  for _, pattern in ipairs(no_confirm_patterns) do
    if filename:match(pattern) then
      return false
    end
  end
  return true
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

  -- If I need to check, I will.
  if need_confirm(name) then
    -- '.' is not included or '/' is not included, then
    -- I may have entered it as a directory, I'll check.
    if not name:match('%.') and not name:match('/') then
      if vim.fn.confirm("Directory?", "&No\n&Yes", 1) == 2 then
        name = name .. '/'
      end
    end
  end

  local path = Path:new(lir.get_context().dir .. name)
  if string.match(name, '/$') then
    -- mkdir
    name = name:gsub('/$', '')
    path:mkdir({
      parents = true,
      mode = tonumber('700', 8),
      exists_ok = false
    })
  else
    -- touch
    path:touch({
      parents = true,
      mode = tonumber('644', 8),
    })
  end

  -- If the first character is '.' and show_hidden_files is false, set it to true
  if name:match([[^%.]]) and not config.values.show_hidden_files then
    config.values.show_hidden_files = true
  end

  actions.reload()

  -- Jump to a line in the parent directory of the file you created.
  local lnum = lir.get_context():indexof(name:match('^[^/]+'))
  if lnum then
    vim.cmd(tostring(lnum))
  end
end

local function cd()
  local ctx = lir.get_context()
  actions.cd()
  vim.fn['deol#cd'](ctx.dir)
end

local function gomi()
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

local function nop()
end

local function goto_git_root()
  local dir = require'lspconfig.util'.find_git_ancestor(vim.fn.getcwd())
  if dir == nil or dir == "" then
    return
  end
  vim.cmd ('e ' .. dir)
end

--- comamnd を実行する
---@param opts table
---@return any #err
---@return table #results
local command = function(opts)
  local results = {}
  local err = {}
  Job:new({
    command = opts.command,
    args = opts.args,
    cwd = opts.cwd or vim.fn.getcwd(),

    on_stdout = function(_, data)
      table.insert(results, data)
    end,

    on_stderr = function(_, data)
      table.insert(err, data)
    end,

  }):sync()

  if #err ~= 0 then
    return err, nil
  end
  return nil, results
end

---git root を返す
---@return string?
local get_git_root = function()
  local err, results = command({
    command = 'git',
    args = {'rev-parse', '--show-toplevel'}
  })
  if err then
    return nil
  end

  return results[1]
end

--- git ls-files の結果を返す
---@param cwd string
---@return table #結果のリスト
local git_ls_files = function(cwd)
  local err, results = command({
    command = 'git',
    args = {'ls-files'},
    cwd = cwd
  })
  if err then
    return {}
  end

  return results
end

local git_mv = function(cwd, from, to)
  local err, results = command({
    command = 'git',
    args = {'mv', from, to},
    cwd = cwd
  })
end

local function rename()
  local ctx = lir.get_context()
  local old = string.gsub(ctx:current_value(), '/$', '')
  local new = vim.fn.input('Rename: ', old)
  if new == '' or new == old then
    return
  end

  if new == '.' or new == '..' or string.match(new, '[/\\]') then
    utils.error('Invalid name: ' .. new)
    return
  end

  -- もし、追跡されていたら、git mv を使う
  local git_root = get_git_root()

  if git_root == nil or vim.startswith(git_root, 'fatal') then
    if not vim.loop.fs_rename(ctx.dir .. old, ctx.dir .. new) then
      utils.error('Rename failed')
    end

  else
    -- git root からの相対パス
    local rel_path = string.sub(ctx:current().fullpath, #git_root+2)

    local files = git_ls_files(git_root)

    if vim.tbl_contains(files, rel_path) then
      -- 管理対象に入っていたら、 git mv で移動
      git_mv(ctx.dir, old, new)
    else
      if not vim.loop.fs_rename(ctx.dir .. old, ctx.dir .. new) then
        utils.error('Rename failed')
      end
    end

  end

  actions.reload()

  -- ジャンプ
  local lnum = lir.get_context():indexof(new)
  if lnum then
    vim.cmd(tostring(lnum))
  end
end

-- local function edit_or_split()
--   if states.last_buf_ft == 'deoledit' or states.last_buf_ft == 'deol' then
--     actions.split()
--   else
--     actions.edit()
--   end
-- end

-- local git = {}
--
-- function git.add()
--
-- end

-- deol が表示されているか
local is_show_deol = function()
  if vim.fn.exists('t:deol') ~= 1 then
    return false
  end

  return not vim.tbl_isempty(vim.fn.win_findbuf(vim.t.deol.bufnr))
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

function _G.LirSettings()
  a.nvim_buf_set_keymap(0, 'x', 'J', ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>', {noremap = true, silent = true})
  -- a.nvim_buf_set_keymap(0, 'n', 'J', ':<C-u>call v:lua.LirToggleMark("n")<CR>', {noremap = true, silent = true})

  -- vim.cmd('normal! gg')

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
    -- ['s']     = nop,
    ['S']     = nop,

    ['l']     = actions.edit,
    -- ['l']     = edit_or_split,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,

    ['<C-g>'] = goto_git_root,

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
    ['R']     = rename,
    ['@']     = cd,

    ['<A-t>'] = function()
      local ctx = lir.get_context()
      actions.quit()

      if not is_show_deol() then
        -- もし、Deol がなければ開く
        vim.fn.DeolOpen()
      end

      -- これいる？
      -- vim.cmd(string.format([[silent execute (haslocaldir() ? 'lcd' : 'cd') '%s']], ctx.dir))
      vim.fn['deol#cd'](ctx.dir)
    end,

    ['Y']     = actions.yank_path,
    ['.']     = actions.toggle_show_hidden,
    ['~']     = function() vim.cmd('edit ' .. vim.fn.expand('$HOME')) end,

    -- ['W']     = yank_win_path,
    ['B']     = b_actions.list,
    ['ba']    = b_actions.add,

    ['J'] = function()
      mark_actions.toggle_mark()
      vim.cmd('normal! j')
    end,
    ['C'] = clipboard_actions.copy,
    ['X'] = clipboard_actions.cut,
    ['P'] = clipboard_actions.paste,
    ['D'] = gomi,
    -- python3 -m pip install --user --upgrade neovim-remote
    ['M'] = mmv,

    ['yy'] = require'plugins.telescope.lir_yank_path',

    ['!'] = explorer,
    -- ['dd'] = wipeout,

  },
  float = {
    size_percentage = 0.5,
    winblend = 0,
    border = true,
    -- borderchars = {"-" , "|" , "-" , "|" , "+" , "+" , "+" , "+"},
    borderchars = {'+', '─', '+', '│', '+', '─', '+', '│'},

    shadow = false
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
