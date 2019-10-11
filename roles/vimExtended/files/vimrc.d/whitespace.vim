
" Match syntax groups for trailing whitespace and tabs in the file
function! AddMatches()
    try
        call matchadd("EvilTabs", '\t', 10, 8910)
    catch 'E801'
    endtry
    try
        call matchadd("ExtraWhitespace", '\s\+\%#\@<!$', 10, 8911)
    catch 'E801'
    endtry
endfunction

function! DeleteMatches()
    try
        call matchdelete(8910)
    catch 'E803'
    endtry
    try
        call matchdelete(8911)
    catch 'E803'
    endtry
endfunction

augroup Whitespace
    au!
    " highlight the custom groups
    autocmd ColorScheme * highlight EvilTabs ctermbg=red guibg=red
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    " Has to be called in every window as matches are window specific
    autocmd WinNew * call AddMatches()
    " WinNew is not triggered for the first window
    autocmd VimEnter * call AddMatches()
    " Don't highlight tabs in the help window
    autocmd FileType help call DeleteMatches()
augroup END
