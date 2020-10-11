scriptencoding utf-8

let g:plug_install_dir = expand('$MYVIMFILES/plugged')

call plug#begin(g:plug_install_dir)


Plug 'junegunn/vim-plug'
Plug 'vim-jp/vimdoc-ja'
Plug 'vim-jp/vital.vim'
Plug 'vim-jp/syntax-vim-ex'
Plug 'Yggdroot/indentLine'
Plug 'chrisbra/NrrwRgn'
Plug 'dense-analysis/ale'
Plug 'dhruvasagar/vim-table-mode'
Plug 'glidenote/memolist.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-repeat'
Plug 'ludovicchabant/vim-gutentags'
Plug 'machakann/vim-highlightedyank'
Plug 'machakann/vim-sandwich'
Plug 'mattn/sonictemplate-vim'
Plug 'rcmdnk/yankround.vim'
Plug 'simeji/winresizer'
Plug 'voldikss/vim-translator'
Plug 'svermeulen/vim-cutlass'
Plug 'thinca/vim-qfreplace'
Plug 'thinca/vim-quickrun'
Plug 'tomtom/tcomment_vim'
Plug 'tyru/capture.vim'
Plug 'tyru/open-browser-github.vim'
Plug 'tyru/open-browser.vim'
Plug 'andymass/vim-matchup'
Plug 'ap/vim-css-color'
Plug 'sillybun/vim-repl'              " 使いやすいように最高になった
Plug 'markonm/traces.vim'             " 可視化しなくても良い気がするから
Plug 'liuchengxu/graphviz.vim'        " Graphviz 用
Plug 'hrsh7th/vim-eft'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'rbtnn/vim-gloaded'
Plug 'y0za/vim-reading-vimrc'
Plug 'google/vim-searchindex'       " 検索結果の個数を表示
Plug 'tyru/columnskip.vim'
Plug 'iamcco/markdown-preview.nvim' " markdown プレビュー
Plug 'dstein64/vim-startuptime'
Plug 'tyru/eskk.vim'
Plug 'mattn/vim-molder'
Plug 'mattn/vim-molder-operations'
Plug 'lambdalisue/vim-protocol'
Plug 'luochen1990/rainbow'
" Plug 'delphinus/vim-auto-cursorline'

" --------------------------
" python
" --------------------------
Plug 'vim-python/python-syntax', {'for': ['python']}
" Plug 'petobens/poet-v'  " 起動時間遅くなるし、あまり使わないから
" Plug 'davidhalter/jedi-vim', {'for': ['python']}
" JediUseEnvironment のため
" Plug 'blueyed/jedi-vim', { 'branch': 'envs' } " poet-v 使わないから
" Plug 'relastle/vim-nayvy'
" Plug 'kiteco/vim-plugin'      " 挙動がおかしいから
" Plug 'wookayin/vim-autoimport'    " 使いどきわからん
" Plug 'glench/vim-jinja2-syntax'
" Plug 'heavenshell/vim-pydocstring'

" --------------------------
" markdown
" --------------------------
Plug 'dkarter/bullets.vim', {'for': ['md', 'markdown']}

" --------------------------
" clang
" --------------------------
Plug 'vim-jp/vim-cpp'
Plug 'Shougo/neoinclude.vim'
" .c -> .h
Plug 'vim-scripts/a.vim'

" --------------------------
" syntax
" --------------------------
" Plug 'delphinus/vim-firestore'
" Plug 'k-takata/vim-dosbatch-indent'

" --------------------------
" snippets
" --------------------------
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'

" --------------------------
" complete vim
" --------------------------
Plug 'machakann/vim-Verdin'

" --------------------------
" lisp
" --------------------------
" Plug 'kovisoft/slimv'
" Plug 'jpalardy/vim-slime'
" Plug 'wlangstroth/vim-racket'
Plug 'mnacamura/vim-r7rs-syntax'    " Gauche の syntax highlight
" Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}    " うまく動かないため
" Plug 'bhurlow/vim-parinfer'
Plug 'kovisoft/paredit'

" --------------------------
" haskell
" --------------------------
Plug 'itchyny/vim-haskell-indent'

" --------------------------
" sml
" --------------------------
Plug 'jez/vim-better-sml'

" --------------------------
" operator
" --------------------------
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
Plug 'tyru/operator-camelize.vim'

" --------------------------
" dark power
" --------------------------
Plug 'Shougo/deol.nvim'
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
Plug 'Shougo/echodoc.vim'


" --------------------------
" lightline
" --------------------------
Plug 'itchyny/lightline.vim'

" --------------------------
" git
" --------------------------
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" Plug 'junegunn/gv.vim'
Plug 'gisphm/vim-gitignore'
" Plug 'rhysd/conflict-marker.vim'
" Plug 'lambdalisue/gina.vim'
Plug 'tpope/vim-dispatch'
" Plug 'mhinz/vim-signify'

" --------------------------
" colorscheme
" --------------------------
" Plug 'lifepillar/vim-solarized8'
" Plug 'rakr/vim-one'
Plug 'arcticicestudio/nord-vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'jacoborus/tender.vim'
Plug 'sainnhe/gruvbox-material'

" --------------------------
" LeaderF
" --------------------------
Plug 'Yggdroot/LeaderF', { 'do': './install.bat' }
" Plug 'tamago324/LeaderF-cdnjs'
    Plug 'tamago324/LeaderF-bookmark'
    Plug 'tamago324/LeaderF-openbrowser'
    " Plug 'tamago324/LeaderF-filer'    " -> fern
    Plug 'tamago324/LeaderF-neosnippet'
    Plug 'tamago324/LeaderF-packadd'
    Plug 'tamago324/LeaderF-sonictemplate'
    Plug 'bennyyip/LeaderF-ghq'

