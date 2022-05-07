set encoding=utf-8
set number
set relativenumber

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
"set autowriteall

if has("autocmd")
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

set autoindent
"set cindent
"set smartindent

set ruler
set showcmd

"set cursorline
"hi CursorLine term=bold cterm=bold guibg=Grey40

set incsearch
set hlsearch

if has("syntax")
  syntax on
endif

"set pastetoggle=F3

" plugins
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')
"Plug 'crusoexia/vim-monokai'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
call plug#end()

"colorscheme monokai
