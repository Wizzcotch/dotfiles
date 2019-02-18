" ================
" vanilla mappings
" ================

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

" ====================
" indent guides config
" ====================

" Indent Guides toggle
nnoremap <F3>      :IndentGuidesToggle<CR>

" =================
" function mappings
" =================
"
nnoremap <C-j> :call LineNumberToggle()<CR>
