nnoremap <silent> <leader>hc :call ClearAllHighlightWord()<cr>
nnoremap <silent> <leader>1 :call HighlightWord(1)<cr>
nnoremap <silent> <leader>2 :call HighlightWord(2)<cr>
nnoremap <silent> <leader>3 :call HighlightWord(3)<cr>
nnoremap <silent> <leader>4 :call HighlightWord(4)<cr>
nnoremap <silent> <leader>5 :call HighlightWord(5)<cr>

function! HighlightWord(n)
    let mid = 7890 + a:n
    try
        call matchdelete(mid) " When match exists just delete it
    catch 'E803' " When matchid does not exist yet it will be toggled on
        " Match only complete word under the cursor
        let pat = '\V\<' . expand('<cword>') . '\>'
        call matchadd("WordHighlight" . a:n, pat, 10, mid)
    endtry
endfunction

function! ClearAllHighlightWord()
    for i in range(1,5)
        silent! call matchdelete(7890 + i)
    endfor
endfunction

" When setting the background the colorscheme gets relouded and thus these
" values have to reset FIXME: Move that to own color scheme
augroup Highlighting
    au!
    autocmd ColorScheme * hi def WordHighlight1 ctermbg=2
    autocmd ColorScheme * hi def WordHighlight2 ctermbg=6
    autocmd ColorScheme * hi def WordHighlight3 ctermbg=12
    autocmd ColorScheme * hi def WordHighlight4 ctermbg=9
    autocmd ColorScheme * hi def WordHighlight5 ctermbg=13
    " Plugin specific
    autocmd ColorScheme * highlight link TagbarHighlight Special
augroup END
