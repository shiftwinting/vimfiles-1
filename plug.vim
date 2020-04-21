scriptencoding utf-8


function! s:plug(require, name, ...) abort
    " min かつ 必須ではない場合、読み込まない
    let l:opts = get(a:, 1, {})
    let l:if = has_key(l:opts, 'if') ? eval(l:opts.if) : 1
    if (a:require || !g:min_vimrc) && l:if
        Plug a:name, l:opts
    endif
endfunction

" <bang>0 って書くと、0 or 1 で渡せる (vim-plug からもらった)
command! -bang -nargs=+ MyPlug call <SID>plug(<bang>0, <args>)




call plug#begin('~/vimfiles/plugged')


" いつでも使うやつには ! をつける

MyPlug! 'junegunn/vim-plug'
MyPlug! 'vim-jp/vimdoc-ja'
MyPlug! 'vim-jp/vital.vim'
MyPlug! 'vim-jp/syntax-vim-ex'

" MyPlug  'mg979/vim-visual-multi'
" MyPlug  'tweekmonster/helpful.vim'
MyPlug! 'andymass/vim-matchup'
MyPlug  'ap/vim-css-color'
MyPlug! 'dense-analysis/ale'
MyPlug! 'dhruvasagar/vim-table-mode'
" MyPlug  'majutsushi/tagbar'
MyPlug  'mattn/gist-vim'
MyPlug  'mattn/webapi-vim'
MyPlug  'previm/previm'
MyPlug! 'rbtnn/vim-coloredit'
MyPlug  'simnalamburt/vim-mundo'
MyPlug  'skanehira/translate.vim'
" MyPlug  'skywind3000/vim-quickui'
MyPlug! 'Yggdroot/indentLine'
MyPlug! 'dbeniamine/todo.txt-vim'
MyPlug! 'deris/vim-shot-f'
MyPlug! 'glidenote/memolist.vim'
MyPlug! 'haya14busa/vim-asterisk'
MyPlug! 'jiangmiao/auto-pairs'
MyPlug! 'junegunn/vim-easy-align'
MyPlug! 'kana/vim-repeat'
MyPlug! 'kana/vim-tabpagecd'
MyPlug! 'ludovicchabant/vim-gutentags'
MyPlug! 'machakann/vim-highlightedyank'
MyPlug! 'markonm/traces.vim'
MyPlug! 'mattn/emmet-vim'
MyPlug! 'mattn/sonictemplate-vim'
MyPlug! 'mechatroner/rainbow_csv'
MyPlug! 'rbtnn/vim-mrw'
MyPlug! 'rcmdnk/yankround.vim'
MyPlug! 'simeji/winresizer'
MyPlug! 'svermeulen/vim-cutlass'
MyPlug! 't9md/vim-quickhl'
MyPlug! 'tamago324/vim-browsersync'
MyPlug! 'thinca/vim-qfreplace'
MyPlug! 'thinca/vim-quickrun'
MyPlug! 'tomtom/tcomment_vim'
MyPlug! 'tpope/vim-endwise'
" MyPlug! 'tpope/vim-surround'
MyPlug! 'machakann/vim-sandwich'
MyPlug! 'tyru/capture.vim'
MyPlug! 'tyru/open-browser-github.vim'
MyPlug! 'tyru/open-browser.vim'
MyPlug! 'tyru/vim-altercmd'
" MyPlug! 'machakann/vim-highlightedundo'
" MyPlug! 'tyru/columnskip.vim'

" --------------------------
" python
" --------------------------
MyPlug! 'vim-python/python-syntax'
MyPlug! 'petobens/poet-v'
" MyPlug! 'davidhalter/jedi-vim'
" JediUseEnvironment のため
MyPlug! 'blueyed/jedi-vim', { 'branch': 'envs' }
" MyPlug! 'relastle/vim-nayvy'
" MyPlug! 'kiteco/vim-plugin'
" MyPlug! 'heavenshell/vim-pydocstring', { 'if': executable('doq') }
MyPlug  'wookayin/vim-autoimport'

