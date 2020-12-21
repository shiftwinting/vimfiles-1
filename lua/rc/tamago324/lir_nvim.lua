if vim.api.nvim_call_function('FindPlugin', {'lir.nvim'}) == 0 then do return end end

local lvim = require 'lir.vim'

local actions = require'lir.actions'

local function esc_path(path)
  return vim.fn.shellescape(vim.fn.fnamemodify(path, ':p'), true)
end

local function rm()
  local path = lvim.b.context.dir .. lvim.b.context:current()
  vim.api.nvim_feedkeys(':!gomi ' .. esc_path(path), 'n', true)
end

local function mv()
  local path = lvim.b.context.dir .. lvim.b.context:current()
  local cmd = string.format([[:!mv %s %s]], esc_path(path), lvim.b.context.dir)
  vim.api.nvim_feedkeys(cmd, 'n', true)
end

local function newfile_new()
  if vim.w.lir_is_float then
    vim.api.nvim_feedkeys(':close | :vnew ' .. lvim.b.context.dir, 'n', true)
  else
    vim.api.nvim_feedkeys(':vnew ' .. lvim.b.context.dir, 'n', true)
  end
end

local function cp()
  local path = lvim.b.context.dir .. lvim.b.context:current()
  local cmd = string.format([[:!cp %s %s]], esc_path(path), esc_path(lvim.b.context.dir))
  vim.api.nvim_feedkeys(cmd, 'n', true)
end

local function yank_win_path()
  local path = vim.fn.expand(lvim.b.context.dir .. lvim.b.context:current())
  local winpath = [[\\wsl$\Ubuntu-18.04]] .. path:gsub('/', '\\')
  vim.fn.setreg(vim.v.register, winpath)
  print('Yank path: ' .. winpath)
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
    ['N']     = actions.newfile,
    ['S']     = newfile_new,
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
