set nocompatible              " be iMproved, required

set shell=/bin/zsh
set encoding=utf-8
set modeline
set modelines=1

set guicursor=a:blinkon0
set number
set cursorline
set colorcolumn=80
set history=1000
set showmode
set showcmd
set wildmenu
set wildmode=list:longest
set wildignorecase
set smartcase
set ignorecase
set nolist

" Indentation
set linebreak
set nowrap
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Swapfiles and Fileload
set autoread
set noswapfile
set nobackup
set nowb

syntax on

" Leader and Esc
let mapleader = "\<Space>"
inoremap jk <Esc>
nnoremap ; :

" --- Navigation Start
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-t> :tabnext<CR>

" Move normally between wrapped lines
nmap j gj
nmap k gk

" Buffer navigation
set hidden
nmap <Leader>T :enew<CR>
nmap <Leader>l :bnext<CR>
nmap <Leader>h :bprevious<CR>
nmap <Leader>bl :ls<CR>
" --- Navigation End

" Useful shortcuts
command! Wd :write|bdelete

" --- Plugins Start
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'mhinz/vim-startify'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'stephpy/vim-yaml'
" Colors
Plug 'vim-scripts/xoria256.vim'
call plug#end()
" --- Plugins End

syntax enable
filetype indent plugin on     " required

autocmd BufReadPre,FileReadPre *.md :set wrap

" Resize splits when resizing window
autocmd VimResized * wincmd = 

" --- Color settings
set t_ut=
set t_Co=256
set background=dark
colorscheme xoria256 
" after the colorscheme to change the colorscheme default
highlight ColorColumn ctermbg=DarkGrey guibg=DarkGrey       

" Airline settings
" install patched gnome-termianl fonts for powerline symbols
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='papercolor'

" Nerdtree settings
autocmd StdinReadPre * let s:std_in=1
" Disable NERDTree here, instead i will use startify
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

nnoremap <Leader>n :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" Might be some kind of important, don't you think?
"let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
