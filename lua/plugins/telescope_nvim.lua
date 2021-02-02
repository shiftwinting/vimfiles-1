local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local previewers = require('telescope.previewers')
local conf = require('telescope.config').values
local transform_mod = require('telescope.actions.mt').transform_mod

local my_entry_maker = require('vimrc.telescope.make_entry')

-- $ bat --list-themes で確認できる
-- vim.env.BAT_THEME = 'gruvbox-light'
vim.env.BAT_THEME = 'gruvbox'

local M = {}


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
        ["<Esc>"] = actions.close,

        -- 開く
        ["<C-t>"] = actions.goto_file_selection_tabedit,
        ["<C-s>"] = actions.goto_file_selection_split,
        ["<C-v>"] = actions.goto_file_selection_vsplit,
        ["<CR>"]  = actions.goto_file_selection_edit,

        -- switch insert mode
        ["<Tab>"] = function(_, _)
          vim.api.nvim_feedkeys('i', 'n', true)
        end,


        -- -- 選択して、カーソル移動
        -- ["<Space>"]  = actions.add_selection + transform_mod({
        --   x = function()
        --     vim.cmd('normal! k')
        --   end
        -- }),
      },
    },
    color_devicons = true,
  },
  extensions = {
    openbrowser = {
      bookmarks = {
        ['cica'] = 'https://miiton.github.io/Cica/',
        ['lua manual'] = 'http://milkpot.sakura.ne.jp/lua/lua51_manual_ja.html',
        ['luv vim.loop'] = 'https://github.com/luvit/luv/blob/master/docs.md',
        ['luarocks.org'] = 'luarocks.org',
        ['exercism_lua'] = 'https://exercism.io/my/tracks/lua',
        ['nvim repo'] = 'https://github.com/search?l=Lua&o=desc&q=nvim&s=updated&type=Repositories',
        ['color-picker'] = 'https://www.w3schools.com/colors/colors_picker.asp',
      }
    }
  }
}

-------------------
-- load extensions
-------------------
local extensions = {
  'fzy_native',
  'ghq',
  -- 'frecency',
  'sonictemplate',
  'openbrowser',
  'plug_names'
}
local function load_extensions(exps)
  for i, ext in ipairs(exps) do
    require'telescope'.load_extension(ext)
  end
end
load_extensions(extensions)


