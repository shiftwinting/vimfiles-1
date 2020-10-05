scriptencoding utf-8

" C:\Vim\vim82\syntax\sqlanywhere.vim のまね

" TODO: sqlStatement じゃないやつもあるから、ちゃんとやること

" 集合関数
syn keyword sqlStatement except EXCEPT
" ウィンドウ関数
syn keyword sqlStatement over partition preceding following OVER PARTITION PRECEDING FOLLOWING
" ウィンドウ専用関数
syn keyword sqlStatement row_number ROW_NUMBER

" GROUPING 演算子
syn keyword sqlStatement rollup cube ROLLUP CUBE

syn keyword sqlStatement transaction TRANSACTION isolation ISOLATION READ COMMITTED read committed
