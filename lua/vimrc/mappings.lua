require'nvim_utils'

--[[
  nvim_apply_mappings({mappings}[, {default_options}])

  mappings - {
    lhs = rhs
  }

  lhs:
    先頭の1文字がモードを表す
      n -> nmap
      x -> xmap
      v -> vmap
    それ以降の文字列はマッピングを表す

  rhs:
    文字列か関数を指定できる

  LUA_MAPPING でグローバルなマッピングが定義されている
  LUA_BUFFER_MAPPING でグローバルなマッピングが定義されている
]]

local mappings = {
  ["nZZ"]    = {'<Nop>'},
  ["nZQ"]    = {'<Nop>'},
  ["n<C-z>"] = {'<Nop>'},

  -- insert mode で細かく undo できるようにする
  ["i<Del>"] = {'<C-g>u<Del>'},
  ["i<C-w>"] = {'<C-g>u<C-w>'},
  ["i<C-u>"] = {'<C-g>u<C-u>'},

  -- like emacs
  ["i<C-a>"] = {'<C-o>_'},
  ["i<C-e>"] = {'<END>'},
  ["i<C-f>"] = {'<Right>'},
  ["i<C-b>"] = {'<Left>'},

  -- 選択範囲で . を実行
  ["x."] = {[[:normal! .<CR>]]},

  -- シンボリックリンクの先に移動する
  ['ncd'] = {[[:<C-u>exec 'lcd ' .. resolve(expand('%:p:h')) | pwd<CR>]]},

  ['n<Space>vs.'] = {function()
    if vim.bo.ft == 'lua' then
      vim.api.nvim_command[[luafile %]]
    else
      vim.api.nvim_command[[source %]]
    end
    print('source ' .. vim.fn.expand('%:p'))
  end},

  -- update は変更があったときのみ保存するコマンド
  ["n<Space>w"] = {[[:<C-u>update<CR>]]},
  ["n<Space>W"] = {[[:<C-u>update!<CR>]]},
  ["n<Space>q"] = {[[:<C-u>quit<CR>]]},
  ["n<Space>Q"] = {[[:<C-u>quit!<CR>]]},


  -- window 操作
  ["nsh"] = {'<C-w>h'},
  ["nsj"] = {'<C-w>j'},
  ["nsk"] = {'<C-w>k'},
  ["nsl"] = {'<C-w>l'},

  ["nsH"] = {'<C-w>H'},
  ["nsJ"] = {'<C-w>J'},
  ["nsK"] = {'<C-w>K'},
  ["nsL"] = {'<C-w>L'},

  -- 分割ウィンドウを開く
  ["nsn"] = {[[:<C-u>new<CR>]]},

  -- カレントウィンドウを新規タブで開く
  ["nst"] = {'<C-w>T'},

  -- 新規タブ
  ['nso'] = {':<C-u>tabedit<CR>'},

  -- タブ間の移動
  ["ntg"]    = {'<Nop>'},
  ["ngt"]    = {'<Nop>'},
  ["n<C-l>"] = {'gt'},
  ["n<C-h>"] = {'gT'},

  ["n<Space>h"] = {'^'},
  ["x<Space>h"] = {'^'},
  ["n<Space>l"] = {'$'},
  ["x<Space>l"] = {'$h'},

  -- 上下の空白に移動
  -- https://twitter.com/Linda_pp/status/1108692192837533696
  ["n<C-j>"] = {[[:<C-u>keepjumps normal! '}<CR>]]},
  ["n<C-k>"] = {[[:<C-u>keepjumps normal! '{<CR>]]},
  -- ["n<C-j>"] = {'}'},
  -- ["n<C-k>"] = {'{'},
  ["x<C-j>"] = {'}'},
  ["x<C-k>"] = {'{'},

  -- 見た目通りに移動
  ["nj"] = {'gj'},
  ["nk"] = {'gk'},

  ["nG"] = {'Gzz'},


  -- カーソル位置から行末までコピー
  ["nY"] = {'y$'},
  -- 全行コピー
  ["n<Space>ay"] = {[[:<C-u>%y<CR>]]},
  -- 最後にコピーしたテキストを貼り付ける
  ["n<Space>p"] = {[["0p]]},
  ["x<Space>p"] = {[["0p]]},


  -- 直前に実行したマクロを実行する
  ["nQ"] = {'@@'},

  -- terminal
  ["t<C-r>"] = {'<Nop>'},
  -- <C-]> で Job mode に移行
  ["t<Esc>"] = {[[<C-\><C-n>]]},


  -- ハイライトの消去
  ["n<Esc><Esc>"] = {[[:<C-u>noh<CR>]]},


  -- cmdline コマンドライン
  ["c<C-a>"] = {'<Home>'},
  ["c<C-f>"] = {'<Right>'},
  ["c<C-b>"] = {'<Left>'},
  ["c<C-d>"] = {'<Del>'},
  ["c<C-p>"] = {'<Up>'},
  ["c<C-n>"] = {'<Down>'},

  -- / -> \/ にする
  ['c/'] = {[[getcmdtype() ==# '/' ? '\/' : '/']], expr = true; },

  -- :h magic
  ["n/"] = {[[/\v]]},

  ["n<Space>/"] = {[[/\V<C-r>+<CR>]]},
  ["n<Space>s/"] = {[[:vim //g %<Left><Left><Left><Left>]]},

  -- 置換
  ["n<Space>s<Space>"] = {[[:%s///g<Left><Left>]]},


  -- https://github.com/TornaxO7/my_configs/blob/7bab856b4b9956a0101236e28644e56ebc03fcf0/nvim/mappings.vim#L237
  -- 選択文字列を指定の文字で置換
  --  1. `"hy`で選択した範囲の文字列を`h`レジスタに格納
  --  2. `:%s/\V<C-R>h//g`で`h`レジスタにある文字列を検索文字として挿入
  --  3. `<left><left>`で置換後の文字列を入力しやすいようにしている
  ['x<C-r>']      = {[["hy:%s/\v(<C-r>h)//g<C-k$F/i]]},
  ["x<C-r><C-r>"] = {[["hy:%s/\V(<C-r>h)//g<C-k>$F/i]]},

  -- diff
  ["n<Space>dt"] = {[[:<C-u>windo diffthis<CR>]]},
  ["n<Space>do"] = {[[:<C-u>windo diffoff<CR>]]},
  ["n<Space>dp"] = {[[:diffput<CR>]]},
  ["x<Space>dp"] = {[[:diffput<CR>]]},
  ["n<Space>dg"] = {[[:diffget<CR>]]},
  ["x<Space>dg"] = {[[:diffget<CR>]]},

  -- help
  ['x<A-h>'] = {[["hy:help <C-r>h<CR>]]},
  ['n<A-h>'] = {':h '},
  ['xK']     = {'<Nop>'},

  -- クリップボードの貼り付け
  ['i<C-r><C-r>'] = {'<C-r>+'},
  ['c<C-o>']      = {'<C-r>+'},


  -- tyru さんのマッピング
  -- https://github.com/tyru/config/blob/master/home/volt/rc/vimrc-only/vimrc.vim#L618
  ["i<C-l><C-l>"] = {'<C-x><C-l>'},
  ["i<C-l><C-n>"] = {'<C-x><C-n>'},
  ["i<C-l><C-k>"] = {'<C-x><C-k>'},
  ["i<C-l><C-t>"] = {'<C-x><C-t>'},
  ["i<C-l><C-i>"] = {'<C-x><C-i>'},
  ["i<C-l><C-]>"] = {'<C-x><C-]>'},
  ["i<C-l><C-f>"] = {'<C-x><C-f>'},
  ["i<C-l><C-d>"] = {'<C-x><C-d>'},
  ["i<C-l><C-v>"] = {'<C-x><C-v>'},
  ["i<C-l><C-u>"] = {'<C-x><C-u>'},
  ["i<C-l><C-o>"] = {'<C-x><C-o>'},
  ["i<C-l><C-s>"] = {'<C-x><C-s>'},
  ["i<C-l><C-p>"] = {'<C-x><C-p>'},


  -- from https://github.com/wass88/dotfiles/blob/62ad8bca0a494c45294164fb9df27ee440b23e87/.vimrc#L876
  ["x<C-a>"] = {'<C-a>gv'},
  ["x<C-x>"] = {'<C-x>gv'},

  ["n<Space>i"] = {'i_<Esc>r'},

  ["n<Space>v."] = {function()
    vim.fn['vimrc#drop_or_tabedit'](vim.env.MYVIMRC)
  end},
  ['n<Space>v,'] = {function()
    vim.fn['vimrc#drop_or_tabedit'](vim.g.plug_script)
  end},
  ['n<Space>v;'] = {function()
    vim.fn['vimrc#drop_or_tabedit']('~/.zshrc')
  end},

  ['nsf'] = {function()
    local ft = vim.api.nvim_eval([[input('FileType: ', '', 'filetype')]])
    -- もし空ならそのバッファを使う
    if vim.fn.line('$') == 1 and vim.fn.getline(1) and not vim.bo.modified then
      vim.api.nvim_command('e ' .. os.tmpname())
    else
      vim.api.nvim_command('new ' .. os.tmpname())
    end
    vim.bo.filetype = ft
  end },

  -- lir.nvim
  -- ['n<C-e>'] = {[[:<C-u>edit %:p:h<CR>]], silent = true},
  ['n<C-e>'] = { require'lir.float'.toggle },

  ['c<C-x>'] = {[[<C-r>=expand('%:p')<CR>]], silent = false},

  ['n<Space>e'] = { function ()
    local winview = vim.fn.winsaveview()
    vim.cmd[[e!]]
    vim.fn.winrestview(winview)
  end },

  --- toggle quickfix
  ['n<A-q>'] = {
    function()
      local function is_show_qf()
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.api.nvim_buf_get_option(buf, 'buftype') == 'quickfix' then
            return true
          end
        end
        return false
      end

      if is_show_qf() then
        if vim.bo.buftype == 'quickfix' then
          vim.cmd('wincmd p')
        end
        vim.cmd('cclose')
      else
        vim.cmd('botright copen')
      end
    end
  }

}

-- toggle options
local map_option_toggle = function(key, opt)
  mappings['n' .. key] = {function()
    vim.api.nvim_command(string.format('setlocal %s!', opt))
    vim.api.nvim_command(string.format('echo "toggle %s"', opt))
  end}
end

map_option_toggle('<F2>', 'wrap')
map_option_toggle('<F3>', 'readonly')


nvim_apply_mappings(mappings, {silent = false; noremap = true})

