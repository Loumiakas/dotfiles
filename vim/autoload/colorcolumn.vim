let s:color_column_old = 79
function! colorcolumn#ToggleColorColumn()
if s:color_column_old == 79
    let s:color_column_old = &colorcolumn
    windo let &colorcolumn = 79
else
    windo let &colorcolumn=s:color_column_old
    let s:color_column_old = 79
endif
endfunction
