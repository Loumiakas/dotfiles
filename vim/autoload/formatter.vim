function! formatter#FormatCode()
    silent! %substitute/\s\+$//
    silent! %substitute///
    echo "Code formatted!"
endfunction
