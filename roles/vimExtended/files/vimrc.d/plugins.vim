call plug#begin('~/.vim/bundle')

" surround with parentheses, braces, ...
Plug 'tpope/vim-surround'

" repeat advanced plugin commands with .
Plug 'tpope/vim-repeat'

" Automatically insert closing parentheses, brackets, etc.
Plug 'jiangmiao/auto-pairs'

" Allow movement integration with tmux
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_disable_when_zoomed = 1

" klen/python-mode
" scrooloose/syntastic

" Prevent annoying popup at start of vim
" To use this the easiest way is to use bear (in order to generate compile_commands.json)
if executable('node') || executable('ccls')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = [ 'coc-vimtex' ]
else
    if v:vim_did_enter
        echohl Error | echom 'node or ccls not in path. For vim highlighting please add node to path.' | echohl None
    else
        autocmd VimEnter *.cpp,*.h echohl Error | echom 'node or ccls not in path. For vim highlighting please add node to path.' | echohl None
    endif
endif

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_modules = ['ctags', 'cscope']
let g:gutentags_project_root = ['.git', '.root']
let g:gutentags_cache_dir = expand('~/.cache/tags') " Here the databases are created so the project dir is not polluted
let g:gutentags_define_advanced_commands = 1 " Enable debugging via :GutentagsToggleTrace
let g:gutentags_cscope_build_inverted_index = 1

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_current_file = 1
" Remap <c-p> as this is already used by buffer change
let g:ctrlp_map = '<c-e>'
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

call plug#end()