" --------------------------
" deoplete ちょっとおそい -> asyncomplete -> WSL では最強では？！
" --------------------------
Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
Plug 'lighttiger2505/deoplete-vim-lsp'
" Plug 'deoplete-plugins/deoplete-tag'
Plug 'Shougo/deoplete-zsh'
Plug 'Shougo/neopairs.vim'

" --------------------------
" lsp
" --------------------------
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

Plug 'liuchengxu/vista.vim'

" Plug 'lambdalisue/fern.vim'
" Plug 'lambdalisue/fern-renderer-nerdfont.vim'
" Plug 'lambdalisue/fern-hijack.vim'
" Plug 'lambdalisue/fern-comparator-lexical.vim'
" Plug 'lambdalisue/fern-renderer-devicons.vim'

" " --------------------------
" " asyncomplete いい感じ 
" "  -> 日本語売った後にポップアップが出ちゃうのが微妙だけど
" "  -> 関数を保管した後のカッコがなんかいやだ ( だけ補完される
" " --------------------------
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-necosyntax.vim'
" Plug 'prabirshrestha/asyncomplete-necovim.vim'
" " Plug 'yami-beta/asyncomplete-omni.vim'
" Plug 'prabirshrestha/asyncomplete-buffer.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'thomasfaingnaert/vim-lsp-neosnippet'

" " complete
" " Plug 'lifepillar/vim-mucomplete'
" Plug 'ycm-core/YouCompleteMe'
" Plug 'ycm-core/lsp-examples'

" " --------------------------
" " coc  チカチカするからやだ -> asyncomplete 
" " --------------------------
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc-neco'

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


" Plug 'lambdalisue/fin.vim'
" Plug 'tyru/restart.vim'

" Plug 'ryanoasis/vim-devicons'
" Plug 'hardcoreplayers/spaceline.vim'

" Plug 'dbeniamine/todo.txt-vim'        " 家だと使わないから
" Plug 'kana/vim-tabpagecd'
" Plug 'lambdalisue/vim-backslash'
" Plug 'liuchengxu/vim-which-key'
" Plug 'machakann/vim-highlightedundo'
" Plug 'majutsushi/tagbar'              " -> Vista
" Plug 'mattn/gist-vim'
" Plug 'mechatroner/rainbow_csv'        " CSV 見ないから
" Plug 'mg979/vim-visual-multi'
" Plug 'rbtnn/vim-coloredit'
" Plug 'rbtnn/vim-mrw'
" Plug 'romainl/vim-cool'               " 他の検索系のプラグインと相性が悪い
" Plug 'simnalamburt/vim-mundo'         " そこまで使わないから
" Plug 'skywind3000/vim-quickui'        " -> LeaderF
" Plug 't9md/vim-quickhl'
" Plug 'tpope/vim-endwise'              " -> neosnippet
" Plug 'tpope/vim-surround'             " -> sandwich
" Plug 'tweekmonster/helpful.vim'
" Plug 'tyru/vim-altercmd'
" Plug 'skanehira/translate.vim'        " -> voldikss/vim-translator
" Plug 'JMcKiern/vim-venter'            " ウィンドウを真ん中に表示

" --------------------------
" completor
" --------------------------
" Plug 'maralla/completor.vim'
" Plug 'maralla/completor-neosnippet'
" Plug 'kyouryuukunn/completor-necosyntax'
" Plug 'tamago324/completor-necosyntax'       " fork したやつ
" Plug '~/ghq/github.com/kyouryuukunn/completor-necosyntax'
" Plug 'kyouryuukunn/completor-necovim'
" Plug '~/ghq/github.com/kyouryuukunn/completor-necovim'

" --------------------------
" db
" --------------------------
" Plug 'tpope/vim-dadbod'
" Plug 'kristijanhusak/vim-dadbod-ui'
" Plug 'kristijanhusak/vim-dadbod-completion'

" --------------------------
" sql
" --------------------------
" Plug 'mattn/vim-sqlfmt'

" --------------------------
" go
" --------------------------
" Plug 'fatih/vim-go'


" Plug 'deris/vim-shot-f'               " -> rhysd/clever-f.vim -> vim-eft
" Plug 'rhysd/clever-f.vim'             " -> deris/vim-shot-f -> vim-eft
" Plug 'jpalardy/vim-slime'
" Plug 'mattn/webapi-vim'
" Plug 'previm/previm'
" Plug 'terryma/vim-expand-region'      " 使いたい！ってときがあまりない
" Plug 'puremourning/vimspector'
" Plug 'AndrewRadev/switch.vim'

" --------------------------
" php
" --------------------------
" Plug 'jwalton512/vim-blade'

" --------------------------
" nim
" --------------------------
" Plug 'zah/nim.vim'

" --------------------------
" frontend
" --------------------------
" Plug 'AndrewRadev/tagalong.vim'
" Plug 'hail2u/vim-css3-syntax'
" Plug 'jason0x43/vim-js-indent'
" Plug 'leafOfTree/vim-vue-plugin'
" Plug 'othree/html5.vim'
" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" Plug 'yuezk/vim-js'
" Plug 'mattn/emmet-vim'
" Plug 'tamago324/vim-browsersync'  " 使わない

call plug#end()
