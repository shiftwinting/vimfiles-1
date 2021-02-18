scriptencoding utf-8

let g:plug_install_dir = expand('$MYVIMFILES/.plugged')

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" autocmd VimEnter *
" \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
" \|   PlugInstall --sync | q
" \| endif

packadd cfilter

call plug#begin(g:plug_install_dir)

Plug 'junegunn/vim-plug'

Plug 'vim-jp/vimdoc-ja'
Plug 'vim-jp/syntax-vim-ex'
" Plug 'vim-jp/vital.vim'
Plug 'rbtnn/vim-gloaded'

Plug 'andymass/vim-matchup'
Plug 'glidenote/memolist.vim'
Plug 'haya14busa/vim-asterisk', { 'on': ['<Plug>(asterisk-gz*)', '<Plug>(asterisk-z*)'] }
Plug 'cohama/lexima.vim'
Plug 'junegunn/vim-easy-align'
Plug 'markonm/traces.vim'
Plug 'simeji/winresizer'
Plug 'svermeulen/vim-cutlass'
Plug 'tomtom/tcomment_vim'
Plug 'voldikss/vim-translator', { 'on': ['TranslateW', 'TranslateR', 'Translate'] }
Plug 'ludovicchabant/vim-gutentags'
Plug 'dstein64/vim-startuptime', { 'on': 'StartupTime' }
Plug 'kana/vim-repeat'
Plug 'hrsh7th/vim-eft'
Plug 'machakann/vim-sandwich'
Plug 'machakann/vim-highlightedyank'
Plug 'mattn/sonictemplate-vim'
Plug 'mattn/vim-findroot'
" Plug 'lambdalisue/suda.vim'
" Plug 'lambdalisue/vim-protocol'
Plug 'lambdalisue/mr.vim'
Plug 'lambdalisue/mr-quickfix.vim', { 'on': ['Mru', 'Mrw'] }
" Plug 'lambdalisue/fin.vim'
Plug 'lambdalisue/edita.vim'

" Plug 'lambdalisue/vim-quickrun-neovim-job'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-qfreplace', { 'on': 'Qfreplace' }
Plug 'thinca/vim-prettyprint', { 'on': ['PP', 'PrettyPrint'] }

Plug 'tyru/capture.vim', { 'on': 'Capture' }
" Plug 'tyru/columnskip.vim'
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'
" Plug 'tyru/vim-altercmd'

" ------------------------
"  git
" ------------------------
" " gist
" Plug 'mattn/vim-gist'
" Plug 'mattn/webapi-vim'

" yank github link
Plug 'knsh14/vim-github-link', { 'on': ['GetCurrentCommitLink', 'GetCurrentBranchLink', 'GetCommitLink'] }

" sign
Plug 'lewis6991/gitsigns.nvim'

Plug 'gisphm/vim-gitignore'

" fugitive
Plug 'tpope/vim-fugitive',
" Plug 'junegunn/gv.vim'
Plug 'tpope/vim-dispatch'
" Plug 'skanehira/gh.vim'

" prefix complete
Plug 'gotchane/vim-git-commit-prefix'

Plug 'rhysd/git-messenger.vim'

" ------------------------
"  colorscheme
" ------------------------
" Plug 'tjdevries/colorbuddy.vim'

Plug 'sainnhe/gruvbox-material'
" Plug 'bkegley/gloombuddy'
" Plug 'Th3Whit3Wolf/spacebuddy'

" ------------------------
"  operator
" ------------------------
Plug 'kana/vim-operator-user',
Plug 'kana/vim-operator-replace'


" ------------------------
"  dark power
" ------------------------
Plug 'Shougo/deol.nvim', { 'on': ['Deol'] }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" Plug '~/.ghq/github.com/tamago324/neosnippet-snippets'
" Plug 'Shougo/deoppet.nvim'


" ------------------------
"  Neovim
" ------------------------
" Plug 'mattn/vim-lsp-settings'
" Plug '~/.ghq/github.com/mattn/vim-lsp-settings'
Plug 'neovim/nvim-lspconfig'
Plug 'h-michael/lsp-ext.nvim'
Plug 'hrsh7th/nvim-compe'
  Plug '~/.ghq/github.com/tamago324/compe-neosnippet'
  Plug '~/.ghq/github.com/tamago324/compe-zsh'
  " Plug '~/.ghq/github.com/tamago324/compe-necosyntax'
  " Plug 'Shougo/neco-syntax'
  " Plug 'hrsh7th/vim-vsnip'
