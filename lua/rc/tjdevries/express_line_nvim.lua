local ok, el = pcall(require, 'el')
if not ok then do return end end

local builtin = require('el.builtin')
local sections = require('el.sections')
local subscribe = require('el.subscribe')
local extensions = require('el.extensions')

local percent = function(win_id)
  return string.format('%3d', vim.fn.line('.') * 100 / vim.fn.line('$')) .. '%%'
end

el.setup {generator = function(win_id)
  return {
    extensions.mode,
    ' ',
    builtin.tail_file,
    ' ',
    builtin.modified_flag,
    builtin.readonly_flag,
    subscribe.buf_autocmd(
      "el_git_status",
      "BufWritePost",
      function(window, buffer)
        return extensions.git_changes(window, buffer)
      end
    ),
    ' ',
    subscribe.buf_autocmd(
      "el_git_branch",
      "BufEnter",
      function(window, buffer)
        return '' .. extensions.git_branch(window, buffer)
      end
    ),
    ' ',
    subscribe.buf_autocmd(
      "el_file_icon",
      "BufRead",
      function(_, buffer)
        return extensions.file_icon(_, buffer)
      end
    ),
    sections.left_subsection,
    sections.split,
    builtin.filetype,
    ' ',
    percent,
    ' ',
    '[', builtin.line, ':', builtin.column, ']',
  }
end}
