scriptencoding utf-8


" =====================
" カーソル下の highlight 情報を取得 (name のみ) 
" =====================
command! SyntaxInfo call GetSynInfo()

" http://cohama.hateblo.jp/entry/2013/08/11/020849
function! s:get_syn_id(transparent) abort
  " synID() で 構文ID が取得できる
  " XXX: 構文ID
  "       synIDattr() と synIDtrans() に渡すことで"構文情報"を取得できる
  " trans に1を渡しているため、実際に表示されている文字が評価対象
  let synid = synID(line('.'), col('.'), 1)
  if a:transparent
    " ハイライトグループにリンクされた構文IDが取得できる
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction

function! s:get_syn_attr(synid) abort
  let name = synIDattr(a:synid, 'name')
  return { 'name': name }
endfunction

function! GetSynInfo() abort
  let base_syn = s:get_syn_attr(s:get_syn_id(0))
  echo 'name: ' . base_syn.name

  " 1 を渡すとリンク先が取得できる
  let linked_syn = s:get_syn_attr(s:get_syn_id(1))
  echo 'link to'
  echo 'name: ' . linked_syn.name
endfunction
