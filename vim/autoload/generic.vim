function! generic#StripWhitespaceCR()
    let l = line(".")
    let c = col(".")
    %substitute/\r\+//e | %substitute/\s\+$//e | retab
    call cursor(l, c)
endfun


