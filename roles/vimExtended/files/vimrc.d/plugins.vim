call plug#begin('~/.vim/bundle')

" Do less when opening large files
Plug 'vim-scripts/LargeFile'

" surround with parentheses, braces, ...
Plug 'tpope/vim-surround'

" repeat advanced plugin commands with .
Plug 'tpope/vim-repeat'

" Automatically insert closing parentheses, brackets, etc.
Plug 'jiangmiao/auto-pairs'

" Open buffers at same location they left of at
Plug 'guserav/vim-lastplace'

" Allow movement integration with tmux
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_disable_when_zoomed = 1

" klen/python-mode
" scrooloose/syntastic

" Prevent annoying popup at start of vim
" To use this the easiest way is to use bear (in order to generate compile_commands.json)
if executable('node') || executable('ccls')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = [ 'coc-vimtex', 'coc-ultisnips', 'coc-snippets', 'coc-python' ]
    " Use <C-j> for jump to next placeholder, it's default of coc.nvim
    let g:coc_snippet_next = '<c-j>'
    " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    let g:coc_snippet_prev = '<c-k>'

else
    call EchoNoLoadPrompt('Error', 'node or ccls not in path. For vim highlighting please add node to path.')
endif

if has('python3') " ultisnips needs python3 support. And without it it will generate an error on every button press
    " Add engine for snippets
    Plug 'SirVer/ultisnips'
    let g:UltiSnipsSnippetDirectories=["UltiSnips", "my-snippets"]
    " Snippets for ultisnips
    Plug 'honza/vim-snippets'"
else
    call EchoNoLoadPrompt('Error', "vim has no python3 support. Can\'t use ultisnips")
endif

Plug 'ludovicchabant/vim-gutentags'
"let g:gutentags_modules = ['ctags', 'cscope']
let g:gutentags_modules = ['ctags']
let g:gutentags_project_root = ['.git', '.root']
let g:gutentags_cache_dir = expand('~/.cache/tags') " Here the databases are created so the project dir is not polluted
let g:gutentags_define_advanced_commands = 1 " Enable debugging via :GutentagsToggleTrace
"let g:gutentags_cscope_build_inverted_index = 1

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_current_file = 1
" Remap <c-p> as this is already used by buffer change
let g:ctrlp_map = '<c-f>'
nnoremap <c-s> :CtrlPBuffer<cr>

Plug 'guserav/ShowMarks'
let g:showmarks_textlower = ""
let g:showmarks_textuper = ""
let g:showmarks_textother = ""

" Tagbar for class and function outline
Plug 'majutsushi/tagbar'

" Have a custom statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1

" show git diff +, -, ~ at the left edge
Plug 'airblade/vim-gitgutter'

" Latex syntax highlighting and completion
Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'

" Syntax highlighting for Powershell
Plug 'pprovost/vim-ps1'

Plug 'dpelle/vim-LanguageTool'
let g:languagetool_jar='$HOME/.vim/plugin/languagetool/LanguageTool-5.0/languagetool-commandline.jar'
nnoremap <leader>lc :LanguageToolCheck<cr>      " Check with the current set Language in spelllang default en_us
nnoremap <leader>lno :LanguageToolClear<cr>     " Clear Highlighting of LanguageTool

call plug#end()
