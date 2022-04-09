" map leader key to <space>
let g:mapleader=' '

" keep Y behaviour consistent with C and D
nnoremap Y y$

" moving text
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv

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

" keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv

" disable search highlighting with <C-L>
nnoremap <silent> <C-L> :nohl<CR><C-L>

" toggle line numbers
nnoremap <silent> <leader>d :set nu! rnu!<CR>
