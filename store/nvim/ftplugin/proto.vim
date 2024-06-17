set expandtab tabstop=2 softtabstop=2 shiftwidth=2

" fun <SID>FormatProto()
"     let l:save = winsaveview()
"     silent %!buf format
"     call winrestview(l:save)
" endfun

" if executable("buf")
"     BufWritePre *.proto :call <SID>FormatProto()
" endif
