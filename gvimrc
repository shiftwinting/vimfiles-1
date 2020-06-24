scriptencoding utf-8
" > GUI版のVimでだけ意味を持つオプションがある。'guicursor'、'guifont'、'guipty'、
" > 'guioptions' である。それらは他の全てのオプションと共に|options.txt|で説明され
" > ている。
" 以下のオプションのみ、gvimrc で設定する？
" 'guicursor', 'guifont', 'guipty', 'guioptions'

" GUIメニュー {{{

" メニューの非表示(上のファイル(F)とか)
set guioptions-=m

" タブをCUIにする
set guioptions-=e

" ツールバーの非表示
set guioptions-=T

" 右のスクロールバーを非表示にする
set guioptions-=r

" 左のスクロールバーを非表示にする
set guioptions-=L

" 外部コマンドを端末ウィンドウで表示
set guioptions+=!

" }}}

" フォント設定
" cXX -> 文字セットを SHIFTJIS とする?
set guifont=Cica:h11.5:cSHIFTJIS

" カーソルを点滅させない
" a: すべてのモード
" blinkon0 点滅を止める
set guicursor=a:blinkon0

" colorscheme my_shirotelin
" colorscheme solarized
" set background=light

" 起動時のサイズ指定
set columns=180
set lines=999

" タイトルを非表示
set notitle
