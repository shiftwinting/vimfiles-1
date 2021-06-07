local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')


local results = {
  { 'feat', '新機能', },
  { 'fix', 'バグ修正', },
  { 'docs', 'ドキュメントのみの変更', },
  { 'style', 'コードの動作に影響しない変更（スペース・フォーマット・セミコロン等）', },
  { 'refactor', 'リファクタリング（機能追加やバグ修正を含まない変更）', },
  { 'perf', 'パフォーマンス改善のための変更', },
  { 'test', '不足テストの追加や既存テストの修正', },
  { 'chore', 'その他、補助ツール・ドキュメント生成など、ソースやテストの変更を含まない変更' },
}

return function()

  pickers.new({}, {
    prompt_title = 'prefix',
    finder = finders.new_table {
      results = results,
      entry_maker = function(entry)
        return {
          value = entry[1],
          display = entry[1] .. ' ' .. entry[2],
          ordinal = entry[1],
        }
      end
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local entry = actions.get_selected_entry()
        actions.close(prompt_bufnr)

        local text = entry.value .. ': '
        vim.api.nvim_buf_set_lines(0, 0, 1, false, {text})
        vim.cmd [[ startinsert! ]]
      end)

      return true
    end,
  }):find()
end
