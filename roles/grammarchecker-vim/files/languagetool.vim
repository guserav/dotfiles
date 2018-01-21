" This file adds the languageTool to vim for easier gramar checking
Plug 'dpelle/vim-LanguageTool'

" Set path to languageTool
let g:languagetool_jar='$HOME/.vim/plugin/languagetool/LanguageTool-4.0/languagetool-commandline.jar'

" Mapping for LanguageTool
nnoremap <leader>lc :LanguageToolCheck<cr>	" Check with the current set Language in spelllang default en_us
nnoremap <leader>lno :LanguageToolClear<cr>	" Clear Highlighting of LanguageTool
