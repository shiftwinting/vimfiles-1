if vim.api.nvim_call_function('FindPlugin', {'telescope.nvim'}) == 0 then do return end end

local actions = require('telescope.actions')
local action_set = require'telescope.actions.set'
local action_state = require'telescope.actions.state'
local sorters = require('telescope.sorters')
-- local pickers = require('telescope.pickers')
-- local finders = require('telescope.finders')
local previewers = require('telescope.previewers')
-- local conf = require('telescope.config').values
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
    borderchars = {'-', '|', '-', '|', '+', '+', '+', '+'},
    -- borderchars = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
    winblend = 0,
    -- prompt_position = "bottom",
    prompt_position = "top",
    sorting_strategy = "ascending",

    -- https://github.com/nvim-telescope/telescope.nvim/issues/425
    layout_strategy = 'horizontal',
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
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<CR>"]  = actions.select_default,

        -- switch insert mode
        ["<Tab>"] = function(_, _)
          vim.api.nvim_feedkeys('i', 'n', true)
        end,

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
      bookmarks = {
        ['cica']                       = 'https://miiton.github.io/Cica/',
        ['lua manual']                 = 'http://milkpot.sakura.ne.jp/lua/lua51_manual_ja.html',
        ['luv vim.loop']               = 'https://github.com/luvit/luv/blob/master/docs.md',
        ['luarocks.org']               = 'luarocks.org',
        ['exercism_lua']               = 'https://exercism.io/my/tracks/lua',
        ['nvim repo']                  = 'https://github.com/search?l = Lua&o = desc&q = nvim&s = updated&type = Repositories',
        ['color-picker']               = 'https://www.w3schools.com/colors/colors_picker.asp',
        ['nanotee/nvim-lua-guide']     = 'https://github.com/nanotee/nvim-lua-guide',
        ['doc.rust-jp.rs']             = 'https://doc.rust-jp.rs/',
        ['rust-analyzer manual']       = 'https://rust-analyzer.github.io/manual.html',
        ['luadoc']                     = 'https://keplerproject.github.io/luadoc/',
        ['awesome lua']                = 'https://github.com/uhub/awesome-lua',
        ['lsp specification']          = 'https://microsoft.github.io/language-server-protocol/specifications/specification-current/',
        -- ['git.io']                  = 'https://git.io/',
        ['AUR (Arch user repository)'] = 'https://aur.archlinux.org/',
        ['Arch Linux Packages']        = 'https://archlinux.org/packages/',
        ["i3 User's Guide"]            = 'https://i3wm.org/docs/userguide.html',
        ['zig documentation']          = 'https://ziglang.org/documentation/master/',
        ['ziglings']                   = 'https://zenn.dev/tamago324/scraps/b072e8ae70907f'
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
  -- 'gh',
  -- 'frecency',
  'sonictemplate',
  'openbrowser',

  'plug_names',
  'mru',
  'deol',
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
--@Summary なにかしらのリストを使って、ソートをいい感じにする
--@Description MRUなどのリストを渡す (1が高スコア、#listが低スコア)
--@Param  opts
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


--- 選択しているときとしていないときの両方でひらけるようにした
---
---@param prompt_bufnr number
---@param first_open_cmd string 最初のアイテムを開くコマンド
---@param other_open_cmd string 2つ目以降のアイテムを開くコマンド
---@return function
local smart_open = function(prompt_bufnr, first_open_cmd, other_open_cmd)
  first_open_cmd = first_open_cmd or 'drop'
  other_open_cmd = other_open_cmd or first_open_cmd

  return function()
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    local selections = current_picker:get_multi_selection()
    actions.close(prompt_bufnr)

    if not next(selections) then
      -- 選択してなかったら、カーソル下のアイテムを開く
      local val = action_state.get_selected_entry().value
      vim.api.nvim_command(string.format('%s %s', first_open_cmd, val))
    else
      for i, selection in ipairs(selections) do
        local cmd = (i == 1 and first_open_cmd) or other_open_cmd
        local val = selection.value
        vim.api.nvim_command(string.format('%s %s', cmd, val))
      end
    end
  end
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
  -- 表示したくないバッファ
  local invalid_regex_list = {'^term://', '^deol%-edit@'}

  local is_valid_bufnr = function(bufnr)
    for _, re in ipairs(invalid_regex_list) do
      if vim.api.nvim_buf_get_name(bufnr):match(re) then
        return false
      end
    end
    return true
  end

  -- local ignore_current_buffer = true
  local ignore_current_buffer = false
  -- local current_bufnr = a.nvim_get_current_buf()

  local gen_from_buffer_like_leaderf = function(opts)
    opts = opts or {}
    local default_icons, _ = devicons.get_icon('file', '', {default = true})

    local bufnrs = vim.tbl_filter(function(b)
      -- if ignore_current_buffer and (b == current_bufnr) then
      --   -- もし、カレントバッファだったらだめ
      --   return false
      -- end
      return vim.fn.buflisted(b) == 1 and is_valid_bufnr(b)
    end, vim.api.nvim_list_bufs())

    local bufnr_width = #tostring(math.max(unpack(bufnrs)))

    local max_bufname = math.max(
      unpack(
        vim.list_extend(
          {vim.fn.strdisplaywidth('[No Name]')},
          vim.tbl_map(function(bufnr)
            return vim.fn.strdisplaywidth(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':p:t'))
          end, bufnrs)
        )
      )
    )

    local displayer = entry_display.create {
      separator = " ",
      items = {
        { width = bufnr_width },
        -- { width = 4 },
        { width = 1 }, -- 同じプロジェクト内かどうか？
        { width = utils.strdisplaywidth(default_icons) },
        { width = utils.strdisplaywidth(default_icons) },
        { width = max_bufname },
        { remaining = true },
      },
    }

    -- local cwd = vim.fn.expand(opts.cwd or vim.fn.getcwd())

    -- リストの場合、ハイライトする
    local make_display = function(entry)
      return displayer {
        {entry.bufnr, "TelescopeResultsNumber"},
        -- {entry.indicator, "TelescopeResultsComment"},
        entry.mark_in_same_project,
        {entry.mark_win_info, 'WarningMsg'},
        {entry.devicons, entry.devicons_highlight},
        entry.file_name,
        {entry.dir_name, "Comment"}
      }
    end

    local root_dir
    do
      local dir = vim.fn.expand('%:p:h')
      if dir == '' then
        dir = vim.fn.getcwd()
      end
      root_dir = find_git_ancestor(dir)
    end

    return function(entry)
      local bufname = entry.info.name ~= "" and entry.info.name or '[No Name]'

      -- local hidden = entry.info.hidden == 1 and 'h' or 'a'
      -- local readonly = vim.api.nvim_buf_get_option(entry.bufnr, 'readonly') and '=' or ' '
      -- local changed = entry.info.changed == 1 and '+' or ' '
      -- local indicator = entry.flag .. hidden .. readonly .. changed

      local dir_name = vim.fn.fnamemodify(bufname, ':p:h')
      local file_name = vim.fn.fnamemodify(bufname, ':p:t')

      local icons, highlight = devicons.get_icon(bufname, string.match(bufname, '%a+$'), { default = true })

      -- プロジェクト内のファイルなら、印をつける
      -- 現在のバッファのプロジェクトを見つける
      local mark_in_same_project = ''
      if root_dir and root_dir ~= '' and vim.startswith(bufname, root_dir) then
        mark_in_same_project = '*'
      end

      -- もし、いずれかのウィンドウに表示されていたら、印をつける
      -- 󿩋󿫼󿫌󿨯󿧽󿥚󿦕󿥙󿠦󿟆󿝀󿔾
      local mark_win_info = ''
      local bufinfo = vim.fn.getbufinfo(entry.bufnr)
      if entry.bufnr == vim.api.nvim_get_current_buf() then
        mark_win_info = '󿕅'
      elseif not vim.tbl_isempty(bufinfo) and not vim.tbl_isempty(bufinfo[1].windows) then
        mark_win_info = '󿠦'
      end

      return {
        valid = is_valid_bufnr(entry.bufnr),

        value = bufname,
        -- -- バッファ番号、ファイル名のみ、検索できるようにする
        -- ordinal = entry.bufnr .. " : " .. file_name,
        ordinal = file_name,
        display = make_display,

        bufnr = entry.bufnr,

        lnum = entry.info.lnum ~= 0 and entry.info.lnum or 1,
        -- indicator = indicator,
        devicons = icons,
        devicons_highlight = highlight,

        file_name = file_name,
        dir_name = dir_name,

        mark_in_same_project = mark_in_same_project,
        mark_win_info = mark_win_info,
      }
    end
  end

  require('telescope.builtin').buffers {
    -- layout_strategy = 'vertical',
    shorten_path = false,
    show_all_buffers = true,
    ignore_current_buffer = ignore_current_buffer,
    sorter = get_fzy_sorter_use_list({
      list = vim.fn['mr#mru#list'](),
      get_needle = function(entry)
        return vim.fn.expand(entry.filename)
      end
    }),
    -- previewer = previewers.cat.new({}),
    previewer = false,
    entry_maker = gen_from_buffer_like_leaderf(),

    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(smart_open(prompt_bufnr, 'drop', 'hide edit'))
      actions.select_horizontal:replace(smart_open(prompt_bufnr, 'new'))
      actions.select_vertical:replace(smart_open(prompt_bufnr, 'vnew'))
      actions.select_tab:replace(smart_open(prompt_bufnr, 'tabedit'))

      local function delete_buffer()
        local selection = action_state.get_selected_entry()
        pcall(vim.cmd, string.format([[silent bdelete! %s]], selection.bufnr))

        -- TODO: refresh
      end

      map('n', 'D', delete_buffer)

      return true
    end,
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
  local marker_dir = find_git_ancestor(Path:new(vim.fn.expand('%:p')):absolute())
  if marker_dir and marker_dir ~= '' then
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
    -- layout_strategy = 'vertical',
    file_ignore_patterns = { "^/tmp" },
    -- previewer = previewers.cat.new({}),
    previewer = false,
    sorter = get_fzy_sorter_use_list({
      list = vim.fn['mr#mru#list'](),
      get_needle = function(entry)
        return entry.filename
      end
    }),
    -- entry_maker = make_entry.gen_from_file(),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(smart_open(prompt_bufnr, 'drop', 'hide edit'))
      actions.select_horizontal:replace(smart_open(prompt_bufnr, 'new'))
      actions.select_vertical:replace(smart_open(prompt_bufnr, 'vnew'))
      actions.select_tab:replace(smart_open(prompt_bufnr, 'tabedit'))
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
    -- sorter = get_fzy_sorter_use_list({
    --   list = vim.fn['mr#mrr#list'](),
    --   get_needle = function(entry)
    --     return entry.value
    --   end
    -- }),
    entry_maker = function(line)
      local short_name = string.sub(line, #ghq_root + #'/github.com/' + 1)
      return {
        value = line,
        ordinal = short_name,
        display = short_name,
        short_name = short_name,
      }
    end,
    attach_mappings = function(prompt_bufnr, map)
      local tabnew = function()
        local val = action_state.get_selected_entry().value
        actions.close(prompt_bufnr)
        vim.api.nvim_command('tabnew')
        vim.api.nvim_command(string.format('tcd %s | edit .', val))
        -- vim.api.nvim_command(string.format([[tcd %s | lua require'lir.float'.toggle()]], val))
      end

      -- ブラウザで開く
      local open_browser = function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.fn['openbrowser#open'](string.format('https://github.com/%s', entry.short_name))
      end

      actions.select_default:replace(tabnew)
      actions.select_tab:replace(tabnew)
      map('i', '<C-x>', open_browser)
      map('n', '<C-x>', open_browser)

      return true
    end
  }
end


-- @Summary filetypes
-- @Description
local filetypes = function()
  require'telescope.builtin'.filetypes {}
end


-- -- @Summary current_buffer_tags
-- -- @Description
-- local current_buffer_tags = function()
--   local tagfiles = vim.fn.tagfiles()
--   if #tagfiles > 0 then
--     tagfile = tagfiles[1]
--   else
--     tagfile = nil
--   end
--   print(tagfile)
--   require'telescope.builtin'.current_buffer_tags {
--     ctags_file = tagfile
--   }
-- end


local lsp_document_symbols = function()
  require'telescope.builtin'.lsp_document_symbols {
    show_line = false,
  }
end


-- local treesitter_or_current_buffer_tags = function()
--   if parsers.has_parser() then
--     require('telescope.builtin.files').treesitter {
--       show_line = false
--     }
--   else
--     -- もし、treesitter がなければ、 ctags を使う
--     current_buffer_tags()
--   end
-- end

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
      local entry = action_state.get_selected_entry()
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
      local entry = action_state.get_selected_entry()
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

        actions.select_default:replace(make_def_func())

        map('i', '<C-e>', make_edit_command_func())

        return true
      end
    }
  end

  local x_commands = function()
    require('telescope.builtin').commands {
      sorter = get_commands_sorter(),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(make_def_func(true))
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

local quickfix_in_qflist = function()
  require'telescope.builtin.internal'.quickfix {
    default_selection_index = vim.fn.line('.'),
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

local mappings = {
  ['n<Space>fv'] = {find_vimfiles},
  ['n<Space>fh'] = {help_tags},
  ['n<Space>fj'] = {buffers},
  -- ['n<Space>fg'] = {gen_grep_string()},
  ['n<Space>ff'] = {find_files},
  -- ['n<Space>ft'] = {filetypes},
  ['n<Space>fk'] = {mru},
  -- ['n<Space>fk'] = {oldfiles},
  ['n<Space>fq'] = {ghq},
  -- ['n<Space>fs'] = {current_buffer_tags},
  ['n<Space>fs'] = {lsp_document_symbols},
  -- ['n<Space>fs'] = {treesitter_or_current_buffer_tags},
  -- ['n<Space>;t'] = {sonictemplate},
  ['n<Space>fo'] = {openbrowser},
  ['n<A-x>']     = {n_commands},
  ['x<A-x>']     = {x_commands},
  ['n<Space>fn'] = {current_buffer_line},
  -- ['n<Space>fd'] = {deol},
}

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

return {
  lsp_references = lsp_references,
  quickfix_in_qflist = quickfix_in_qflist,
}
