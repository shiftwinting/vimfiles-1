if vim.api.nvim_call_function('FindPlugin', {'telescope.nvim'}) == 0 then do return end end

local actions = require('telescope.actions')
local action_set = require'telescope.actions.set'
local action_state = require'telescope.actions.state'
local sorters = require('telescope.sorters')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local previewers = require('telescope.previewers')
local conf = require('telescope.config').values
local transform_mod = require('telescope.actions.mt').transform_mod
-- local make_entry = require('telescope.make_entry')
local entry_display = require('telescope.pickers.entry_display')
local devicons = require'nvim-web-devicons'

-- local parsers = require('nvim-treesitter.parsers')

local Path = require'plenary.path'
local a = vim.api

local find_git_ancestor = require'lspconfig.util'.find_git_ancestor
local get_default = require'telescope.utils'.get_default
local utils = require'telescope.utils'

-- local my_entry_maker = require('vimrc.telescope.make_entry')


-- https://github.com/nvim-lua/telescope.nvim/blob/d32d4a6e0f0c571941f1fd37759ca1ebbdd5f488/lua/telescope/init.lua
require'telescope'.setup{
  defaults = {
    -- borderchars = {'-', '|', '-', '|', '+', '+', '+', '+'},
    borderchars = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
    winblend = 0,
    -- prompt_position = "bottom",
    prompt_position = "top",
    sorting_strategy = "ascending",

    -- https://github.com/nvim-telescope/telescope.nvim/issues/425
    -- layout_strategy = 'horizontal',
    layout_strategy = 'bottom_pane',
    layout_defaults = {
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.6,
      },
      horizontal = {
        -- width_padding =  -- "How many cells to pad the width",
        height_padding = 10, -- "How many cells to pad the height",
        preview_width = 0.6 -- "(Resolvable): Determine preview width",
      },
      bottom_pane = {
        -- height = 20,
        height = 30,
      }
    },

    results_title = false,
    preview_title = false,
    -- width = 0.8,
    -- results_height = 30,

    mappings = {
      -- insert mode のマッピング
      i = {
        -- 閉じる
        ["<C-c>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<Esc>"] = actions.close,

        -- switch normal mode
        ["<Tab>"] = function(_, _)
          local key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
          vim.api.nvim_feedkeys(key, 'n', true)
        end,

        -- カーソル移動
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        -- 開く
        ["<C-t>"] = actions.select_tab,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<CR>"]  = actions.select_default,

        -- ["<C-x>"]  = require("trouble.providers.telescope").open_with_trouble,

        ["<C-l>"]  = actions.toggle_selection + actions.move_selection_next,

        -- TODO:
      },

      -- normal mode のマッピング
      n = {
        -- カーソル移動
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,

        ["q"] = actions.close,
        ["<Esc>"] = actions.close,

        -- 開く
        ["<C-t>"] = actions.select_tab,
        ["<C-s>"] = actions.select_horizontal, ["<C-v>"] = actions.select_vertical,
        ["<CR>"]  = actions.select_default,

        -- switch insert mode
        ["<Tab>"] = function(_, _)
          vim.api.nvim_feedkeys('i', 'n', true)
        end,

        ["<C-x>"]  = require("trouble.providers.telescope").open_with_trouble,

        -- 選択して、カーソル移動
        ["J"]  = actions.toggle_selection + actions.move_selection_next,
      },
    },
    color_devicons = true,

    set_env = {
      ['COLORTERM'] = 'truecolor',
      -- $ bat --list-themes で確認できる
      ['BAT_THEME'] = 'gruvbox',
    },
  },
  extensions = {
    openbrowser = {
      bookmarks = {},
      bookmark_filepath = vim.fn.stdpath('config') .. '/' .. 'bookmarks'
    },
    -- fzy_native = {
    --   override_generic_sorter = true,
    --   override_file_sorter = true,
    -- }
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    }
  }
}

-------------------
-- load extensions
-------------------
local extensions = {
  'fzy_native',
  'ghq',
  -- 'gh',
  -- 'frecency',
  -- 'sonictemplate',
  'openbrowser',
  -- 'session_manager',
  -- 'dap',

  'plug_names',
  'mru',
  -- 'deol',
  'mrr',
  'fzf',
}
local function load_extensions(exps)
  for _, ext in ipairs(exps) do
    require'telescope'.load_extension(ext)
  end
end
load_extensions(extensions)

-------------------
-- マッピング用の関数を定義
-------------------

local ext = function(name)
  return require('plugins/telescope/' .. name)
end

