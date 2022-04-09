if executable("gofmt")
    au BufWritePost *.rs silent !rustfmt %
endif
