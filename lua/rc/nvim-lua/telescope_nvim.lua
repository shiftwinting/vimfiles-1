if vim.api.nvim_call_function('FindPlugin', {'telescope.nvim'}) == 0 then do return end end

local map_command = require'vimrc.utils'.map_command

local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
-- local pickers = require('telescope.pickers')
-- local finders = require('telescope.finders')
-- local previewers = require('telescope.previewers')
-- local conf = require('telescope.config').values

vim.env.BAT_THEME = 'gruvbox-light'

local my_actions = require('vimrc.telescope.actions')

-- https://github.com/nvim-lua/telescope.nvim/blob/d32d4a6e0f0c571941f1fd37759ca1ebbdd5f488/lua/telescope/init.lua
require'telescope'.setup{
  defaults = {
    borderchars = {'-', '|', '-', '|', '+', '+', '+', '+'},
    winblend = 10,

    sorting_strategy = "ascending",
    layout_strategy = "center",

    results_title = false,
    preview_title = false,
    width = 140,
    results_height = 30,

    mappings = {
      -- insert mode のマッピング
      i = {
        -- 閉じる
        ["<C-c>"] = actions.close,
        ["<C-q>"] = actions.close,

        -- カーソル移動
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        -- 開く
        ["<C-t>"] = actions.goto_file_selection_tabedit,
        ["<C-s>"] = actions.goto_file_selection_split,
        ["<C-v>"] = actions.goto_file_selection_vsplit,
        ["<CR>"]  = actions.goto_file_selection_edit,

        -- TODO:
      },

      -- normal mode のマッピング
      n = {
        -- カーソル移動
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,

        ["q"] = actions.close,

        -- 開く
        ["<C-t>"] = actions.goto_file_selection_tabedit,
        ["<C-s>"] = actions.goto_file_selection_split,
        ["<C-v>"] = actions.goto_file_selection_vsplit,
        ["<CR>"]  = actions.goto_file_selection_edit,
      },
    },
    color_devicons = true,
  }
}

local vimp = require('vimp')

-- <Space>fv 設定ファイルを検索
vimp.nnoremap({'override'}, '<Space>fv', function()
  require'telescope.builtin'.find_files{
    cwd = vim.g.vimfiles_path,
    file_ignore_patterns = { "_config/.*" }
  }
end)

-- <Space>f; 履歴検索
vimp.nnoremap({'override'}, '<Space>f;', function()
  require('telescope.builtin').command_history {}
end)

-- <A-x> コマンド検索
vimp.nnoremap({'override'}, '<A-x>', function()
  require('telescope.builtin').commands {
    sorter = sorters.get_fzy_sorter(),
  }
end)

-- <Space>fh ヘルプ検索
vimp.nnoremap({'override'}, '<Space>fh', function()
  require('telescope.builtin').help_tags {
    previewer = false,
    sorter = sorters.get_fzy_sorter(),
  }
end)

-- <Space>fj バッファ検索
vimp.nnoremap({'override'}, '<Space>fj', function()
  require('telescope.builtin').buffers {
    shorten_path = false,
    show_all_buffers = true,

    attach_mappings = function(_, map)
      map('i', '<CR>', my_actions.goto_file_selection_drop)
      map('n', '<CR>', my_actions.goto_file_selection_drop)

      return true
    end,
    }
end)

-- <Space>ff ファイル検索
vimp.nnoremap({'override'}, '<Space>ff', function()
  require'telescope.builtin'.git_files{}
end)


-- <Space>ft ファイルタイプ検索
vimp.nnoremap({'override'}, '<Space>ft', function()
  require'vimrc.telescope'.filetypes{}
end)

vimp.cmap({'override'}, '<C-l>', '<Plug>(TelescopeFuzzyCommandSearch)')


-- mru
vimp.nnoremap({'override'}, '<Space>fk', function()
  require('vimrc.telescope').mru{
    file_ignore_patterns = { "^/tmp" }
  }
end)

-- -- mrr
-- vimp.nnoremap({'override'}, '<Space>fp', function()
--   require('vimrc.telescope').mrr{
--   }
-- end)

-- ghq
vimp.nnoremap({'override'}, '<Space>fq', function()
  require('vimrc.telescope').ghq{
    sorter = sorters.get_fzy_sorter(),
  }
end)

-- reloader
vimp.nnoremap({'override'}, '<Space>fl', function()
  require'telescope.builtin'.reloader{
    sorter = sorters.get_fzy_sorter(),
  }
end)


-- -- grep
-- vimp.nnoremap({'override'}, '<Space>fg', function()
--   require('telescope.builtin').live_grep{}
-- end)


-- -- fd
-- vimp.nnoremap({'override'}, '<Space>fd', function()
--   require('vimrc.telescope').fd_dir{
--     sorter = sorters.get_fzy_sorter(),
--   }
-- end)






map_command('UsePlugInsertLine', function()
  require'vimrc.telescope'.plug_names{}
end)
