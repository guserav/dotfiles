if exists('g:did_coc_loaded')
    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Close completion window on hitting enter
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use K to show documentation in preview window.
    " This is the indented behaviour of K
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
    endfunction

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Highlight the symbol and its references when holding the cursor.
    augroup coc_config
        autocmd!
        autocmd CursorHold * silent call CocActionAsync('highlight')
    augroup end
else
    echoerr "Coc didn't load"
endif
