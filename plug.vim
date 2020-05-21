scriptencoding utf-8


call plug#begin('~/vimfiles/plugged')


Plug 'junegunn/vim-plug'
Plug 'vim-jp/vimdoc-ja'
Plug 'vim-jp/vital.vim'
Plug 'vim-jp/syntax-vim-ex'

" Plug 'mg979/vim-visual-multi'
" Plug 'tweekmonster/helpful.vim'
Plug 'andymass/vim-matchup'
Plug 'ap/vim-css-color'
Plug 'dense-analysis/ale'
Plug 'dhruvasagar/vim-table-mode'
" Plug 'majutsushi/tagbar'
" Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'previm/previm'
" Plug 'rbtnn/vim-coloredit'
Plug 'simnalamburt/vim-mundo'
Plug 'skanehira/translate.vim'
" Plug 'skywind3000/vim-quickui'
Plug 'Yggdroot/indentLine'
Plug 'dbeniamine/todo.txt-vim'
Plug 'deris/vim-shot-f'
Plug 'glidenote/memolist.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-repeat'
Plug 'kana/vim-tabpagecd'
Plug 'ludovicchabant/vim-gutentags'
Plug 'machakann/vim-highlightedyank'
" Plug 'markonm/traces.vim'
Plug 'mattn/sonictemplate-vim'
Plug 'mechatroner/rainbow_csv'
" Plug 'rbtnn/vim-mrw'
Plug 'rcmdnk/yankround.vim'
Plug 'simeji/winresizer'
Plug 'svermeulen/vim-cutlass'
" Plug 't9md/vim-quickhl'
" Plug 'tamago324/vim-browsersync'
Plug 'thinca/vim-qfreplace'
Plug 'thinca/vim-quickrun'
Plug 'tomtom/tcomment_vim'
" Plug 'tpope/vim-endwise'
" Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'
Plug 'tyru/capture.vim'
" Plug 'tyru/open-browser-github.vim'
Plug 'tyru/open-browser.vim'
" Plug 'tyru/vim-altercmd'
" Plug 'machakann/vim-highlightedundo'
" Plug 'tyru/columnskip.vim'
Plug 'sillybun/vim-repl'
Plug 'chrisbra/NrrwRgn'
" Plug 'romainl/vim-cool'
Plug 'lambdalisue/vim-backslash'
Plug 'liuchengxu/vim-which-key'


" --------------------------
" db
" --------------------------
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'

" --------------------------
" python
" --------------------------
Plug 'vim-python/python-syntax'
Plug 'petobens/poet-v'
" Plug 'davidhalter/jedi-vim'
" JediUseEnvironment のため
Plug 'blueyed/jedi-vim', { 'branch': 'envs' }
" Plug 'relastle/vim-nayvy'
" Plug 'kiteco/vim-plugin'
" Plug 'heavenshell/vim-pydocstring', { 'if': executable('doq') }
Plug 'wookayin/vim-autoimport'
Plug 'glench/vim-jinja2-syntax'

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
" sql
" --------------------------
Plug 'mattn/vim-sqlfmt'


" --------------------------
" textobj
" --------------------------
Plug 'kana/vim-textobj-user'
Plug 'osyo-manga/vim-textobj-multiblock'
Plug 'kana/vim-textobj-function'
Plug 'haya14busa/vim-textobj-function-syntax'
Plug 'kana/vim-textobj-line'
Plug 'michaeljsmith/vim-indent-object'

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
Plug 'lambdalisue/gina.vim'

" --------------------------
" colorscheme
" --------------------------
Plug 'lifepillar/vim-solarized8'
Plug 'rakr/vim-one'
Plug 'arcticicestudio/nord-vim'

" --------------------------
" LeaderF
" --------------------------
Plug 'Yggdroot/LeaderF', { 'do': './install.bat' }
Plug 'tamago324/LeaderF-cdnjs'
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
" asyncomplete
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

" Plug '~/ghq/github.com/kristijanhusak/vim-dadbod-completion'
" Plug '~/ghq/github.com/kristijanhusak/vim-dadbod-ui'
" Plug '~/ghq/github.com/prabirshrestha/asyncomplete.vim'
" Plug '~/ghq/github.com/yami-beta/asyncomplete-omni.vim'


call plug#end()


" いつでも使うやつには ! をつける
" function! s:plug(require, name, ...) abort
"     " min かつ 必須ではない場合、読み込まない
"     let l:opts = get(a:, 1, {})
"     let l:if = has_key(l:opts, 'if') ? eval(l:opts.if) : 1
"     if (a:require || !g:min_vimrc) && l:if
"         Plug a:name, l:opts
"     endif
" endfunction
"
" " <bang>0 って書くと、0 or 1 で渡せる (vim-plug からもらった)
" command! -bang -nargs=+ MyPlug call <SID>plug(<bang>0, <args>)

packadd! vim-which-key
