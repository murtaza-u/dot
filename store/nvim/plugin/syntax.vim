filetype plugin indent on

if has("syntax")
    syntax enable
endif

" enables 24-bit RGB color in the TUI
if has('termguicolors')
    set termguicolors
endif

" mark trailing spaces
match IncSearch '\s\+$'