Plug 'liuchengxu/vista.vim'
Plug 'nvim-lua/telescope.nvim'
  Plug 'nvim-telescope/telescope-ghq.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'tamago324/telescope-sonictemplate.nvim'
  Plug 'tamago324/telescope-openbrowser.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter'
  " Plug 'p00f/nvim-ts-rainbow'
  Plug 'nvim-treesitter/playground'
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'nvim-treesitter/nvim-treesitter-refactor'
  " Plug 'nvim-treesitter/nvim-tree-docs'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'dstein64/nvim-scrollview'
Plug 'monaqa/dial.nvim'
Plug 'bfredl/nvim-miniyank'
Plug 'glepnir/lspsaga.nvim'
Plug 'antoinemadec/FixCursorHold.nvim' " -> input() で改行が使えなくなる問題がある? -> そういうわけでもなかった
" Plug 'wbthomason/packer.nvim'
" Plug 'glepnir/prodoc.nvim'
" Plug 'jbyuki/monolithic.nvim'
Plug '~/.ghq/github.com/tamago324/emmylua-annot-nvim-api'
Plug 'onsails/lspkind-nvim'

Plug '~/.ghq/github.com/kosayoda/nvim-lightbulb'
" Plug 'gelguy/wilder.nvim'
" Plug 'dsummersl/nvim-sluice'
" Plug 'b3nj5m1n/kommentary'
  " Plug 'nvim-telescope/telescope-frecency.nvim' -> おそいから
  " Plug 'tami5/sql.nvim'
" Plug 'neovim/nvimdev.nvim',
"   Plug 'neomake/neomake'
"   Plug 'tpope/vim-projectionist'
" Plug 'norcalli/nvim_utils'
" Plug 'euclidianAce/BetterLua.vim'
" Plug 'mhartington/formatter.nvim'

" Plug 'jubnzv/virtual-types.nvim'
" Plug 'nvim-lua/lsp-status.nvim'
" Plug 'RishabhRD/nvim-lsputils'
" Plug 'RishabhRD/popfix'
" Plug 'nvim-lua/lsp_extensions.nvim'

" ------------------------
"  Languages
" ------------------------

" ------------------------
" Lua
" Plug 'tjdevries/nlua.nvim'
" Plug 'Koihik/vscode-lua-format'   " binary のため
" Plug 'teal-language/vim-teal'

" Plug 'bakpakin/fennel.vim'


" ------------------------
"  C
" Plug 'vim-jp/vim-cpp'
" Plug 'Shougo/neoinclude.vim'
" .c -> .c
" Plug 'vim-scripts/a.vim'

"------------------------
" Python
" Plug 'vim-python/python-syntax'


"------------------------
" Vim
Plug 'machakann/vim-Verdin', { 'for': 'vim' }


"------------------------
" AutoHotKey
" Plug 'linxinhong/Vim-AHK'


"------------------------
" ML
" Plug 'tamago324/vim-better-sml', {'branch': 'simple'}


"------------------------
" Rust
Plug 'rust-lang/rust.vim'
" Plug 'rhysd/rust-doc.vim'

"------------------------
" RON
Plug 'ron-rs/ron.vim'

"------------------------
" Markdown
" Plug 'plasticboy/vim-markdown'


" Plug '~/.ghq/github.com/tamago324/telescope-openbrowser.nvim'
Plug '~/.ghq/github.com/tamago324/lir.nvim'
Plug '~/.ghq/github.com/tamago324/lir-mmv.nvim'
Plug '~/.ghq/github.com/tamago324/lir-bookmark.nvim'
Plug '~/.ghq/github.com/tamago324/lir-mark.nvim'
" Plug 'tamago324/lir.nvim'
" Plug '~/.ghq/github.com/tamago324/lir-float.nvim'
" Plug '~/.ghq/github.com/tamago324/vim-browsersync'

call plug#end()


" Plug 'jiangmiao/auto-pairs'  -> cohama/lexima.vim

" ---> lightline.vim
" Plug 'tjdevries/express_line.nvim'
"   Plug 'nvim-lua/plenary.nvim'
"   Plug 'kyazdani42/nvim-web-devicons'

