" Section: Plugins {{{

set nocompatible
filetype off

" set leader to , (Comma)
let mapleader=","

" Vundle Plugin manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
Plugin 'VundleVim/Vundle.vim'

" LaTeXjk
" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-m>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" cp to copy to system-clipboard
" cP to copy line and cv to paste to next line
" REQUIRES apt-get install xsel
Plugin 'christoomey/vim-system-copy'

" surround with s
Plugin 'tpope/vim-surround'

" repeat plugin commands
Plugin 'tpope/vim-repeat'

" Git plugin TODO not yet tested
" Plugin 'tpope/vim-fugitive'

" Python folding plugin
" Plugin 'tmhedberg/SimpylFold'

" Autocomplete plugin for all kinds of languages
" REQUIRES:
" sudo apt-get install build-essential cmake
" sudo apt-get install python-dev python3-dev
" Plugin 'Valloric/YouCompleteMe'

" Plugin for the powerline
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
let g:Powerline_symbols = 'fancy'

" File navigating plugin
Plugin 'scrooloose/nerdtree'
" close vim if only window left is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" toggle nerdtree with ctrl+n
map <C-n> :NERDTreeToggle<CR>
" Nerdtree file type highlighting
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

" Plugin for visualizing the vim undo tree
Plugin 'sjl/gundo.vim'
nnoremap <leader>u :GundoToggle<CR>

" Syntax checker
"Plugin 'scrooloose/syntastic'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" Python mode
Plugin 'klen/python-mode'
" don't show error window - just the msg in the status bar
let g:pymode_lint_cwindow = 0
" close doc window after completion is done
autocmd CompleteDone * pclose

" A class outline viewer
" REQUIRES sudo apt-get install exuberant-ctags
Plugin 'majutsushi/tagbar'
noremap <leader>t :TagbarOpenAutoClose<CR>
noremap <leader>T :TagbarToggle<CR>

" Automatically insert closing parentheses, brackets, etc.
Plugin 'jiangmiao/auto-pairs'

" Requirement for ghc-mod
Plugin 'Shougo/vimproc.vim'

" Move seamlessly between vim and tmux panes
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()

" }}}

" Section: OS-Specific {{{

" Windows {{{

" nnoremap <leader>cp "*p                     " paste from system clipboard
" nmap cv o<esc>0D"*p                           " paste from system clipboard
" vnoremap <leader>cy "*y                     " copy to system clipboard
" set backupdir=$HOME\_vim\backup\\
" set directory=$HOME\_vim\tmp\\

" }}}

" Linux {{{

" source .vimrc_linux
" paste with ,p<Enter>
" nnoremap <Leader>p :r !xsel -p

set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/tmp//

" }}}

" }}}

" Section: LaTeX {{{

" compile markdown & latex
autocmd FileType markdown nnoremap <leader>lc :w<Enter>:! pandoc -o %.pdf %<Enter><Enter>
autocmd FileType markdown nnoremap <leader>ll :w<Enter>:!(setsid<Space>pandoc<Space>-o<Space>%.pdf<Space><C-R>%<Space>&><space>/dev/null&)<Enter><Enter>
autocmd FileType markdown nnoremap <leader>ls :!<Space>setsid<Space>evince<Space><C-R>%.pdf<Space>&><Space>/dev/null<Space>&<Enter><Enter>
" compile latex
autocmd FileType tex nnoremap <leader>lc :w<Enter>:! pdflatex --shell-escape %<Enter>
autocmd FileType tex nnoremap <leader>ll :w<Enter>:!(setsid<Space>pdflatex<Space>--shell-escape<Space><C-R>%<Space>&><space>/dev/null&)<Enter><Enter>
autocmd FileType tex nnoremap <leader>ls :!<Space>setsid<Space>evince<Space><C-R>%<Backspace><Backspace><Backspace>pdf<Space>&><Space>/dev/null<Space>&<Enter><Enter>

" }}}

" Section: Experimental {{{


" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-Z> :ZoomToggle<CR>

set foldmethod=syntax
filetype plugin indent on                  " detect filetype specific indent, plugin, syntax...

set foldlevel=99
set foldlevelstart=99                       " open most folds by default

