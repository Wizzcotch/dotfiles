" =================================
" plugins (requires vim-plug setup)
" =================================

" Begin including plugins
call plug#begin('~/.vim/plugitin')

Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'

" Initialize plugins
call plug#end()

" ==========================
" classic vim configurations
" ==========================

set nu              " Set absolute line numbering on
set tabstop=4       " how many columns a tab counts for
set shiftwidth=4    " how many columns text is indented with >>/<<
set expandtab       " dont use actual tab character
set autoindent      " turns on autoindent
set smartindent     " turns on smart indent
set hlsearch        " turns on search highlighting
syntax on           " Set syntax highlighting on

" ====================
" custom vim functions
" ====================

" Toggle between absolute and relative line numbering
function! LineNumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set nu rnu
    endif
endfunc

nnoremap <C-j> :call LineNumberToggle()<CR>

" ===============
" custom mappings
" ===============

" Binds for cycling through buffers
nmap    <C-n>      :bnext<CR>
nmap    <C-p>      :bprev<CR>

" Turn off search highlighting
noremap  \q        :nohlsearch<CR>

" Toggle folds
nnoremap <Space>   za
vnoremap <S-Space> zA

" Save and close out all buffers
nnoremap ZwZ       :wqa<CR>

" Split-window navigation
nnoremap <Up>      <C-w>k
nnoremap <Down>    <C-w>j
nnoremap <Left>    <C-w>h
nnoremap <Right>   <C-w>l

" Command line bindings
cnoremap <C-a>     <Home>
cnoremap <C-b>     <Left>
cnoremap <C-f>     <Right>
cnoremap <C-d>     <Delete>
cnoremap <M-b>     <S-Left>
cnoremap <M-f>     <S-Right>
cnoremap <M-d>     <S-right><Delete>

" Indent Guides toggle
nnoremap <F3>      :IndentGuidesToggle<CR>

" =================
" color/font config
" =================

" Need these lines for tmux compatibility
set background=dark
set t_Co=256

" Color scheme :)
colorscheme molokai

" ======================
" multi cursor remappings
" ======================
let g:multi_cursor_use_default_mapping=0

let g:multi_cursor_start_word_key      = '<C-N>'
let g:multi_cursor_select_all_word_key = '<A-N>'
let g:multi_cursor_start_key           = 'g<C-N>'
let g:multi_cursor_select_all_key      = 'g<A-N>'
let g:multi_cursor_next_key            = '<C-N>'
let g:multi_cursor_prev_key            = '<C-P>'
let g:multi_cursor_skip_key            = '<C-S>'
let g:multi_cursor_quit_key            = '<Esc>'

" Default mappings
" let g:multi_cursor_start_word_key      = '<C-n>'
" let g:multi_cursor_select_all_word_key = '<A-n>'
" let g:multi_cursor_start_key           = 'g<C-n>'
" let g:multi_cursor_select_all_key      = 'g<A-n>'
" let g:multi_cursor_next_key            = '<C-n>'
" let g:multi_cursor_prev_key            = '<C-p>'
" let g:multi_cursor_skip_key            = '<C-x>'
" let g:multi_cursor_quit_key            = '<Esc>'
