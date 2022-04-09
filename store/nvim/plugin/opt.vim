" disable builtin plugins
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_gzip = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_logipat = 1
let g:loaded_rrhelper = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_matchit = 1

set nocompatible

" faster scrolling
set ttyfast

" automatically write files when multiple files are changed
set autowrite

" no line wrapping
set nowrap

" 80 char column
set colorcolumn=80

" no automatic folding
set foldmethod=manual
set nofoldenable

" sensible split positions
set splitbelow splitright

" maximum number of items to show in the popup menu
set pumheight=10

" height of command-line
set cmdheight=1

" save stuff to system clipboard
set clipboard+=unnamedplus

set smarttab

" replace tabs with spaces
set expandtab

" 4 char tab
set tabstop=4 softtabstop=4
set shiftwidth=4

set textwidth=72

" copy indent from current line when starting a new line
set autoindent

" searching
set ignorecase smartcase
set incsearch hlsearch

" avoid most of the 'Hit Enter ...' messages
set shortmess=aoOtTI

" no backup, no swaps = cleaner
set nobackup
set nowritebackup
set noswapfile

set laststatus=0

" stop complaints about switching buffer with changes
set hidden

" center the cursor while scrolling
set scrolloff=8

set updatetime=100
set timeoutlen=500

" no cluttering
set signcolumn=no

" faster escapes
set ttimeout
set ttimeoutlen=0

" persistent undo
set undodir=/tmp/.undodir_vim
set undofile

" ruler format
set ruf=%60(%=%#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

set background=light

" stop vim from silently messing with files that it shouldn't
set nofixendofline

" better ascii friendly listchars
set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>

" disable automatic folding
set foldmethod=manual
set nofoldenable
