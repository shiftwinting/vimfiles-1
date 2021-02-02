local packer

local init = function()
  if not packer then
    packer = require'packer'
    packer.init({
      package_root = require'packer.util'.join_paths(vim.fn.stdpath('config'), 'pack'),
      luarocks = {
        python_cmd = 'python3'
      }
    })
  end

  packer.reset()

  local use = packer.use
  local use_rocks = packer.use_rocks

  -- config: 後に実行される (必ず start になる)
  --           plug1#func1() のような関数呼び出しは、config に書く
  -- setup: 前に実行される (必ず、 opt になる)
  --        マッピングしてるなら、 setup にする (プラグインを読み込む前に設定したいため)

  use { 'wbthomason/packer.nvim', opt = true }

  use 'vim-jp/vimdoc-ja'
  use 'vim-jp/syntax-vim-ex'
  use 'vim-jp/vital.vim'
  use 'markonm/traces.vim'
  use 'tomtom/tcomment_vim'
  use 'ludovicchabant/vim-gutentags'
  use 'kana/vim-repeat'
  use 'lambdalisue/suda.vim'
  use 'lambdalisue/vim-protocol'
  use 'lambdalisue/mr.vim'
  use 'lambdalisue/mr-quickfix.vim'
  use 'lambdalisue/edita.vim'

  use { 'andymass/vim-matchup',          config = function() require'plugins/vim-matchup' end }
  use { 'glidenote/memolist.vim',        setup = function() require('plugins/memolist') end,
    cmd = { 'MemoNew' }
  }
  use { 'haya14busa/vim-asterisk',       setup = function() require('plugins/vim-asterisk') end,
    keys = {
      '<Plug>(asterisk-gz*)',
      '<Plug>(asterisk-z*)'
    }
  }
  use { 'cohama/lexima.vim',             setup = function() require('plugins/lexima') end }
  use { 'junegunn/vim-easy-align',       setup = function() require('plugins/vim-easy-align') end,
    keys = { '<Plug>(EasyAlign)' }
  }
  use { 'simeji/winresizer',             setup = function() require('plugins/winresizer') end }
  use { 'svermeulen/vim-cutlass',        setup = function() require('plugins/vim-cutlass') end }
  use { 'voldikss/vim-translator',       config = function() require('plugins/vim-translator') end }
  use { 'mhinz/vim-grepper',             config = function() require('plugins/vim-grepper') end }
  use { 'hrsh7th/vim-eft',               setup = function() require('plugins/vim-eft') end,
    keys = {
      '<Plug>(eft-f-repeatable)',
      '<Plug>(eft-F-repeatable)',
      '<Plug>(eft-t-repeatable)',
      '<Plug>(eft-T-repeatable)',
    }
  }
  use { 'machakann/vim-sandwich',        setup = function() require('plugins/vim-sandwich') end,
    keys = {
      '<Plug>(textobj-sandwich-auto-i)',
      '<Plug>(textobj-sandwich-auto-a)',
    }
  }
  use { 'machakann/vim-highlightedyank', config = function() require('plugins/vim-highlightedyank') end }
  use { 'machakann/vim-swap',            setup = function() require('plugins/vim-swap') end,
    keys = {
      '<Plug>(swap-prev)',
      '<Plug>(swap-next)',
      '<Plug>(swap-interactive)',
      '<Plug>(swap-textobject-i)',
      '<Plug>(swap-textobject-a)'
    }
  }
  use { 'rcmdnk/yankround.vim',          setup = function() require('plugins/yankround') end,
    keys = {
      '<Plug>(yankround-p)',
      '<Plug>(yankround-P)',
      '<Plug>(yankround-gp)',
      '<Plug>(yankround-gP)',
      '<Plug>(yankround-prev)',
      '<Plug>(yankround-next)',
    }
  }
  use { 'mattn/sonictemplate-vim',       setup = function() require('plugins/sonictemplate') end }
  use { 'mattn/vim-findroot',            config = function() require('plugins/vim-findroot') end }
  use { 'thinca/vim-quickrun',           setup = function() require('plugins/vim-quickrun') end,
    keys = {
      '<Plug>(quickrun)'
    },
    cmd = { 'QuickRun' }
  }

  use { 'thinca/vim-qfreplace',
    cmd = { 'Qfreplace' }
  }

  use { 'tyru/open-browser.vim',        setup = function() require('plugins/open-browser') end }
  use { 'tyru/open-browser-github.vim',
    requires = {
      'tyru/open-browser.vim'
    }
  }

  use { 'tyru/capture.vim',
    cmd = { 'Capture' },
    requires = {
      { 'thinca/vim-prettyprint',
        cmd = {
          'PP',
          'PrettyPrint'
        }
      }
    }
  }

  -- use { 'mhartington/formatter.nvim' }
  use { 'kyazdani42/nvim-web-devicons', setup  = function() require('plugins/nvim-web-devicons') end }
  use { 'norcalli/nvim-colorizer.lua',  config = function() require'colorizer'.setup()           end }
  use { 'dstein64/nvim-scrollview',     config = function() require('plugins/scrollview')        end }
  use { 'monaqa/dial.nvim',             setup  = function() require('plugins/dial_nvim')         end }
  use { 'glepnir/prodoc.nvim',
    cmd = {
      'ProDoc'
    }
  }

  --------------------
  -- git
  --------------------
  use { 'knsh14/vim-github-link',
    cmd = {
      'GetCommitLink',
      'GetCurrentBranchLink',
      'GetCurrentCommitLink',
    }
  }
  use { 'gisphm/vim-gitignore' }
  use { 'tpope/vim-fugitive', setup = function() require('plugins/vim-fugitive') end, }
  use { 'tpope/vim-dispatch', }
  use { 'gotchane/vim-git-commit-prefix', config = function() require('plugins/vim-git-commit-prefix') end }
  use { 'lewis6991/gitsigns.nvim', config = function() require('plugins/gitsigns') end }

  --------------------
  -- colorscheme
  --------------------
  use {'sainnhe/gruvbox-material'}

  --------------------
  -- operator
  --------------------
  use { 'kana/vim-operator-user', setup = function() require('plugins/vim-operator-user') end }
  use { 'kana/vim-operator-replace',
    requires = {
      'kana/vim-operator-user'
    },
  }

  --------------------
  -- darkpower
  --------------------
  use { 'Shougo/deol.nvim', setup = function() require('plugins/deol_nvim') end }
  use { 'Shougo/neosnippet.vim', setup = function() require('plugins/neosnippet') end,
    event = 'InsertEnter'
  }
  use { 'Shougo/neosnippet-snippets',
    requires = {
      'Shougo/neosnippet.vim',
    },
    after = 'neosnippet.vim'
  }

  --------------------
  -- nvim lua
  --------------------
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lua/plenary.nvim' }

  --------------------
  -- LSP
  --------------------
  use { 'neovim/nvim-lspconfig', config = function() require('plugins/nvim-lspconfig') end,
    requires = {
      { '~/.ghq/github.com/glepnir/lspsaga.nvim', config = function() require('plugins/lspsaga_nvim') end },
      { 'h-michael/lsp-ext.nvim' },
    }
  }

  --------------------
  -- telescope
  --------------------
  use { 'nvim-lua/telescope.nvim', setup = function() require('plugins/telescope_nvim') end,
    requires = {
      { 'nvim-telescope/telescope-ghq.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim' },
      {
        'nvim-telescope/telescope-frecency.nvim', requires = { 'tami5/sql.nvim' } },
      { 'tamago324/telescope-sonictemplate.nvim' },
      { 'tamago324/telescope-openbrowser.nvim' },
    }
  }

  --------------------
  -- treesitter
  --------------------
  use { 'nvim-treesitter/nvim-treesitter', config = function() require('plugins/nvim-treesitter') end,
    requires = {
      { 'nvim-treesitter/playground' },
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'nvim-treesitter/nvim-treesitter-refactor' },
    }
  }

  --------------------
  -- nvim-compe
  --------------------
  use { 'hrsh7th/nvim-compe', config = function() require('plugins/nvim-compe') end,
    requires = {
      'lexima.vim',
    }
  }
  use { 'tamago324/compe-zsh',
    requires = {
      'nvim-compe',
    },
  }
  use { 'tamago324/compe-necosyntax',
    requires = {
      'Shougo/neco-syntax',
      'nvim-compe',
    }
  }
  use { '~/.ghq/github.com/tamago324/compe-neosnippet',
    retuires = {
      'neosnippet.vim',
      'nvim-compe',
    }
  }

  --------------------
  -- lua
  use { 'tjdevries/nlua.nvim' }
  use { 'Koihik/vscode-lua-format', opt = true } -- binary のため
  use { 'teal-language/vim-teal' }
  -- use { 'euclidianAce/BetterLua.vim' }

  --------------------
  -- c
  use { 'vim-jp/vim-cpp' }
  use { 'Shougo/neoinclude.vim' }

  --------------------
  -- vim
  use { 'machakann/vim-Verdin' }

  --------------------
  -- AHK
  use { 'linxinhong/Vim-AHK' }

  --------------------
  -- Rust
  use { 'rust-lang/rust.vim' }


  --------------------
  -- Local
  use { '~/.ghq/github.com/tamago324/lir.nvim', config = function() require'plugins/lir_nvim' end,
    requires = 'nvim-web-devicons',
  }
  use { '~/.ghq/github.com/tamago324/lir-mmv.nvim' }
  use { '~/.ghq/github.com/tamago324/lir-bookmark.nvim' }
  use { '~/.ghq/github.com/tamago324/lir-mark.nvim' }

  use_rocks 'penlight'
end


return setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end
})
