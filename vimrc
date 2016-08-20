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

" colorscheme
colorscheme elflord

" indent based on filetype
filetype plugin indent on
set expandtab
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4
autocmd FileType haskell setlocal shiftwidth=2 tabstop=2

" syntax highlighting
syntax on

" split navigations
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" move in split line
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj

" delete linebreak at beginning of line with backspace
set backspace=indent,eol,start

" move left or right brings you to previous/next line
set whichwrap+=<,>,h,l,[,]

" map F1 to escape
map <F1> <Esc>
imap <F1> <Esc>

" break not on the last character a.k.a dont break up words
set nolist wrap linebreak breakat&vim

" show current line number but all others relative to that
set number
set relativenumber

" folding 99 deepr
set foldlevel=99
"fold on spacebar
nnoremap <space> za
" toggle all folds zi and custom fold zf
set foldmethod=syntax
" restore folds on load
autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview


" utf8 support
set encoding=utf-8

" support indenting multiple times
vnoremap < <gv
vnoremap > >gv

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" make search case insensitive
set ignorecase

"python with virtualenv support for code completion
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" paste with ,p<Enter>
" nnoremap <Leader>p :r !xsel -p

" add powerline
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours
set t_Co=256

" Let's make it easy to edit this file (mnemonic for the key sequence is
" 'e'dit 'v'imrc)
nmap <silent> ,ev :e $MYVIMRC<cr>
" And to source this file as well (mnemonic for the key sequence is
" 's'ource 'v'imrc)
nmap <silent> ,sv :so $MYVIMRC<cr>

" enable mouse
set mouse=a

" highlight matching braces/parentheses/brackets
set showmatch

" highlight current line
set cursorline

set lazyredraw          " redraw only when we need to
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

"" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" highlight last inserted text
nnoremap gV `[v`]

" add this to ~/.vim/after/syntax/html.vim to enable proper folding for html
" syntax region htmlFold start="<\z(\<\(area\|base\|br\|col\|command\|embed\|hr\|img\|input\|keygen\|link\|meta\|para\|source\|track\|wbr\>\)\@![a-z-]\+\>\)\%(\_s*\_[^/]\?>\|\_s\_[^>]*\_[^>/]>\)" end="</\z1\_s*>" fold transparent keepend extend containedin=htmlHead,htmlH\d

" new splits on the right and on the botttom - more intutitive for LTR languages
set splitbelow
set splitright

" jump to position by pressing leader and m and the buffer
nnoremap <leader>m `

" save position before jumping to beginning or end
nnoremap gg mg<bar>gg
nnoremap G mg<bar>G

" Set working directory to the current file
autocmd BufEnter * lcd %:p:h

" delete, change and paste without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

nnoremap <leader>c "_c
vnoremap <leader>c "_c

nnoremap <leader>p "_dP
vnoremap <leader>p "_dP
