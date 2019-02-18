" ==========================
" classic vim configurations
" ==========================

set nu              " Set absolute line numbering on
set tabstop=4       " How many columns a tab counts for
set shiftwidth=4    " How many columns text is indented with >>/<<
set expandtab       " Dont use actual tab character
set autoindent      " Turns on autoindent
set smartindent     " Turns on smart indent
set hlsearch        " Turns on search highlighting
syntax on           " Set syntax highlighting on
set backspace=2     " Allow backspace to delete

" =================
" color/font config
" =================

" Need these lines for tmux compatibility
set background=dark
set t_Co=256

" Color scheme :)
colorscheme molokai