-- @Summary vimfies から探す
-- @Description
local find_vimfiles = function()
  local cwd = vim.g.vimfiles_path
  local files = vim.tbl_map(function(v)
    -- /path/to/file .. '/'
    return v:sub(#cwd + 2)
  end, vim.fn['mr#filter'](vim.fn['mr#mru#list'](), cwd))

  require'telescope.builtin'.find_files{
    cwd = cwd,
    -- previewer = previewers.cat.new({}),
  }
end


-- @Summary help tagas
-- @Description
local help_tags = function()
  require('telescope.builtin').help_tags {
    sorter = sorters.get_generic_fuzzy_sorter(),
  }
end



-- -- @Summary grep_string
-- -- @Description
-- local gen_grep_string = function()
--
--   -- @Summary cwd を返す
--   -- @Description LeaderF の g:Lf_WorkingDirectoryMode のような感じで返す
--   --              カレントファイルに近い markers があるディレクトリ (もし、marker が見つからなければ cwd)
--   local get_working_dir = function(markers, path, default)
--     default = default or vim.fn.getcwd()
--     if vim.bo.filetype == 'lir' then
--       return require'lir'.get_context().dir
--     end
--     if path ~= '' then
--       return nearest_ancestor(markers, path)
--     else
--       return default
--     end
--   end
--
--   return function()
--     local input = vim.fn.input("Grep String > ")
--     if input == '' then
--       vim.api.nvim_echo({{'Cancel.', 'WarningMsg'}}, false, {})
--       return
--     end
--
--     require'telescope.builtin'.grep_string {
--       layout_config = {
--         preview_width = 0.6,
--       },
--       shorten_path = true,
--       -- LeaderF の A のようにする
--       -- カレントファイルに近い g:Lf_RootMarkers があるディレクトリ (もし、marker が見つからなければ cwd)
--       cwd = get_working_dir({'.git', '.gitignore'}, vim.fn.expand('%:p')),
--       search = input,
--     }
--   end
-- end


-- @Summary git_files か find_files
-- @Description
local find_files = function()
  -- local marker_dir = find_git_ancestor(Path:new(vim.fn.expand('%:p')):absolute())
  local marker_dir = find_git_ancestor(vim.fn.expand('%:p'))
  local cwd
  if marker_dir and marker_dir ~= '' then
    cwd = marker_dir
  else
    cwd = vim.fn.getcwd()
  end

  require'telescope.builtin'.find_files{
    -- layout_strategy = 'horizontal',
    cwd = cwd,
  }
end


-- @Summary filetypes
-- @Description
local filetypes = function()
  require'telescope.builtin'.filetypes {}
end

local lsp_document_symbols = function()
  require'telescope.builtin'.lsp_document_symbols {
    show_line = false,

    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:enhance{
        post = actions.center
      }
      return true
    end,
  }
end


-- @Summary openbrowser
-- @Description
local openbrowser = function()
  require'telescope'.extensions.openbrowser.list {}
end

local n_commands, x_commands = ext('commands')()

local quickfix_in_qflist = function()
  require'telescope.builtin.internal'.quickfix {
    default_selection_index = vim.fn.line('.'),
    layout_strategy = 'horizontal',
  }
end

-- local deol = function()
--   require('telescope').extensions.deol.list {}
-- end

-- local oldfiles = function()
--   require'telescope.builtin.internal'.oldfiles {
--     previewer = false
--   }
-- end

local current_buffer_line = function()
  require('telescope.builtin.files').current_buffer_fuzzy_find {
  }
end




local mapp = function(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(mode, lhs, rhs, vim.tbl_extend('keep', opts or {}, { silent = true, noremap = true }))
end

local map_ext = function(mode, lhs, name, opts)
  mapp(mode, lhs, string.format('<Cmd>lua require"plugins/telescope/%s"()<CR>', name), opts)
end

map_ext('n', '<Space>fd', 'fd_lir')
map_ext('n', '<Space>fj', 'buffers')
map_ext('n', '<Space>fk', 'mru')
map_ext('n', '<Space>fq', 'ghq')
map_ext('n', '<Space>;t', 'sonictemplate')
map_ext('n', '<Space>fy', 'miniyank')


local mappings = {
  ['n<Space>fv'] = {find_vimfiles},
  ['n<Space>fh'] = {help_tags},
  ['n<Space>ff'] = {find_files},
  ['n<Space>ft'] = {filetypes},
  ['n<Space>fs'] = {lsp_document_symbols},
  ['n<Space>fo'] = {openbrowser},
  ['n<A-x>']     = {n_commands},
  ['x<A-x>']     = {x_commands},
  ['n<Space>f/'] = {current_buffer_line},
  ['n<Space>f;'] = {'<Cmd>Telescope command_history<CR>'}
}

-- require'which-key'.register({
--   ['<Space>f'] = {
--     name = "+Fuzzy Finder",
--     f = { "Find file" },
--     v = { "Find vim iles" },
--     h = { "Search help" },
--     j = { "Open buffer" },
--     t = { "Set filetype" },
--     q = { "Open ghq reposigoty" },
--     s = { "Lsp document/symbol" },
--     o = { "Open browser bookmarks" },
--     n = { "Ssearch current buffer line" },
--     k = { "Open MRU file" },
--     g = { "ripgrep" },
--   }
-- })

nvim_apply_mappings(mappings, {noremap = true, silent = true})


local lsp_references = function()
  require'telescope.builtin'.lsp_references {
    sorting_strategy = "ascending",
    prompt_position = 'top',

    layout_config = {
      -- width_padding =  -- "How many cells to pad the width",
      height_padding = 10, -- "How many cells to pad the height",
      preview_width = 0.6 -- "(Resolvable): Determine preview width",
    },
  }
end

-- local lir_mrr = function()
--   require('telescope').extensions.mrr.list {
--     previewer = false,
--     file_ignore_patterns = { "%.plugged" },
--
--     sorter = get_fzy_sorter_use_list({
--       list = vim.fn['mr#mrr#list'](),
--     }),
--   }
-- end




local gitignore = function()
  local results = vim.fn['denops#request']('gignore', 'getLanguages', {})

  pickers.new({}, {
    prompt_title = 'gitignore',
    finder = finders.new_table {
      results = results,
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local entry = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        -- TODO: 複数に対応
        vim.fn['denops#request']('gignore', 'setLines', {entry.value})
      end)

      return true
    end,
  }):find()
end

vim.cmd[[command! GitIgnoreTelescope lua require'plugins.telescope_nvim'.gitignore()]]



return {
  lsp_references = lsp_references,
  quickfix_in_qflist = quickfix_in_qflist,
  -- lir_mrr = lir_mrr,
  deol_history = ext('deol_history'),
  git_commit_prefix = ext('git_commit_prefix'),
  gitignore = gitignore,
  fd_lir = ext('fd_lir'),
}
