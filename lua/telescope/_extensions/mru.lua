local actions = require 'telescope.actions'
local actions_set = require 'telescope.actions.set'
local actions_state = require 'telescope.actions.state'
local pickers = require 'telescope.pickers'
local sorters = require 'telescope.sorters'
local finders = require 'telescope.finders'
local entry_display = require 'telescope.pickers.entry_display'
local devicons = require'nvim-web-devicons'

local nearest_ancestor = require'xpath'.nearest_ancestor

-----------------------------
-- Private
-----------------------------
local gen_from_mru_better = function(opts)
  opts = opts or {}
  local default_icons, _ = devicons.get_icon('file', '', {default = true})
  local cwd = vim.fn.expand(opts.cwd or vim.fn.getcwd())

  local max_filename = math.max(
    unpack(
      vim.tbl_map(function(filepath)
        return vim.fn.strdisplaywidth(vim.fn.fnamemodify(filepath, ':p:t'))
      end, opts.results)
    )
  )

  local root_dir
  do
    local dir = vim.fn.expand('%:p')
    if dir == '' then
      dir = vim.fn.getcwd()
    end
    root_dir = nearest_ancestor({'.git/'}, dir)
  end

  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = 1 },
      { width = vim.fn.strwidth(default_icons) },
      -- { width = max_filename },
      { width = 35 },
      { remaining = true },
    },
  }

  -- local cwd = vim.fn.expand(opts.cwd or vim.fn.getcwd())

  -- リストの場合、ハイライトする
  local make_display = function(entry)
    return displayer {
      entry.mark_in_same_project,
      {entry.devicons, entry.devicons_highlight},
      entry.file_name,
      {entry.dir_name, "Comment"}
      }
  end

  return function(entry)

    local dir_name = vim.fn.fnamemodify(entry, ':p:h')
    local file_name = vim.fn.fnamemodify(entry, ':p:t')

    local icons, highlight = devicons.get_icon(entry, string.match(entry, '%a+$'), { default = true })

    -- プロジェクト内のファイルなら、印をつける
    -- 現在のバッファのプロジェクトを見つける
    local mark_in_same_project = ' '
    if root_dir ~= '' and entry:match('^'..root_dir) then
      mark_in_same_project = '*'
    end

    return {
      valid = true,
      cwd = cwd,

      filename = entry,
      value = entry,
      -- バッファ番号、ファイル名のみ、検索できるようにする
      ordinal = file_name,
      display = make_display,

      bufnr = entry.bufnr,

      devicons = icons,
      devicons_highlight = highlight,

      file_name = file_name,
      dir_name = dir_name,

      mark_in_same_project = mark_in_same_project,
    }
  end
end



-----------------------------
-- Export
-----------------------------
local list = function(opts)
  opts = opts or {}

  local results = vim.api.nvim_eval('mr#mru#list()[:3000]')
  results = vim.tbl_filter(function(x)
    -- カレントバッファは除く
    return x ~= vim.fn.expand('%:p')
  end, results)

  pickers.new(opts, {
    prompt_title = 'MRU',
    finder = finders.new_table {
      results = results,
      entry_maker = opts.entry_maker or gen_from_mru_better({results = results}),
    },
    sorter = opts.sorter or sorters.get_generic_fuzzy_sorter(),
    -- attach_mappings = function(prompt_bufnr)
    --   actions.select_default:replace(function()
    --     local entry = actions_state.get_selected_entry()
    --     actions.close(prompt_bufnr)
    --
    --     print(entry.value)
    --   end)
    --   return true
    -- end
  }):find()
end



return require'telescope'.register_extension {
  exports = {
    list = list
  }
}

