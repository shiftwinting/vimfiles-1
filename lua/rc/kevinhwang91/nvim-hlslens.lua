if vim.api.nvim_call_function('FindPlugin', {'nvim-hlslens'}) == 0 then do return end end

local api = vim.api

local mappings = {
  [' *'] = {[[<Plug>(asterisk-gz*)<Cmd>lua require'hlslens'.start()<CR>]]},
  [' g*'] = {[[<Plug>(asterisk-z*)<Cmd>lua require'hlslens'.start()<CR>]]},
}

nvim_apply_mappings(mappings, {silent = true})

-- カレント行飲みに表示させる
local line_lens = function(lnum, loc, idx, r_idx, count, hls_ns)
  local text, chunks
  -- loc が c なら、current
  -- current 以外は表示しない
  if loc ~= 'c' then
    text = ''
    chunks = {{'', 'Ignore'}}
  else
    text = string.format('[%d/%d]', idx, count)
    chunks = {{'', 'Ignore'}, {text, 'HlSearchLensCur'}}
  end
  api.nvim_buf_clear_namespace(0, -1, lnum - 1, lnum)
  api.nvim_buf_set_extmark(0, hls_ns, lnum - 1, 0, {virt_text = chunks})
end

require'hlslens'.setup({
  override_line_lens = line_lens
})
