let s:color_column_old = 0
function! colorcolumn#ToggleColorColumn()
if s:color_column_old == 0
    let s:color_column_old = &colorcolumn
    windo let &colorcolumn = 0
else
    windo let &colorcolumn=s:color_column_old
    let s:color_column_old = 0
endif
endfunction
