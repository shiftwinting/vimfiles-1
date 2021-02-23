local actions = require 'telescope.actions'
local pickers = require 'telescope.pickers'
local sorters = require 'telescope.sorters'
local finders = require 'telescope.finders'
local entry_display = require 'telescope.pickers.entry_display'
local devicons = require'nvim-web-devicons'

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

  local displayer = entry_display.create {
    separator = " ",
    items = {
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
      {entry.devicons, entry.devicons_highlight},
      entry.file_name,
      {entry.dir_name, "Comment"}
      }
  end

  return function(entry)

    local dir_name = vim.fn.fnamemodify(entry, ':p:h')
    local file_name = vim.fn.fnamemodify(entry, ':p:t')

    local icons, highlight = devicons.get_icon(entry, string.match(entry, '%a+$'), { default = true })

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
    }
  end
end



-----------------------------
-- Export
-----------------------------
local list = function(opts)
  opts = opts or {}

  local results = vim.api.nvim_eval('mr#mru#list()[:3000]')

  pickers.new(opts, {
    prompt_title = 'MRU',
    finder = finders.new_table {
      results = results,
      entry_maker = opts.entry_maker or gen_from_mru_better({results = results}),
    },
    sorter = opts.sorter or sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.goto_file_selection_edit:replace(function()
        local entry = actions.get_selected_entry()
        actions.close(prompt_bufnr)

        print(entry.value)
      end)
      return true
    end
  }):find()
end



return require'telescope'.register_extension {
  exports = {
    list = list
  }
}

