
local a = vim.api

local tab_info = {
  --[[
    tabpagenr = {
      files = context.files,
      curpos = vim.fn.getcurpos()
    }
  ]]
}


local function mmv(context)
  local cwd = context.dir
  local files = {}
  for i, f in ipairs(context.files) do
    table.insert(files, f.value)
  end

  local save_editor  = vim.env.EDITOR
  vim.env.EDITOR = "nvr --remote-wait"

  local lir_win = a.nvim_get_current_win()
  vim.cmd('tabe')
  tab_info[a.nvim_tabpage_get_number(0)] = {
    files = context.files,
    curpos = a.nvim_win_get_cursor(lir_win)
  }

  local x = vim.fn.termopen(vim.tbl_flatten({'mmv', files}), {
    cwd = cwd,
    on_exit = function(job_id, data, event)
      for i, tab in ipairs(a.nvim_list_tabpages()) do
        for i, win in ipairs(a.nvim_tabpage_list_wins(tab)) do
          if win == lir_win then
            a.nvim_set_current_win(win)
            vim.cmd('edit!')
          end
        end
      end
    end
  })

  vim.env.EDITOR = save_editor
end


local function highlight(files)
  local ns = vim.api.nvim_create_namespace('lir_mmv_dir')
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
  for i, file in ipairs(files) do
    if file.is_dir then
      vim.api.nvim_buf_add_highlight(0, ns, 'PreProc', i - 1, 0, -1)
    end
  end
end

local function onBufWinEnter()
  -- 本来なら、 EDITOR='nvr --remote-wait +"set bufhidden=delete"' としたい
  vim.cmd('setlocal bufhidden=wipe')
  local info = tab_info[a.nvim_tabpage_get_number(0)]
  highlight(info.files)
  a.nvim_win_set_cursor(0, info.curpos)
end

local function setup_autocmd()
  vim.cmd([[augroup lir-mmv]])
  vim.cmd([[  autocmd!]])
  vim.cmd([[  autocmd BufWinEnter * if bufname(expand('<afile>')) =~# '^/tmp/mmv-' | call luaeval('require"vimrc.lir.mmv".onBufWinEnter()') | endif]])
  vim.cmd([[augroup END]])
end

setup_autocmd()

return {
  mmv = mmv,
  onBufWinEnter = onBufWinEnter,
}
