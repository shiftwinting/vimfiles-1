-- @file ~/.config/nvim/lua/xido/vertical_mode.lua

local main = require'ido.main'

local vertical = {}

--- バッファの設定を行う?
vertical.init = function()
  -- 高さは 10
  vim.cmd 'botright 10new'

  vim.b.buftype = 'nofile'
  vim.wo.relativenumber = false
  vim.wo.number = false
  vim.wo.wrap = false

  -- XXX: なぜ、true を返しているのかは不明
  return true
end

vertical.main = function()
  local variables = main.sandbox.variables
  local options = main.sandbox.options

  vim.api.nvim_buf_set_lines(0, 0, -1, false, {})

  -- 入力フィールドをレンダリングする
  vim.fn.setline(1,
    options.prompt ..   -- プロンプトの文字列
    variables.before .. -- カーソルの前のクエリ文字
    "_" ..              -- カーソル
    variables.after ..  -- カーソルの後ろのクエリ文字
    "[" .. variables.suggestion .. "]" -- 候補?
  )

  -- print(vim.inspect(variables.results))

  -- 結果をレンダリングする
  local results_limit = #variables.results

  -- 結果があったら描画する
  if results_limit > 1 then
    -- 選択している候補の次の候補を初期インデックスとする
    local index = variables.selected + 1

    -- もし、１つ目を選択していた場合、 ' -> red' という文字列が挿入される
    -- { { 'red', 0 }, { 'blue', 0 } }
    --     ^^^^^
    vim.fn.append(1, ' -> ' .. variables.results[variables.selected][1])

    -- 残りのアイテムを描画する
    for i = 1, results_limit do
      -- 末尾に行ったら、先頭に戻す
      if index > results_limit then
        index = 1
      end

      if index == variables.selected then
        -- １周したら終わり
        goto redraw
      end

      -- 今回は、 init() で 10new としているため、それ以降はレンダリングしない
      if i > 10 then
        goto redraw
      end

      vim.fn.append(vim.fn.line('$'), '    ' .. variables.results[index][1])

      index = index + 1
    end

  end

  ::redraw::

  vim.cmd 'redraw'

  return true
end

vertical.exit = function()
  vim.cmd 'bdelete!'

  return true
end

return vertical
