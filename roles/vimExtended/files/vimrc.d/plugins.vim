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

" Better syntax highlighting
Plug 'sheerun/vim-polyglot'
" Conflicts with lervag/vimtex
let g:polyglot_disabled = ['latex']

" Very powerful code completion TODO after some usage go through configuration values
Plug 'ycm-core/YouCompleteMe'
let g:ycm_max_diagnostics_to_display = 0 " Infinite number of diagnostics to display
let g:ycm_autoclose_preview_window_after_insertion = 1
" YCM needs a .ycm_extra_conf.py in order to get the correct compile options.
" This tool helps generating this. :YcmGenerateConfig --help for more info.
" Probably :YcmGenerateConfig -bmake is the way to got especially when running
" with autoconf scripts. (Run normal build first so autoconf was called)
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_modules = ['ctags', 'cscope']
let g:gutentags_project_root = ['.git']
let g:gutentags_cache_dir = expand('~/.cache/tags') " Here the databases are created so the project dir is not polluted
let g:gutentags_define_advanced_commands = 1 " Enable debugging via :GutentagsToggleTrace
let g:gutentags_cscope_build_inverted_index = 1

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
