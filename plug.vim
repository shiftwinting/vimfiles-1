scriptencoding utf-8


call plug#begin('~/vimfiles/plugged')


Plug 'junegunn/vim-plug'
Plug 'vim-jp/vimdoc-ja'
Plug 'vim-jp/vital.vim'
Plug 'vim-jp/syntax-vim-ex'

Plug 'Yggdroot/indentLine'
Plug 'chrisbra/NrrwRgn'
Plug 'dense-analysis/ale'
Plug 'deris/vim-shot-f'
Plug 'dhruvasagar/vim-table-mode'
Plug 'glidenote/memolist.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'jiangmiao/auto-pairs'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-repeat'
Plug 'ludovicchabant/vim-gutentags'
Plug 'machakann/vim-highlightedyank'
Plug 'machakann/vim-sandwich'
Plug 'mattn/sonictemplate-vim'
Plug 'mattn/webapi-vim'
Plug 'previm/previm'
Plug 'rcmdnk/yankround.vim'
Plug 'simeji/winresizer'
Plug 'skanehira/translate.vim'
Plug 'svermeulen/vim-cutlass'
Plug 'thinca/vim-qfreplace'
Plug 'thinca/vim-quickrun'
Plug 'tomtom/tcomment_vim'
Plug 'tyru/capture.vim'
Plug 'tyru/open-browser-github.vim'
Plug 'tyru/open-browser.vim'

" Plug 'andymass/vim-matchup'
" Plug 'ap/vim-css-color'
" Plug 'dbeniamine/todo.txt-vim'        " 家だと使わないから
" Plug 'kana/vim-tabpagecd'
" Plug 'lambdalisue/vim-backslash'      " たまにおかしくなるから
" Plug 'liuchengxu/vim-which-key'       " 定義がめんどくさい & でてくるのなんかやだ
" Plug 'machakann/vim-highlightedundo'  " 毎回光るのやだ
" Plug 'majutsushi/tagbar'              " -> LeaderF
" Plug 'markonm/traces.vim'             " 可視化しなくても良い気がするから
" Plug 'mattn/gist-vim'     
" Plug 'mechatroner/rainbow_csv'        " CSV 見ないから
" Plug 'mg979/vim-visual-multi'
" Plug 'rbtnn/vim-coloredit'            " そこまで使わないから
" Plug 'rbtnn/vim-mrw'                  " ん～～って感じ
" Plug 'romainl/vim-cool'               " 他の検索系のプラグインと相性が悪い
" Plug 'sillybun/vim-repl'              " なんか微妙
" Plug 'simnalamburt/vim-mundo'         " そこまで使わないから
" Plug 'skywind3000/vim-quickui'        " LeaderF でいいやって感じ
" Plug 't9md/vim-quickhl'               " それほど使わない
" Plug 'tpope/vim-endwise'              " -> neosnippet
" Plug 'tpope/vim-surround'             " -> sandwich
" Plug 'tweekmonster/helpful.vim'
" Plug 'tyru/columnskip.vim'            " イマイチ使い方がわからない
" Plug 'tyru/vim-altercmd'

" --------------------------
" db
" --------------------------
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'

" --------------------------
" sql
" --------------------------
Plug 'mattn/vim-sqlfmt'

" --------------------------
" python
" --------------------------
Plug 'vim-python/python-syntax'
" Plug 'petobens/poet-v'  " 起動時間遅くなるし、あまり使わないから
Plug 'davidhalter/jedi-vim'    " JediUseEnvironment のため
" Plug 'blueyed/jedi-vim', { 'branch': 'envs' } " poet-v 使わないから
" Plug 'relastle/vim-nayvy'
" Plug 'kiteco/vim-plugin'      " 挙動がおかしいから
" Plug 'heavenshell/vim-pydocstring', { 'if': executable('doq') }
" Plug 'wookayin/vim-autoimport'    " 使いどきわからん
" Plug 'glench/vim-jinja2-syntax'

" --------------------------
" php
" --------------------------
Plug 'jwalton512/vim-blade'

" --------------------------
" nim
" --------------------------
Plug 'zah/nim.vim'

" --------------------------
" frontend
" --------------------------
Plug 'AndrewRadev/tagalong.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'jason0x43/vim-js-indent'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'othree/html5.vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'yuezk/vim-js'
Plug 'mattn/emmet-vim'
" Plug 'tamago324/vim-browsersync'  " 使わない

" --------------------------
" markdown
" --------------------------
Plug 'dkarter/bullets.vim'

" --------------------------
" syntax
" --------------------------
Plug 'delphinus/vim-firestore'
Plug 'k-takata/vim-dosbatch-indent'

" --------------------------
" snippets
" --------------------------
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

" --------------------------
" complete
" --------------------------
Plug 'Shougo/echodoc.vim'

" --------------------------
" complete vim
" --------------------------
" Plug 'machakann/vim-Verdin'

" --------------------------
" go
" --------------------------
Plug 'fatih/vim-go'

" --------------------------
" lisp
" --------------------------
Plug 'kovisoft/slimv'
" Plug 'jpalardy/vim-slime'
Plug 'wlangstroth/vim-racket'


" TODO: 使いこなしたい
" " --------------------------
" " textobj
" " --------------------------
" Plug 'kana/vim-textobj-user'
" Plug 'osyo-manga/vim-textobj-multiblock'
" Plug 'kana/vim-textobj-function'
" Plug 'haya14busa/vim-textobj-function-syntax'
" Plug 'kana/vim-textobj-line'
" Plug 'michaeljsmith/vim-indent-object'

" --------------------------
" operator
" --------------------------
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'

" --------------------------
" dark power
" --------------------------
Plug 'Shougo/deol.nvim'
" Plug 'Shougo/context_filetype.vim'

" --------------------------
" lightline
" --------------------------
Plug 'itchyny/lightline.vim'

" --------------------------
" git
" --------------------------
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'gisphm/vim-gitignore'
Plug 'rhysd/conflict-marker.vim'
" Plug 'lambdalisue/gina.vim'

" --------------------------
" colorscheme
" --------------------------
" Plug 'lifepillar/vim-solarized8'
" Plug 'rakr/vim-one'
Plug 'arcticicestudio/nord-vim'

" --------------------------
" LeaderF
" --------------------------
Plug 'Yggdroot/LeaderF', { 'do': './install.bat' }
" Plug 'tamago324/LeaderF-cdnjs'
Plug 'tamago324/LeaderF-bookmark'
Plug 'tamago324/LeaderF-openbrowser'
Plug 'tamago324/LeaderF-filer'

" --------------------------
" coc  チカチカするからやだ -> asyncomplete 
" --------------------------
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc-neco'

" " --------------------------
" " deoplete ちょっとおそい -> asyncomplete
" " --------------------------
" Plug 'Shougo/deoplete.nvim'
" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'

" --------------------------
" asyncomplete いい感じ 
"  -> 日本語売った後にポップアップが出ちゃうのが微妙だけど
"  -> 関数を保管した後のカッコがなんかいやだ ( だけ補完される
" --------------------------
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-necosyntax.vim'
Plug 'prabirshrestha/asyncomplete-necovim.vim'
Plug 'yami-beta/asyncomplete-omni.vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'

" " --------------------------
" " lsp
" " --------------------------
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'

call plug#end()