" --------------------------
" php
" --------------------------
MyPlug 'jwalton512/vim-blade'

" --------------------------
" nim
" --------------------------
MyPlug 'zah/nim.vim'

" --------------------------
" frontend
" --------------------------
MyPlug  'AndrewRadev/tagalong.vim'
MyPlug! 'hail2u/vim-css3-syntax'
MyPlug  'jason0x43/vim-js-indent'
MyPlug  'leafOfTree/vim-vue-plugin'
MyPlug! 'othree/html5.vim'
MyPlug  'prettier/vim-prettier', { 'do': 'yarn install' }
MyPlug  'yuezk/vim-js'

" --------------------------
" markdown
" --------------------------
MyPlug! 'dkarter/bullets.vim'

" --------------------------
" syntax
" --------------------------
MyPlug  'delphinus/vim-firestore'
MyPlug  'k-takata/vim-dosbatch-indent'

" --------------------------
" snippets
" --------------------------
MyPlug! 'Shougo/neosnippet.vim'
MyPlug! 'Shougo/neosnippet-snippets'
MyPlug! 'honza/vim-snippets'

" --------------------------
" complete
" --------------------------
MyPlug! 'Shougo/neco-syntax'
MyPlug! 'Shougo/echodoc.vim'

" --------------------------
" complete vim
" --------------------------
MyPlug! 'machakann/vim-Verdin'

" --------------------------
" go
" --------------------------
MyPlug  'fatih/vim-go'

" " --------------------------
" " textobj
" " --------------------------
" MyPlug! 'kana/vim-textobj-user'
" MyPlug! 'osyo-manga/vim-textobj-multiblock'
" MyPlug! 'kana/vim-textobj-function'
" MyPlug! 'haya14busa/vim-textobj-function-syntax'
" MyPlug! 'kana/vim-textobj-line'

" --------------------------
" operator
" --------------------------
MyPlug! 'kana/vim-operator-user'
MyPlug! 'kana/vim-operator-replace'

" --------------------------
" dark power
" --------------------------
MyPlug! 'Shougo/deol.nvim'
MyPlug  'Shougo/context_filetype.vim'

" --------------------------
" lightline
" --------------------------
MyPlug! 'itchyny/lightline.vim'

" --------------------------
" git
" --------------------------
MyPlug! 'airblade/vim-gitgutter'
MyPlug! 'tpope/vim-fugitive'
MyPlug! 'junegunn/gv.vim'
MyPlug! 'gisphm/vim-gitignore'
MyPlug! 'rhysd/conflict-marker.vim'
MyPlug! 'lambdalisue/gina.vim'

" --------------------------
" colorscheme
" --------------------------
MyPlug! 'lifepillar/vim-solarized8'
MyPlug! 'rakr/vim-one'
MyPlug! 'arcticicestudio/nord-vim'

" --------------------------
" LeaderF
" --------------------------
MyPlug! 'Yggdroot/LeaderF', { 'do': './install.bat' }
MyPlug! 'tamago324/LeaderF-cdnjs'
MyPlug! 'tamago324/LeaderF-bookmark'
MyPlug! 'tamago324/LeaderF-openbrowser'
MyPlug! 'tamago324/LeaderF-filer'

" --------------------------
" coc
" --------------------------
" MyPlug 'neoclide/coc.nvim', {'branch': 'release'}
" MyPlug 'neoclide/coc-neco'

" " lsp
" MyPlug  'prabirshrestha/async.vim'
" MyPlug  'prabirshrestha/vim-lsp'
" MyPlug  'mattn/vim-lsp-settings'

" Plug '~/ghq/github.com/tamago324/LeaderF'
" Plug '~/ghq/github.com/tamago324/LeaderF-filer'

call plug#end()
