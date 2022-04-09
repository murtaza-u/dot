" fix bork bash detection
fun! s:DetectBash()
    if getline(1) == '#!/usr/bin/bash' || getline(1) == '#!/bin/bash'
        set ft=bash
    elseif getline(1) == '#!/bin/sh'
        set ft=sh
    endif
endfun
autocmd BufNewFile,BufRead * call s:DetectBash()

" start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" toggle quickfix list's visibility
fun QuickFix_toggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor

    copen
endfun
nnoremap <silent> <C-q> :call QuickFix_toggle()<CR>

" strip trailing whitespaces on save
fun <SID>StripTrailingWhitespaces()
    if !&binary && &filetype != 'diff'
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endif
endfun
au BufWritePre * :call <SID>StripTrailingWhitespaces()

" update X server resource database on save
au BufWritePost *Xresources !xrdb %

augroup highlight_yank
    au!
    au TextYankPost * silent! lua require("vim.highlight").on_yank({timeout = 80})
augroup end

" displays all the syntax rules for current position, useful when
" writing vimscript syntax plugins
if has("syntax")
    function! <SID>SynStack()
        if !exists("*synstack")
            return
        endif
        echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endfunc

    nnoremap <leader>h :call <SID>SynStack()<CR>
endif
