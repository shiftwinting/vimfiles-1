if vim.api.nvim_call_function('FindPlugin', {'lir.nvim'}) == 0 then do return end end

local a = vim.api

local lir = require 'lir'
local float = require 'lir.float'
local utils = require 'lir.utils'
local uv = vim.loop


local actions = require'lir.actions'

local function esc_path(path)
  return vim.fn.shellescape(vim.fn.fnamemodify(path, ':p'), true)
end

local function rm(context)
  local path = context.dir .. context:current_value()
  a.nvim_feedkeys(':!gomi ' .. esc_path(path), 'n', true)
end

local function mv(context)
  local path = context.dir .. context:current_value()
  local cmd = string.format([[:!mv %s %s]], esc_path(path), context.dir)
  a.nvim_feedkeys(cmd, 'n', true)
end

-- local function newfile_new()
--   if vim.w.lir_is_float then
--     a.nvim_feedkeys(':close | :vnew ' .. lir.get_context().dir, 'n', true)
--   else
--     a.nvim_feedkeys(':vnew ' .. lir.get_context().dir, 'n', true)
--   end
-- end
--
local function cp(context)
  local path = context.dir .. context:current_value()
  local cmd = string.format([[:!cp %s %s]], esc_path(path), esc_path(context.dir))
  a.nvim_feedkeys(cmd, 'n', true)
end

local function yank_win_path(context)
  local path = vim.fn.expand(context.dir .. context:current_value())
  local winpath = [[\\wsl$\Ubuntu-18.04]] .. path:gsub('/', '\\')
  vim.fn.setreg(vim.v.register, winpath)
  print('Yank path: ' .. winpath)
end

local function newfile(context)
  local name = vim.fn.input('New file: ', '', 'file')
  if name == '' then
    return
  end

  if name == '.' or name == '..' or string.match(name, '[/\\]') then
    utils.error('Invalid file name: ' .. name)
    return
  end

  local function touch(path)
    local f = uv.fs_open(path, 'w', tonumber('644', 8))
    uv.fs_close(f)
  end
  touch(context.dir .. name)

  actions.reload()

  local lnum = lir.get_context():indexof(name)
  vim.cmd(tostring(lnum))
end


require 'lir'.setup {
  show_hidden_files = false,
  devicons_enable = true,
  mappings = {
    ['l']     = actions.edit,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,

    ['h']     = actions.up,
    ['q']     = actions.quit,

    ['K']     = actions.mkdir,
    ['N']     = newfile,
    ['R']     = actions.rename,
    ['C']     = cp,
    ['M']     = mv,
    ['@']     = actions.cd,
    ['Y']     = actions.yank_path,
    ['.']     = actions.toggle_show_hidden,
    ['D']     = rm,
    ['~']     = function() vim.cmd('edit ' .. vim.fn.expand('$HOME')) end,
    ['W']     = yank_win_path,
  },
  float = {
    size_percentage = 0.5,
    winblend = 2,
  }
}

nvim_apply_mappings({
  ['n<C-e>'] = { function()
    local dir = nil
    local bufname = vim.fn.bufname()
    if bufname:match('deol%-edit@') or bufname:match('term://') then
      dir = vim.fn.getcwd()
    end
    require'lir.float'.toggle(dir)
  end },
}, {silent = true; noremap = true})
