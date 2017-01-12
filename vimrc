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
set hidden
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

" Navigation
" setup homerow navigation for windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-t> :tabnext<CR>

nmap j gj
nmap k gk

" --- Plugins Start
call plug#begin('~/.vim/plugged')
Plug 'gmarik/Vundle.vim'
Plug 'derekwyatt/vim-scala'
Plug 'derekwyatt/vim-sbt'
Plug 'stephpy/vim-yaml'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'saltstack/salt-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'xoria256.vim'
Plug 'burnttoast256'
call plug#end() 
" --- Plugins End

syntax enable 
filetype indent plugin on     " required

" Color settings
set t_Co=256
set background=dark
colorscheme xoria256 
highlight ColorColumn ctermbg=DarkGrey guibg=DarkGrey

" Airline settings
" install patched gnome-termianl fonts for powerline symbols
let g:airline_powerline_fonts=1
let g:airline_theme='papercolor'

" Nerdtree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

nnoremap <Leader>n :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
