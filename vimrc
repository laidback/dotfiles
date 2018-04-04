set nocompatible            " be iMproved, required

" General settings
set shell=/bin/zsh          " Default shell
set encoding=utf-8          " Default file encoding
set fileformat=unix         " Default file format (line endings)
set modeline                " Use files modeline for vim settings
set modelines=1             " Number of lines to check for set commands
set mouse=a

" Vim basic look and feel
"set guicursor=a:blinkon0    " Gui cursor look and feel
set number                  " Show line numbers
set ruler
set cursorline              " Show visible Cursorline
set colorcolumn=80          " Show visible ColorColumn
set history=1000            " Set vim history size
set noshowmode              " Show current vim mode (Insert, Replace, Visual) Airline
set showcmd                 " Show command in the last line of the screen
set wildmenu                " Enhanced completion capabilities
set wildmode=longest:list   " Complete longest string, then list alternatives
set wildignorecase          " Ignore case when searching completion
set smartcase               " Only ignore case when all letters are lowercase
set ignorecase              " Ignore case in search
set nolist                  " Do not show line end character, tabs and spaces

" Indentation
set nolinebreak             " No Break lines when appropriate
set nowrap                  " Do not wrap long lines
set autoindent              " Autoindent based on previous line
set smartindent             " Smart autoindenting on new line
set smarttab                " Respect space/tab settings
set shiftwidth=4            " Use four spaces for autoindent
set softtabstop=4           " Use four spaces for soft tabs
set tabstop=4               " Use four spaces for hard tabs
set expandtab               " Tab key inserts spaces

" Swapfiles and Fileload
set autoread                " Automatically read a changed file
set noswapfile              " Do not write a swapfile
set nobackup                " Do not write a backup
set nowb                    " Do not write a backup / nowritebackup

" Code folding
set foldmethod=indent       " Fold based on indent
set foldnestmax=10          " Deepest fold is 10 levels
set nofoldenable            " Don't fold by default
set foldlevel=1             " Default fold level

" Clipboard
set clipboard=unnamed       " Use system clipboard

syntax enable               " Enable syntax highlighting
syntax on

" --------------
" Leader and Esc
" --------------
let mapleader = "\<Space>"
inoremap jk <Esc>
nnoremap ; :

" Create new line without entering insert mode
map <Leader>o o<ESC>
map <Leader>O O<ESC>

" ----------------
" Navigation Start
" ----------------
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

" Resize splits when resizing window
autocmd VimResized * wincmd =
" --- Navigation End

" Useful shortcuts
command! Wd :write|bdelete

" -------------
" Plugins Start
" -------------
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'mhinz/vim-startify'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'stephpy/vim-yaml'
" Colors
Plug 'vim-scripts/xoria256.vim'
Plug 'jordwalke/flatlandia'
Plug 'cocopon/iceberg.vim'
call plug#end()
" --- Plugins End

" All Plugins must be added before the following lines
syntax enable
filetype indent plugin on     " required

" ---------------------------
" Filetype specific behaviour
" ---------------------------

" Reading and loading a Markdown file sets wrap
autocmd BufReadPre,FileReadPre *.md :set wrap

" Disable markdown folding
let g:vim_markdown_folding_disabled=1

" Spell check in Markdown files
"autocmd FileType markdown setlocal spell

augroup yaml
    autocmd!
    autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
augroup END

augroup json
    autocmd!
    autocmd FileType json setlocal tabstop=2 shiftwidth=2
augroup END
" --- Filetype specific End

" ------------------------
" Color and Theme settings
" ------------------------
" set t_ut=
set background=dark
"colorscheme flatlandia
colorscheme iceberg
set t_Co=256
" Important to set t_Co after colorscheme

" set highlight after the colorscheme to override colorscheme settings
highlight ColorColumn ctermbg=235 guibg=235
highlight CursorLine term=bold cterm=bold ctermbg=235 guibg=235

" ----------------
" Airline settings
" ----------------
" install patched gnome-termianl fonts for powerline symbols
"if !has('gui_running') && !has('win32')
"    let g:airline_powerline_fonts=1
"endif

let g:airline_symbols_ascii=1
let g:airline_left_sep='|'
let g:airline_right_sep='|'

set laststatus=2
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#branch#empty_message='no repo'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tmuxline#enabled=1
let g:tmuxline_powerline_separators=0
let g:airline#extensions#tmuxline#snapshot="~/.tmux.airline.conf"
let g:airline_theme='iceberg'

" -----------------
" Nerdtree settings
" -----------------
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
