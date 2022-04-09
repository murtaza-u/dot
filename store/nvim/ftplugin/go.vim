set noexpandtab
set sw=4 tabstop=4 softtabstop=4

if executable("gofmt")
    au BufWritePost *.go silent !gofmt -w %
endif

nnoremap <leader>s :%!gomodifytags -file % --add-tags json -struct
