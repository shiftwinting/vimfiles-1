if vim.api.nvim_call_function('FindPlugin', {'telescope.nvim'}) == 0 then do return end end

local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
-- local pickers = require('telescope.pickers')
-- local finders = require('telescope.finders')
local previewers = require('telescope.previewers')
-- local conf = require('telescope.config').values
-- local transform_mod = require('telescope.actions.mt').transform_mod
-- local make_entry = require('telescope.make_entry')

local Path = require'plenary.path'

-- local my_entry_maker = require('vimrc.telescope.make_entry')


-- https://github.com/nvim-lua/telescope.nvim/blob/d32d4a6e0f0c571941f1fd37759ca1ebbdd5f488/lua/telescope/init.lua
require'telescope'.setup{
  defaults = {
    borderchars = {'-', '|', '-', '|', '+', '+', '+', '+'},
    -- borderchars = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
    winblend = 0,

    prompt_position = "bottom",
    -- sorting_strategy = "ascending",

    -- https://github.com/nvim-telescope/telescope.nvim/issues/425
    layout_strategy = 'horizontal',
    layout_defaults = {
      vertical = {
        width_padding = 0.05,
        height_padding = 3,
        preview_height = 0.6,
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
        ["<C-q>"] = actions.send_to_qflist,
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

    set_env = {
      ['COLORTERM'] = 'truecolor',
      -- $ bat --list-themes で確認できる
      ['BAT_THEME'] = 'gruvbox',
    },
  },
  extensions = {
    openbrowser = {
      bookmarks = {
        ['cica']                   = 'https://miiton.github.io/Cica/',
        ['lua manual']             = 'http://milkpot.sakura.ne.jp/lua/lua51_manual_ja.html',
        ['luv vim.loop']           = 'https://github.com/luvit/luv/blob/master/docs.md',
        ['luarocks.org']           = 'luarocks.org',
        ['exercism_lua']           = 'https://exercism.io/my/tracks/lua',
        ['nvim repo']              = 'https://github.com/search?l=Lua&o=desc&q=nvim&s=updated&type=Repositories',
        ['color-picker']           = 'https://www.w3schools.com/colors/colors_picker.asp',
        ['nanotee/nvim-lua-guide'] = 'https://github.com/nanotee/nvim-lua-guide',
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

  'plug_names',
  'mru',
}
local function load_extensions(exps)
  for _, ext in ipairs(exps) do
    require'telescope'.load_extension(ext)
  end
end
load_extensions(extensions)


-------------------
-- 便利関数
-------------------

-- @Summary path から一番近い markers を含むディレクトリを返す
-- @Description
-- @Param  markers ファイル名かディレクトリ名のリスト
-- @Param  path 起点となるパス
local nearest_ancestor = function(markers, path)
  local root = '/'
  local p = Path:new(path)

  -- / になるまで、上に遡る
  while p:absolute() ~= root do
    for _, name in ipairs(markers) do
      if p:joinpath(name):exists() then
        pprint(p:absolute())
        return p:absolute()
      end
    end

    -- /home の parents() は nil になるため
    if p:parents() == nil then
      p = Path:new('/')
    else
      p = Path:new(p:parents())
    end

  end

  -- /.git とかを探す
  for _, name in ipairs(markers) do
    if p:joinpath(name):exists() then
      return p:absolute()
    end
  end

  return ''
end


-- Sorter using the fzy algorithm
local find = function(needle, haystack)
  for i = 1, #haystack do
    if needle == haystack[i] then
      return i
    end
  end
  -- 見つからなかったら、最悪なスコアを返す
  return #haystack
end

-- telescope の sorters.get_fzy_sorter() をもとに作成
-- @Summary なにかしらのリストを使って、ソートをいい感じにする
-- @Description MRUなどのリストを渡す (1が高スコア、#listが低スコア)
-- @Param  opts
--    opts.list ファイルのリスト (entry.ordinal と一致する要素を含むリスト)
--    opts.get_needle  entry から needle となる値を取得する関数
get_fzy_sorter_use_list = function(opts)
  vim.validate {
    opts = { opts, 'table', false }
  }
  vim.validate {
    ['opts.list'] = { opts.list, 'table', false },
    ['opts.get_needle'] = { opts.get_needle, 'function', true },
  }
  local list = opts.list
  local get_needle = opts.get_needle or (function(v) return v.ordinal end)

  local fzy = require('telescope.algos.fzy')
  -- すべての文字列 prompt, line において、
  --  fzy.get_score_min() ～ fzy.get_score_max() の間になく、
  --  fzy.has_match(prompt, line) == true のとき
  -- fzy.score(prompt, line) > fzy.get_score_floor() が true になる
  local OFFSET = -fzy.get_score_floor() -- (1024 + 1) * -0.01 = -10.25

  -- 0 が最高、1 が最悪、-1はマッチしなかった
  return sorters.Sorter:new{
    discard = true,

    -- line == ordinal
    scoring_function = function(_, prompt, line, entry)
      -- まず、マッチするかをチェックする
      if not fzy.has_match(prompt, line) then
        return -1
      end

      local fzy_score = fzy.score(prompt, line)

      -- 空クエリか、長過ぎる文字列は fzy を -inf (fzy.get_score_min()) になるため、
      -- 最悪のスコアである 1 を返す
      -- また、この関数は、0 ~ 1 の間のスコアを返す
      if fzy_score == fzy.get_score_min() then
        return 1 + #list
      end

      -- Poor non-empty matches can also have negative values. Offset the score
      -- so that all values are positive, then invert to match the
      -- telescope.Sorter "smaller is better" convention. Note that for exact
      -- matches, fzy returns +inf, which when inverted becomes 0.
      -- リストの先頭が最高のスコアになるように足し込む (小さい方が高スコアだから)
      -- pprint(find(get_needle(entry), list))
      return (1 / (fzy_score + OFFSET)) + find(get_needle(entry), list)
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


-------------------
-- マッピング用の関数を定義
-------------------

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
    previewer = previewers.cat.new({}),
    sorter = get_fzy_sorter_use_list({
      list = files
    })
  }
end


-- @Summary help tagas
-- @Description
local help_tags = function()
  require('telescope.builtin').help_tags {
    sorter = sorters.get_generic_fuzzy_sorter(),
  }
end


-- @Summary buffers
-- @Description
local buffers = function()
  require('telescope.builtin').buffers {
    layout_strategy = 'vertical',
    shorten_path = false,
    show_all_buffers = true,
    previewer = previewers.cat.new({}),
    -- entry_maker = my_entry_maker.gen_from_buffer_like_leaderf(),

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
end


-- @Summary grep_string
-- @Description
local gen_grep_string = function()

  -- @Summary cwd を返す
  -- @Description LeaderF の g:Lf_WorkingDirectoryMode のような感じで返す
  --              カレントファイルに近い markers があるディレクトリ (もし、marker が見つからなければ cwd)
  local get_working_dir = function(markers, path)
    if path ~= '' then
      return nearest_ancestor(markers, path)
    else
      return vim.fn.getcwd()
    end
  end

  return function()
    local input = vim.fn.input("Grep String > ")
    if input == '' then
      vim.api.nvim_echo({{'Cancel.', 'WarningMsg'}}, false, {})
      return
    end

    require'telescope.builtin'.grep_string {
      layout_config = {
        preview_width = 0.6,
      },
      shorten_path = true,
      -- LeaderF の A のようにする
      -- カレントファイルに近い g:Lf_RootMarkers があるディレクトリ (もし、marker が見つからなければ cwd)
      cwd = get_working_dir({'.git', '.gitignore'}, vim.fn.expand('%:p')),
      search = input,
    }
  end
end


-- @Summary git_files か find_files
-- @Description
local find_files = function()
  local marker_dir = nearest_ancestor({'.git', '.gitignore'}, Path:new(vim.fn.expand('%:p')):absolute())
  if marker_dir ~= '' then
    require'telescope.builtin'.git_files{
      layout_strategy = 'horizontal',
      cwd = marker_dir,
    }
  else
    require'telescope.builtin'.find_files{
      layout_strategy = 'horizontal',
      cwd = vim.fn.getcwd(),
    }
  end
end

-- @Summary mru
-- @Description
local mru = function()
  require('telescope').extensions.mru.list {
    layout_strategy = 'vertical',
    file_ignore_patterns = { "^/tmp" },
    previewer = previewers.cat.new({}),
    sorter = get_fzy_sorter_use_list({
      list = vim.fn['mr#mru#list'](),
      get_needle = function(entry)
        return entry.filename
      end
    }),
    -- entry_maker = make_entry.gen_from_file(),
    attach_mappings = function(prompt_bufnr, _)
      actions.goto_file_selection_tabedit:replace(function ()
        local selection = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        local val = selection.value
        vim.fn['vimrc#drop_or_tabedit'](val)
        -- vim.api.nvim_command(string.format('drop %s', val))
      end)
      return true
    end
  }
end

-- @Summary ghq
-- @Description
local ghq = function()
  local ghq_root = vim.env.GHQ_ROOT
  require'telescope'.extensions.ghq.list{
    previewer = false,
    sorter = get_fzy_sorter_use_list({
      list = vim.fn['mr#mrr#list'](),
      get_needle = function(entry)
        return entry.value
      end
    }),
    entry_maker = function(line)
      local short_name = string.sub(line, #ghq_root + #'/github.com/' + 1)
      return {
        value = line,
        ordinal = short_name,
        display = short_name,
      }
    end,
    attach_mappings = function(prompt_bufnr, _)
      actions.goto_file_selection_edit:replace(function()
        local val = actions.get_selected_entry().value
        actions.close(prompt_bufnr)
        vim.api.nvim_command('tabnew')
        vim.api.nvim_command(string.format('tcd %s | edit .', val))
        -- vim.api.nvim_command(string.format([[tcd %s | lua require'lir.float'.toggle()]], val))
      end)
      return true
    end
  }
end


-- @Summary filetypes
-- @Description
local filetypes = function()
  require'telescope.builtin'.filetypes {}
end


-- @Summary current_buffer_tags
-- @Description
local current_buffer_tags = function()
  local tagfiles = vim.fn.tagfiles()
  if #tagfiles > 0 then
    tagfile = tagfiles[1]
  else
    tagfile = nil
  end
  print(tagfile)
  require'telescope.builtin'.current_buffer_tags {
    ctags_file = tagfile
  }
end


-- @Summary sonictemplate
-- @Description
local sonictemplate = function()
  require'telescope'.extensions.sonictemplate.templates {}
end

-- @Summary openbrowser
-- @Description
local openbrowser = function()
  require'telescope'.extensions.openbrowser.list {}
end


-- commands
local function commands()
  local function make_def_func(is_xmap)
    return function(prompt_bufnr, _)
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

  -- @Summary リストを反転する
  -- @Description リストを反転する
  -- @Param  t リスト
  local reverse = function(t)
    local n = #t
    for i = 1, n/2 do
      t[i], t[n] = t[n], t[i]
      n = n - 1
    end
    return t
  end

  -- @Summary commands の Sorter を生成
  -- @Description 履歴をもとにして、ソートする Sorter を生成して返す
  local function get_commands_sorter()
    local list = {}
    -- :history cmd で取れるやつを取得する
    local history_string = vim.fn.execute('history cmd')
    local history_list = reverse(vim.split(history_string, "\n"))
    for _, line in ipairs(history_list) do
      --                  ^\>?\s+\d+\s+([^ !]+)
      local cmd = line:match('^>?%s+%d+%s+([^ !]+)')
      if cmd then
        table.insert(list, cmd)
      end
    end

    return get_fzy_sorter_use_list({
      list = list,
    })
  end

  local n_commands = function()
    require('telescope.builtin').commands {
      sorter = get_commands_sorter(),
      attach_mappings = function(prompt_bufnr, map)

        actions.goto_file_selection_edit:replace(make_def_func())

        map('i', '<C-e>', make_edit_command_func())

        return true
      end
    }
  end

  local x_commands = function()
    require('telescope.builtin').commands {
      sorter = get_commands_sorter(),
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
  end

  return n_commands, x_commands
end

local n_commands, x_commands = commands()

local mappings = {
  ['n<Space>fv'] = {find_vimfiles},
  ['n<Space>fh'] = {help_tags},
  ['n<Space>fj'] = {buffers},
  ['n<Space>fg'] = {gen_grep_string()},
  ['n<Space>ff'] = {find_files},
  ['n<Space>ft'] = {filetypes},
  ['n<Space>fk'] = {mru},
  ['n<Space>fq'] = {ghq},
  ['n<Space>fs'] = {current_buffer_tags},
  ['n<Space>;t'] = {sonictemplate},
  ['n<Space>fo'] = {openbrowser},
  ['n<A-x>']     = {n_commands},
  ['x<A-x>']     = {x_commands},
}

nvim_apply_mappings(mappings, {noremap = true, silent = true})


