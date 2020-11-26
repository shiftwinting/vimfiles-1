scriptencoding utf-8

let g:plug_install_dir = expand('$MYVIMFILES/plugged')


call plug#begin(g:plug_install_dir)

Plug 'junegunn/vim-plug'

Plug 'vim-jp/vimdoc-ja'
Plug 'vim-jp/syntax-vim-ex'
Plug 'vim-jp/vital.vim'
Plug 'rbtnn/vim-gloaded'

Plug 'andymass/vim-matchup'
Plug 'glidenote/memolist.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'itchyny/lightline.vim'
Plug 'cohama/lexima.vim'
Plug 'junegunn/vim-easy-align'
if !has('nvim')
    Plug 'markonm/traces.vim'
endif
Plug 'simeji/winresizer'
Plug 'svermeulen/vim-cutlass'
Plug 'tomtom/tcomment_vim'
Plug 'voldikss/vim-translator'
Plug 'Yggdroot/indentLine'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mhinz/vim-grepper'
Plug 'mtth/scratch.vim'

Plug 'kana/vim-repeat'

Plug 'hrsh7th/vim-eft'

Plug 'machakann/vim-sandwich'
Plug 'machakann/vim-highlightedyank'

Plug 'rcmdnk/yankround.vim'

Plug 'mattn/sonictemplate-vim'

Plug 'lambdalisue/suda.vim'
Plug 'lambdalisue/vim-protocol'
Plug 'lambdalisue/mr.vim'
Plug 'lambdalisue/mr-quickfix.vim'
" Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/glyph-palette.vim'
" Plug 'lambdalisue/nerdfont.vim'

Plug 'lambdalisue/vim-quickrun-neovim-job'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-qfreplace'
Plug 'thinca/vim-prettyprint'

Plug 'tyru/capture.vim'
Plug 'tyru/columnskip.vim'
Plug 'tyru/eskk.vim'
Plug 'tyru/open-browser.vim'
    Plug 'tyru/open-browser-github.vim'

" Plug 'mcchrish/nnn.vim'

" ------------------------
"  git
" ------------------------
" gist
Plug 'mattn/vim-gist'
    Plug 'mattn/webapi-vim'

" yank github link
Plug 'knsh14/vim-github-link'

" sign
Plug 'lewis6991/gitsigns.nvim'
  Plug 'nvim-lua/plenary.nvim'

Plug 'gisphm/vim-gitignore'

" fugitive
Plug 'tpope/vim-fugitive',
    Plug 'junegunn/gv.vim'
    Plug 'tpope/vim-dispatch'

" Plug 'lambdalisue/gina.vim'

" ------------------------
"  colorscheme
" ------------------------
Plug 'sainnhe/gruvbox-material'
Plug 'cocopon/iceberg.vim'
Plug 'koron/vim-monochromenote'
Plug 'jsit/toast.vim'
Plug 'rakr/vim-one'
Plug 'zefei/cake16'
Plug 'fabi1cazenave/kalahari.vim'
Plug 'yasukotelin/shirotelin'
Plug 'mhartington/oceanic-next'
Plug 'rigellute/shades-of-purple.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'adrian5/oceanic-next-vim'
Plug 'lifepillar/vim-gruvbox8'

" ------------------------
"  operator
" ------------------------
Plug 'kana/vim-operator-user',
    Plug 'kana/vim-operator-replace'

" ------------------------
"  LeaderF
" ------------------------
Plug 'Yggdroot/LeaderF',
  Plug 'tamago324/LeaderF-openbrowser',
  Plug 'tamago324/LeaderF-neosnippet',
  Plug 'tamago324/LeaderF-packadd',
  Plug 'tamago324/LeaderF-sonictemplate',
  " Plug 'tamago324/LeaderF-filer',


" ------------------------
"  dark power
" ------------------------
"  Plug 'Shougo/deoplete.nvim'
"    Plug 'Shougo/deoplete-zsh',
"    Plug 'deoplete-plugins/deoplete-tag',
"    Plug 'Shougo/neco-syntax',
"    Plug 'Shougo/neco-vim',
Plug 'Shougo/echodoc.vim',
" Plug 'Shougo/denite.nvim'
" Plug 'Shougo/defx.nvim'


" deol
Plug 'Shougo/deol.nvim'

" snippet
" Plug 'Shougo/deoppet.nvim'
Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'

" ------------------------
"  Neovim
" ------------------------
" Plug 'neovim/nvimdev.nvim',
"   Plug 'neomake/neomake'
"   Plug 'tpope/vim-projectionist'
Plug 'svermeulen/vimpeccable'
Plug 'norcalli/nvim_utils'

Plug 'euclidianAce/BetterLua.vim'

Plug 'neovim/nvim-lspconfig'
    Plug 'jubnzv/virtual-types.nvim'
Plug 'nvim-lua/completion-nvim'
    Plug 'steelsojka/completion-buffers'
    Plug 'kristijanhusak/completion-tags'
    Plug 'Shougo/neopairs.vim'
    Plug 'nvim-treesitter/completion-treesitter'

Plug 'liuchengxu/vista.vim'

Plug 'nvim-lua/telescope.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    " Plug 'kyazdani42/nvim-web-devicons'
    Plug '/home/tamago324/.ghq/github.com/kyazdani42/nvim-web-devicons'

Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'p00f/nvim-ts-rainbow'

" Plug 'glepnir/indent-guides.nvim'

" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'kyazdani42/nvim-tree.lua'

Plug 'norcalli/nvim-colorizer.lua'


" ------------------------
"  Languages
" ------------------------

" Lua
Plug 'tjdevries/nlua.nvim'
Plug 'rafcamlet/nvim-luapad'
Plug 'bfredl/nvim-luadev'
" Plug 'theHamsta/nvim_rocks'

Plug 'bakpakin/fennel.vim'


" ------------------------
"  C
Plug 'vim-jp/vim-cpp'
Plug 'Shougo/neoinclude.vim'
" .c -> .c
" Plug 'vim-scripts/a.vim'

"------------------------
" Python
" Plug 'vim-python/python-syntax'


"------------------------
" Vim
Plug 'machakann/vim-Verdin'

call plug#end()


" Plug 'jiangmiao/auto-pairs'  -> cohama/lexima.vim


" ---> lightline.vim
" Plug 'tjdevries/express_line.nvim'
"   Plug 'nvim-lua/plenary.nvim'
"   Plug 'kyazdani42/nvim-web-devicons'
