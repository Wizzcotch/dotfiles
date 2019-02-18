" ==================
" line number toggle
" ==================

" Toggle between absolute and relative line numbering
function! LineNumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set nu rnu
    endif
endfunc