colorscheme torte
set laststatus=2                            " Always show statusline
set iskeyword-=_                            " add _ (underscore) as word delimiter (eg. when navigating)
autocmd BufEnter * lcd %:p:h                " Set working directory to the current file

au BufWinLeave * silent! mkview             " restore folds on load sadly throws errors
au BufWinEnter * silent! loadview           " maybe needs foldlevel or foldlevelstart

" }}}

" Section: Options {{{

set encoding=utf-8                          " force utf8 support
syntax on                                   " syntax highlighting
set t_Co=256                                " Use 256 colours
set mouse=a                                 " enable mouse (only for resizing splits)
set showmatch                               " highlight matching braces/parentheses/brackets
set cursorline                              " highlight current line
set modelines=1                             " last line of this file applies to just this file
set autoindent
set ruler                                   " show line and column number

set shiftwidth=2 tabstop=2 softtabstop=2    " sets default tab size to 2 spaces
autocmd Filetype css setlocal tabstop=4
autocmd Filetype python setlocal tabstop=4
autocmd Filetype markdown setlocal shiftwidth=4 tabstop=4 softtabstop=4
set expandtab                               " insert spaces when pressing tab

" move swapfiles somewhere else (directories decloared in OS specific
" Two path separators at the end to ensure file name uniqueness
" in the preserve directory (see the :help docs)
set swapfile
set backup

set relativenumber                          " show relative line numbers
set number                                  " but absolute of current line

set ignorecase                              " make search case insensitive
set smartcase                               " Case insensitive searches become sensitive with capitals
set lazyredraw                              " redraw only when we need to
set incsearch                               " search as characters are entered
set hlsearch                                " highlight matches

set splitbelow                              " new splits on the right and on the botttom
set splitright                              " more intutitive for LTR languages

set wildmenu                                " visual autocomplete for command menu
set wildmode=list:longest,full

set wrap                                    " wrap long lines
set linebreak                               " wrap lines only on characters in 'breakat'
" set breakat&vim                           " reset breakat to vims default
set whichwrap+=<,>,h,l,[,]                  " moving beyound edge moves to adjacent line
set backspace=indent,eol,start              " enable deleting newline from beginning of next line

" }}}

" Section: Remappings {{{

let mapleader=","                           " set leader to , (Comma)

nmap <silent> <leader>ev :e $MYVIMRC<cr>    " open .vimrc with <leader>ev
nmap <silent> <leader>sv :so $MYVIMRC<cr>   " open .vimrc with <leader>sv

nnoremap <silent> <leader><space> :nohlsearch<cr>    " turn off search highlight

nnoremap <leader>m `                        " jump to marker by pressing leader, m and the buffer
noremap gg mg<bar>gg                        " save position to marker g before jumping to beginning
noremap G mG<bar>G                          " save position to marker G before jumping to end

" move in split navigations with ^W prefix for tmux compatibility
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Support indenting multiple times in visual mode
vnoremap < <gv
vnoremap > >gv

" move in wrapped line as if they were separate
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj

nnoremap <space> za                         " toggle fold on spacebar

" }}}

" Section: To be revised {{{

""python with virtualenv support for code completion
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF
"
"" add powerline
"set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
"" highlight last inserted text
"nnoremap gV `[v`]
"
"" add this to ~/.vim/after/syntax/html.vim to enable proper folding for html
"" syntax region htmlFold start="<\z(\<\(area\|base\|br\|col\|command\|embed\|hr\|img\|input\|keygen\|link\|meta\|para\|source\|track\|wbr\>\)\@![a-z-]\+\>\)\%(\_s*\_[^/]\?>\|\_s\_[^>]*\_[^>/]>\)" end="</\z1\_s*>" fold transparent keepend extend containedin=htmlHead,htmlH\d
"
"
"" delete, change and paste without yanking
"nnoremap <leader>d "_d
"vnoremap <leader>d "_d
"
"nnoremap <leader>c "_c
"vnoremap <leader>c "_c
"
"nnoremap <leader>p "_dP
"vnoremap <leader>p "_dP

" }}}

" vim:foldmethod=marker
