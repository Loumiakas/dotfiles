function! generic#StripWhitespaceCR()
    let l = line(".")
    let c = col(".")
    %substitute/\r\+//e | %substitute/\s\+$//e | retab
    call cursor(l, c)
endfun

function! generic#ACI()
    :mark Q
    :set fileformat=unix
    :silent substitute/([ ]\{0,5}\(\w\+\)[ ]\{0,5}\*[ ]\{0,5})/(\1 \*)/ge
    :silent substitute/}\s\+\/\/[ ]\{0,5\}/}   \/\/  /ge
    :silent substitute/ \/\/[ ]\{0,4\}\(\w\+\)/ \/\/  \1/ge
    :silent 1,20substitute/Copyright.*\zs\d\{4}\ze/2020/ge
    :normal `Q
endfunction
