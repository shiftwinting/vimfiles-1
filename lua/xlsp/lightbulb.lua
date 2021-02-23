local M = {}

local timer = nil
local lightbulb = require'nvim-lightbulb'
local LIGHTBULB_VIRTUAL_TEXT_NS = vim.api.nvim_create_namespace("nvim-lightbulb")

local update_lightbulb = function()
  lightbulb.update_lightbulb {
    sign = { enabled = false },
    virtual_text = { enabled = true, text = "  󿯦" }
  }
end

-- クリアする
local clear_lightbulb = function()
  vim.api.nvim_buf_clear_namespace(0, LIGHTBULB_VIRTUAL_TEXT_NS, 0, -1)
end

M.on_timer = function()
  clear_lightbulb()
  if timer then
    timer:stop()
    timer:close()
  end

  -- 500ミリ秒カーソルが動かなかったら、表示したい
  timer = vim.loop.new_timer()
  local delay = 500
  local rep = 0
  timer:start(delay, rep, vim.schedule_wrap(function()
    update_lightbulb()
    timer:stop()
    timer:close()
    timer = nil
  end))
end

M.on_attach = function(bufnr)
  vim.cmd [[augroup my-lightbulb]]
  vim.cmd [[  autocmd!]]
  vim.cmd [[  autocmd CursorMoved,CursorMovedI <buffer> lua require'xlsp.lightbulb'.on_timer()]]
  vim.cmd [[augroup END]]
end

return M