" Plug 'Xuyuanp/scrollbar.nvim'     " => うまく表示できなかった。。。

" -> nvim-compe
" Plug 'nvim-lua/completion-nvim'
"     Plug 'steelsojka/completion-buffers'
"     Plug 'kristijanhusak/completion-tags'
"     Plug 'Shougo/neopairs.vim'
"     " Plug 'nvim-treesitter/completion-treesitter'

" Plug 'Yggdroot/indentLine'

" Plug 'glepnir/indent-guides.nvim'

" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'kyazdani42/nvim-tree.lua'

" Plug 'mcchrish/nnn.vim'

" Plug 'lambdalisue/gina.vim'

" Plug 'svermeulen/vimpeccable'

" Plug 'Xuyuanp/scrollbar.nvim'

"  Plug 'Shougo/deoplete.nvim'
"    Plug 'Shougo/deoplete-zsh',
"    Plug 'deoplete-plugins/deoplete-tag',
"    Plug 'Shougo/neco-syntax',
"    Plug 'Shougo/neco-vim',

" Plug 'rafcamlet/nvim-luapad'
" Plug 'bfredl/nvim-luadev'
" Plug 'theHamsta/nvim_rocks'

" Plug 'cypok/vim-sml'
" Plug 'javier-lopez/sml.vim'

" Plug '~/.ghq/github.com/tamago324/vim-gaming-line'

" Plug 'Shougo/echodoc.vim',
" Plug 'Shougo/denite.nvim'
" Plug 'Shougo/defx.nvim'

" Plug 'tamago324/LeaderF-filer',


" Plug 'Shougo/junkfile.vim'

" Plug 'ryanoasis/vim-devicons'
" Plug 'rbtnn/vim-coloredit'
" Plug 'cocopon/colorswatch.vim'

" Plug 'chrisbra/vim-autosave' " only vim?

" Plug 'lambdalisue/fern.vim'
" Plug 'lambdalisue/fern-renderer-nerdfont.vim'
" Plug 'lambdalisue/fern-bookmark.vim'
" Plug 'lambdalisue/glyph-palette.vim'
" Plug 'lambdalisue/nerdfont.vim'
" Plug 'antoinemadec/FixCursorHold.nvim'  " Neovim 用 CursorHold のパフォーマンス改善

" Plug 'itchyny/lightline.vim'

" Plug 'tsuyoshicho/vim-fg'
" Plug 'mtth/scratch.vim'
" Plug 'bfrg/vim-qf-preview'
" Plug 'romainl/vim-qf'

" Plug 'tyru/eskk.vim'

" ============
" colorscheme
" ============
" Plug 'cocopon/iceberg.vim'
" Plug 'koron/vim-monochromenote'
" Plug 'jsit/toast.vim'
" Plug 'rakr/vim-one'
" Plug 'zefei/cake16'
" Plug 'fabi1cazenave/kalahari.vim'
" Plug 'yasukotelin/shirotelin'
" Plug 'mhartington/oceanic-next'
" Plug 'rigellute/shades-of-purple.vim'
" Plug 'drewtempelmeyer/palenight.vim'
" Plug 'adrian5/oceanic-next-vim'
" Plug 'lifepillar/vim-gruvbox8'
" Plug 'sainnhe/edge'
" Plug 'arcticicestudio/nord-vim'
" Plug 'habamax/vim-gruvbit'

" Plug 'hrsh7th/vim-vsnip-integ'

" Plug '~/.ghq/github.com/shoumodip/ido.nvim'
" Plug 'kevinhwang91/nvim-hlslens'
" Plug 'pwntester/octo.nvim'

" ------------------------
"  LeaderF
" ------------------------
" Plug 'Yggdroot/LeaderF',
" Plug 'tamago324/LeaderF-openbrowser',
" Plug 'tamago324/LeaderF-neosnippet',
" Plug 'tamago324/LeaderF-packadd',
" Plug 'tamago324/LeaderF-sonictemplate',
" Plug '~/.ghq/github.com/tamago324/LeaderF-filer',


" Plug 'mhinz/vim-grepper'  -> telescope
" Plug 'delphinus/vim-auto-cursorline'
" Plug 'y0za/vim-reading-vimrc'
" Plug 'machakann/vim-swap'

" Plug 'rcmdnk/yankround.vim' -> nvim-miniyank
