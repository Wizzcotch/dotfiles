" =================================
" plugins (requires vim-plug setup)
" =================================

" Begin including plugins
call plug#begin('~/.vim/plugitin')

Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'w0rp/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'

" Initialize plugins
call plug#end()

" =================
" vim indent guides
" =================

" Change characters
let g:indentguides_spacechar = '|'
let g:indentguides_tabchar = '-'

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

" ==========
" ale config
" ==========

" Enable completion where available (requires LSP server configuration: see
" vim-lsp config in this file)
let g:ale_completion_enabled = 1
let g:ale_completion_max_suggestions = 5
let g:ale_echo_msg_format = '%linter%: %code %%s'
let g:ale_linters = { 'cpp': ['clangd'] }
let g:ale_linters_explicit = 1
let g:ale_cpp_clangd_executable = 'clangd-7'

" ==============
" vim-lsp config
" ==============

" Register 'clangd' LSP server if binary exists and use it for omni-completion
let clang = 'clangd-7' " Usually 'clangd'
if executable(clang)
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                   \ 'name': 'clangd',
                   \ 'cmd': {server_info->[clang]},
                   \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                   \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
endif