local mappings = {
  -- ['n//'] = {[[:<C-u>Telescope current_buffer_fuzzy_find<CR>]], silent = false},

  -- find_files
  ['n<Space>fv'] = {function()
    require'telescope.builtin'.find_files{
      cwd = vim.g.vimfiles_path,
      previewer = previewers.cat.new({}),
      -- previewer = false,
      sorter = M.get_fzy_use_history_sorter(),
    }
  end},

  -- -- command_history
  -- ['n<Space>f;'] = {function()
  --   require('telescope.builtin').command_history {}
  -- end},

  -- help
  ['n<Space>fh'] = {function()
    require('telescope.builtin').help_tags {
      sorter = sorters.get_generic_fuzzy_sorter(),
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

        local function delete_buffer()
          local selection = actions.get_selected_entry(prompt_bufnr)
          pcall(vim.cmd, string.format([[silent bdelete! %s]], selection.bufnr))

          -- TODO: refresh
        end

        map('n', 'D', delete_buffer)

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
      attach_mappings = function(prompt_bufnr, map)
        actions.goto_file_selection_tabedit:replace(function ()
          local selection = actions.get_selected_entry(prompt_bufnr)
          actions.close(prompt_bufnr)
          local val = selection.value
          vim.fn['vimrc#drop_or_tabedit'](val)
          -- vim.api.nvim_command(string.format('drop %s', val))
        end)
        return true
      end
    }
  end},

  -- -- frecency
  -- ['n,,'] = {function()
  --   require('telescope').extensions.frecency.frecency  {
  --     attach_mappings = function(prompt_bufnr, map)
  --       actions.goto_file_selection_tabedit:replace(function ()
  --         local selection = actions.get_selected_entry(prompt_bufnr)
  --         actions.close(prompt_bufnr)
  --         local val = selection.value
  --         vim.fn['vimrc#drop_or_tabedit'](val)
  --         -- vim.api.nvim_command(string.format('drop %s', val))
  --       end)
  --
  --       actions.goto_file_selection_edit:replace(function ()
  --         local selection = actions.get_selected_entry(prompt_bufnr)
  --         actions.close(prompt_bufnr)
  --         local val = selection.value
  --         print(val)
  --         vim.api.nvim_command(string.format('edit %s', val))
  --       end)
  --
  --       return true
  --     end
  --   }
  -- end},

  -- ghq
  ['n<Space>fq'] = {function()
    local ghq_root = vim.env.GHQ_ROOT
    require'telescope'.extensions.ghq.list{
      previewer = false,
      sorter = sorters.get_fzy_sorter(),
      entry_maker = function(line)
        return {
          value = line,
          ordinal = line,
          display = string.sub(line, #ghq_root + #'/github.com/' + 1),
        }
      end,
      attach_mappings = function(prompt_bufnr, map)
        actions.goto_file_selection_edit:replace(function(prompt_bufnr)
          local val = actions.get_selected_entry(prompt_bufnr).value
          actions.close(prompt_bufnr)
          vim.api.nvim_command('tabnew')
          vim.api.nvim_command(string.format('tcd %s | edit .', val))
          -- vim.api.nvim_command(string.format([[tcd %s | lua require'lir.float'.toggle()]], val))
        end)
        return true
      end
    }
  end},

  -- -- reloader
  -- ['n<Space>fl'] = {function()
  --   require'telescope.builtin'.reloader{
  --     sorter = sorters.get_fzy_sorter(),
  --   }
  -- end},

  -- -- plug_names
  -- ['n<Space>fp'] = {function()
  --   require('vimrc.telescope').plug_names{}
  -- end},

  ['n<Space>fs'] = {function()
    require'telescope.builtin'.current_buffer_tags {}
  end},

  -- ['ngr'] = {function()
  --   require'telescope.builtin.lsp'.references {}
  -- end},

  -- -- git
  -- ['n<Space>gb'] = {function()
  --   require'telescope.builtin.git'.branches {
  --     attach_mappings = function(prompt_bufnr, map)
  --       local function do_yank()
  --         local selection = actions.get_selected_entry(prompt_bufnr)
  --         actions.close(prompt_bufnr)
  --         local val = selection.value
  --         vim.fn.setreg(vim.v.register, val)
  --         print('Yank branch name: ' .. val)
  --       end
  --
  --       map('n', 'Y', do_yank)
  --       return true
  --     end
  --   }
  -- end},

  ['n<Space>;t'] = {function()
    require'telescope'.extensions.sonictemplate.templates {}
  end},

  ['n<Space>fo'] = {function()
    require'telescope'.extensions.openbrowser.list {}
  end}

}


-- commands
local function commands()
  local function make_def_func(is_xmap)
    return function(prompt_bufnr, map)
      local entry = actions.get_selected_entry()
      actions.close(prompt_bufnr)
      local val = entry.value
      local cmd = string.format([[%s%s ]], (is_xmap and "'<,'>" or ''), val.name)

      if val.nargs == "0" or val.nargs == '*' or val.nargs == '?' then
        if is_xmap then
          local cr = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
          vim.api.nvim_feedkeys(':' .. cmd .. cr, 'n', true)
        else
          vim.fn.histadd("cmd", cmd)
          vim.cmd(cmd)
        end
      else
        vim.cmd [[stopinsert]]
        vim.fn.feedkeys(':' .. cmd)
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


-- Sorter using the fzy algorithm
M.get_fzy_use_history_sorter = function(opts)
  opts = opts or {}
  local fzy = require('telescope.algos.fzy')
  -- すべての文字列 prompt, line において、
  --  fzy.get_score_min() ～ fzy.get_score_max() の間になく、
  --  fzy.has_match(prompt, line) == true のとき
  -- fzy.score(prompt, line) > fzy.get_score_floor() が true になる
  local OFFSET = -fzy.get_score_floor() -- (1024 + 1) * -0.01 = -10.25

  -- 0 が最高、1 が最悪、-1はマッチしなかった
  return sorters.Sorter:new{
    discard = true,

    scoring_function = function(_, prompt, line)
      -- まず、マッチするかをチェックする
      if not fzy.has_match(prompt, line) then
        return -1
      end

      local fzy_score = fzy.score(prompt, line)

      -- 空クエリか、長過ぎる文字列は fzy を -inf (fzy.get_score_min()) になるため、
      -- 最悪のスコアである 1 を返す
      -- また、この関数は、0 ~ 1 の間のスコアを返す
      if fzy_score == fzy.get_score_min() then
        return 1
      end

      -- Poor non-empty matches can also have negative values. Offset the score
      -- so that all values are positive, then invert to match the
      -- telescope.Sorter "smaller is better" convention. Note that for exact
      -- matches, fzy returns +inf, which when inverted becomes 0.
      return (1 / (fzy_score + OFFSET))
    end,

    -- The fzy.positions function, which returns an array of string indices, is
    -- compatible with telescope's conventions. It's moderately wasteful to
    -- call call fzy.score(x,y) followed by fzy.positions(x,y): both call the
    -- fzy.compute function, which does all the work. But, this doesn't affect
    -- perceived performance.
    highlighter = function(_, prompt, display)
      return fzy.positions(prompt, display)
    end,
  }
end


nvim_apply_mappings(mappings, {noremap = true, silent = true})
