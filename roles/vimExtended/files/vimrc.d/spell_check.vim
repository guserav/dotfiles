" Spell checking
" set spellcapcheck  "[.?!]\_[\])'" \t]\+")                    " checks if the first word of the sentence is big
" set spell language to English by default
" As spell is local to a window and spelllang is local to a buffer they have
" to be set on creating every buffer. BufCreate didn't seem to work so I
" choose BufRead as this should cover every creating of a buffer from an
" existing file. The creation of a new empty buffer is not covered.
" press ,no to disable when in buffer
nnoremap <leader>de :setlocal spell spelllang=de<cr>:set spellcapcheck<cr>      " add Spellcheck for German
nnoremap <leader>en :setlocal spell spelllang=en<cr>:set spellcapcheck<cr>      " add Spellcheck for English
nnoremap <leader>no :set nospell<cr>                                            " remove spellchecking

augroup SpellCheck
    au!
    autocmd BufRead * setlocal spell spelllang=en
    " Change Spellcheck highlighting to be visible on every console
    "hi! link SpellBad ErrorMsg
    "hi! link SpellCap Search
    autocmd ColorScheme * highlight SpellBad term=reverse ctermbg=224 gui=undercurl guisp=Red
    autocmd ColorScheme * highlight SpellCap ctermbg=Red
augroup END
