local M = {}

local util = vim.lsp.util
local if_nil = vim.F.if_nil
local api = vim.api
local diagnostis = require'vim.lsp.diagnostic'

local protocol = require'vim.lsp.protocol'
local DiagnosticSeverity = protocol.DiagnosticSeverity


local qflist_type_map = {
  [DiagnosticSeverity.Error] = 'E',
  [DiagnosticSeverity.Warning] = 'W',
  [DiagnosticSeverity.Information] = 'I',
  [DiagnosticSeverity.Hint] = 'I',
}

function M.open_qflist(opts)
  opts = opts or {}

  local open_qflist = if_nil(opts.open_qflist, true)

  local bufnr = vim.api.nvim_get_current_buf()
  local buffer_diags = diagnostis.get(bufnr, opts.client_id)

  -- if opts.severity then
  --   buffer_diags = filter_to_severity_limit(opts.severity, buffer_diags)
  -- elseif opts.severity_limit then
  --   buffer_diags = filter_by_severity_limit(opts.severity_limit, buffer_diags)
  -- end

  local items = {}
  local insert_diag = function(diag)
    local pos = diag.range.start
    local row = pos.line
    local col = util.character_offset(bufnr, row, pos.character)

    local line = (api.nvim_buf_get_lines(bufnr, row, row + 1, false) or {""})[1]

    table.insert(items, {
      bufnr = bufnr,
      lnum = row + 1,
      col = col + 1,
      text = line .. " | " .. diag.message,
      type = qflist_type_map[diag.severity or DiagnosticSeverity.Error] or 'E',
    })
  end

  for _, diag in ipairs(buffer_diags) do
    insert_diag(diag)
  end

  table.sort(items, function(a, b) return a.lnum < b.lnum end)

  util.set_qflist(items)
  if open_qflist then
    vim.cmd [[copen]]
  end
end

return M
