" disable builtins
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

" line numbering
set nu rnu

" no line wrapping
set nowrap

" 80 char column
set colorcolumn=80

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

" copy indent from current line when starting a new line
set autoindent

" searching
set ignorecase smartcase
set incsearch hlsearch

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

filetype plugin indent on

if has("syntax")
    syntax enable
endif

set background=light

" persistent undo
if has("nvim")
    set undodir=/tmp/.undodir_nvim
else
    set undodir=/tmp/.undodir_vim
endif

set undofile

if has('nvim')
    augroup highlight_yank
        autocmd!
        autocmd TextYankPost * silent! lua require("vim.highlight").on_yank({timeout = 80})
    augroup end
endif

" strip trailing whitespaces on save
function! <SID>StripTrailingWhitespaces()
    if !&binary && &filetype != 'diff'
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endif
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" format go code
function! Gofmt()
    let l:save = winsaveview()
    %!gofmt 2>/dev/null
    call winrestview(l:save)
endfunction

augroup ftgo
    autocmd!
    autocmd filetype go nnoremap <leader>f :call Gofmt()<CR>
    autocmd filetype go set noexpandtab
augroup end

augroup ftmd
    autocmd!
    autocmd filetype markdown set textwidth=72
    autocmd filetype markdown set spell!
augroup end

" toggle quickfix list's visibility
function! QuickFix_toggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor

    copen
endfunction

autocmd BufWritePost *Xresources !xrdb %

" mappings
nnoremap <Space> <NOP>
let g:mapleader=' '

" keep Y behaviour consistent with C and D
nnoremap Y y$

" moving text
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv

" window resize
nnoremap <silent> <C-Up> :resize -2<CR>
nnoremap <silent> <C-Down> :resize +2<CR>
nnoremap <silent> <C-Left> :vertical resize -2<CR>
nnoremap <silent> <C-Right> :vertical resize +2<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" buffer switching
nnoremap <silent> <leader>n :bnext<CR>
nnoremap <silent> <leader>p :bprev<CR>

" keep jumping
nnoremap <silent> { :keepjumps normal! {<CR>
nnoremap <silent> } :keepjumps normal! }<CR>

" undo break point
inoremap <silent> , ,<C-g>U
inoremap <silent> . .<C-g>U
inoremap <silent> ! !<C-g>U
inoremap <silent> ? ?<C-g>U

" quickfix list navigation
nnoremap <silent> <C-j> :cnext<CR>
nnoremap <silent> <C-k> :cprev<CR>
nnoremap <silent> <C-q> :call QuickFix_toggle()<CR>

" location list navigation
nnoremap <silent> <leader>j :lnext<CR>
nnoremap <silent> <leader>k :lprev<CR>
nnoremap <silent> <leader>q :lopen<CR>

" keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv

" FZF
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g> :Rg<CR>

if has("nvim")
    let plug = "~/.local/share/nvim/site/autoload/plug.vim"
else
    let plug = "~/.vim/autoload/plug.vim"
endif

" only load plugins if Plug detected
if filereadable(expand(plug))
    call plug#begin('~/.local/share/vim/plugins')
        " if nvim, load nvim specific plugins
        if has("nvim")
            Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
            Plug 'neovim/nvim-lspconfig'

            " completion
            Plug 'hrsh7th/nvim-cmp'
            Plug 'hrsh7th/cmp-nvim-lsp'
            Plug 'hrsh7th/cmp-vsnip'
            Plug 'hrsh7th/cmp-buffer'
            Plug 'hrsh7th/cmp-path'

            " snippets
            Plug 'hrsh7th/vim-vsnip'
            Plug 'rafamadriz/friendly-snippets'

            Plug 'kyazdani42/nvim-web-devicons'
            Plug 'norcalli/nvim-colorizer.lua', { 'for': ['html', 'css', 'vim', 'yaml'] }
        endif

        Plug 'junegunn/fzf.vim'
        Plug 'tpope/vim-surround'
        Plug 'tpope/vim-commentary'
        Plug 'jiangmiao/auto-pairs'
        Plug 'mattn/emmet-vim', { 'for': 'html' }
    call plug#end()

    let g:user_emmet_leader_key='<C-Z>'

    let g:fzf_history_dir = '~/.local/share/fzf-history'
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
    let g:fzf_colors = {
        \ 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Normal'],
        \ 'hl':      ['fg', 'Comment'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'border':  ['fg', 'Ignore'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment'] }

    if has("nvim")
        autocmd FileType html,css,vim,yaml :ColorizerAttachToBuffer

        luafile ~/.config/nvim/lua/treesitter.lua
        luafile ~/.config/nvim/lua/lsp.lua
        luafile ~/.config/nvim/lua/completion.lua
        luafile ~/.config/nvim/lua/vsnip.lua
        luafile ~/.config/nvim/lua/statusline/init.lua
    endif
endif
