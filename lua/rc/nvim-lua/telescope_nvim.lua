if vim.api.nvim_call_function('FindPlugin', {'telescope.nvim'}) == 0 then do return end end

local map_command = require'vimrc.utils'.map_command

local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local previewers = require('telescope.previewers')
local conf = require('telescope.config').values

local my_entry_maker = require('vimrc.telescope.make_entry')

vim.env.BAT_THEME = 'gruvbox-light'

require'telescope'.load_extension('fzy_native')

-- https://github.com/nvim-lua/telescope.nvim/blob/d32d4a6e0f0c571941f1fd37759ca1ebbdd5f488/lua/telescope/init.lua
require'telescope'.setup{
  defaults = {
    borderchars = {'-', '|', '-', '|', '+', '+', '+', '+'},
    -- borderchars = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
    winblend = 0,

    -- prompt_position = "top",
    -- sorting_strategy = "ascending",
    -- layout_strategy = "center",
    layout_strategy = 'horizontal',

    results_title = false,
    preview_title = false,
    width = 0.8,
    results_height = 40,

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

local mappings = {
  ['n//'] = {[[:<C-u>Telescope current_buffer_fuzzy_find<CR>]], silent = false},

  -- find_files
  ['n<Space>fv'] = {function()
    require'telescope.builtin'.find_files{
      cwd = vim.g.vimfiles_path,
      file_ignore_patterns = { "_config/.*" },
      previewer = previewers.cat.new({}),
    }
  end},

  -- command_history
  ['n<Space>f;'] = {function()
    require('telescope.builtin').command_history {}
  end},

  -- help
  ['n<Space>fh'] = {function()
    require('telescope.builtin').help_tags {
      -- previewer = false,
      sorter = sorters.get_fzy_sorter(),
    }
  end},

  -- buffers
  ['n<Space>fj'] = {function()
    require('telescope.builtin').buffers {
      shorten_path = false,
      show_all_buffers = true,
      previewer = previewers.cat.new({}),
      entry_maker = my_entry_maker.gen_from_buffer_like_leaderf(),

      -- <C-t> で他のバッファ
      attach_mappings = function(prompt_bufnr, map)
        actions.goto_file_selection_tabedit:replace(function ()
          local selection = actions.get_selected_entry(prompt_bufnr)
          actions.close(prompt_bufnr)
          local val = selection.value
          vim.fn['vimrc#drop_or_tabedit'](val)
          -- vim.api.nvim_command(string.format('drop %s', val))
        end)

        actions.goto_file_selection_edit:replace(function ()
          local selection = actions.get_selected_entry(prompt_bufnr)
          actions.close(prompt_bufnr)
          local val = selection.value
          print(val)
          vim.api.nvim_command(string.format('edit %s', val))
        end)

        return true
      end,
    }
  end},

  -- git_files
  ['n<Space>ff'] = {function()
    require'telescope.builtin'.git_files{}
  end},

  -- filetypes
  ['n<Space>ft'] = {function()
    require'telescope.builtin'.filetypes{}
  end},

  -- mru
  ['n<Space>fk'] = {function()
    require('vimrc.telescope').mru{
      file_ignore_patterns = { "^/tmp" },
      previewer = previewers.cat.new({}),
    }
  end},

  -- ghq
  ['n<Space>fq'] = {function()
    require('vimrc.telescope').ghq{
      sorter = sorters.get_fzy_sorter(),
    }
  end},

  -- reloader
  ['n<Space>fl'] = {function()
    require'telescope.builtin'.reloader{
      sorter = sorters.get_fzy_sorter(),
    }
  end},

  -- plug_names
  ['n<Space>fp'] = {function()
    require('vimrc.telescope').plug_names{}
  end},

  ['n<Space>fs'] = {function()
    require'telescope.builtin'.current_buffer_tags {}
  end},

  ['ngr'] = {function()
    require'telescope.builtin.lsp'.references {}
  end},

  -- git
  ['n<Space>gb'] = {function()
    require'telescope.builtin.git'.branches {
      attach_mappings = function(prompt_bufnr, map)
        local function do_yank()
          local selection = actions.get_selected_entry(prompt_bufnr)
          actions.close(prompt_bufnr)
          local val = selection.value
          vim.fn.setreg(vim.v.register, val)
          print('Yank branch name: ' .. val)
        end

        map('n', 'Y', do_yank)
        return true
      end
    }
  end},

}


-- commands
local function commands()
  local function make_def_func(is_xmap)
    return function(prompt_bufnr, map)
      local selection = actions.get_selected_entry()
      actions.close(prompt_bufnr)
      local val = selection.value
      local cmd = string.format([[:%s%s ]], (is_xmap and "'<,'>" or ''), val.name)

      if val.nargs == "0" or val.nargs == '*' or val.nargs == '?' then
        if is_xmap then
          local cr = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
          vim.api.nvim_feedkeys(cmd .. cr, 'n', true)
        else
          vim.cmd(cmd)
        end
      else
        vim.cmd [[stopinsert]]
        vim.fn.feedkeys(cmd)
      end
    end
  end

  local function make_edit_command_func(is_xmap)
    return function(prompt_bufnr)
      local entry = actions.get_selected_entry()
      actions.close(prompt_bufnr)
      local val = entry.value
      local cmd = string.format([[:%s%s ]], (is_xmap and "'<,'>" or ''), val.name)

      vim.cmd [[stopinsert]]
      vim.fn.feedkeys(cmd)
    end
  end

  mappings['n<A-x>'] = {function()
    require('telescope.builtin').commands {
      attach_mappings = function(prompt_bufnr, map)

        actions.goto_file_selection_edit:replace(make_def_func())

        map('i', '<C-e>', make_edit_command_func())

        return true
      end
    }
  end}

  mappings['x<A-x>'] = {function()
    require('telescope.builtin').commands {
      attach_mappings = function(prompt_bufnr, map)
        actions.goto_file_selection_edit:replace(make_def_func(true))
        map('i', '<C-e>', make_edit_command_func(true))
        return true
      end,

      entry_maker = function(line)
        return {
          -- 範囲指定ができるもののみ
          valid = line ~= "" and line.range,
          value = line,
          ordinal = line.name,
          display = line.name
        }
      end
    }
  end}
end

commands()


nvim_apply_mappings(mappings, {noremap = true, silent = true})
