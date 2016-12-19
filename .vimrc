" Before anything, make sure Vundle is installed.
" In .vim/bundle, git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
" ~/.vim/bundle
set nocompatible		" be iMproved, required
filetype off			" required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path')

" let Vundle manage Vundle, required!
Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline' "pimpin' status bar
Plugin 'altercation/vim-colors-solarized' "color scheme
Plugin 'scrooloose/nerdcommenter' "for the ill commenting
Plugin 'majutsushi/tagbar' "for the ill tagboob
Plugin 'chriskempson/base16-vim' "For the ill colors
Plugin 'tpope/vim-surround' "For the ill surrounding stuff
Plugin 'nathanaelkane/vim-indent-guides' "For the ill indents
Plugin 'bronson/vim-trailing-whitespace' "Say good bye to all trailing spaces
Plugin 'wakatime/vim-wakatime'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

call vundle#end()		" required
filetype plugin indent on 	" required
" To ignore plugin indent changes, instead use:
" filetype plugin on

" Some help
" In command line, to install plugins: vim +PluginInstall +qall
" :PluginList		- lists configured plugins
" :PluginInstall 	- installs plugins; append ! to update or just :PluginUpdate
" :PluginSearch item	- searches for item; append ! to refresh local cache
" :PluginClean		- confirms removal of unused plugins; append ! to auto-approve
"
" see :h vundle for more details or wiki for FAQ
" all non-Plugin stuff after this line

" NERD Tree related
"
" The following two lines for automatic NERDTree launch if no files
" were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Syntastic related
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['python'], 'passive_filetypes': ['c++'] }
nmap <F5> :SyntasticCheck<CR>
nmap <F6> :SyntasticToggle<CR>
nmap _l :lclose<CR>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" vim-airline related
let g:airline_theme	= 'dark'
let g:enable_branch	= 1
let g:enable_syntastic	= 1
let g:airline_powerline_fonts=1
set laststatus=2

" Enable list buffers in airline
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.whitespace = 'Ξ'

" vim-colors-solarized related
set background=dark
set t_Co=16 "if you don't do this, vim will look frikken weird as shit; it's for the color palette that vim requires
if $COLORTERM == ""
    syntax enable
    colorscheme solarized
else
    "colorscheme base16-atelierdune
    let base16colorspace=256
    "let g:airline_theme = 'light'
endif

"Other stuff
set cursorline
"this is to add a white line under the cursorline
hi CursorLine term=underline cterm=underline gui=underline ctermbg=black 
"set cursorcolumn
"t g:solarized_termcolors=256

"set number "Enables absolute line numbers
"set relativenumber "Enables relative line numbers
set nu rnu "Combination of the two above
"set numberwidth=4
"set colorcolumn=80
hi LineNr term=underline cterm=NONE ctermfg=white ctermbg=black gui=NONE guifg=NONE guibg=NONE
hi CursorLineNr term=bold ctermbg=NONE ctermfg=blue
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set nu rnu
    endif
endfunc

nnoremap <C-j> :call NumberToggle()<CR>

"Instead of a column on 80, just highlight letters that go over the 80
"character limit!
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%101v.\+/

"Some mapping
nmap ZwZ :wqa<CR>
nmap <F4> :FixWhitespace<CR>
nmap <F3> :NERDTree<CR>
" vim-indent-guides related
"let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=darkgreen
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkcyan
set ts=4 sw=4 et

nmap <F7> :IndentGuidesToggle<CR>
"let g:indent_guides_start_level = 2

":set list lcs=tab:\|\ 

"Set keybinds for buffer cycle
nmap <C-n> :bnext<CR>
nmap <C-p> :bprevious<CR>

filetype indent on
set smartindent

"Enable mouse scrolling
set mouse=a

function! s:insert_gates()
    let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    execute "normal! i#ifndef " . gatename
    execute "normal! o#define " . gatename . " "
    execute "normal! Go#endif /* " . gatename . " */"
    normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()
