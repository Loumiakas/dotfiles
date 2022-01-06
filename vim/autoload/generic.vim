function! generic#StripWhitespaceCR()
    let l = line(".")
    let c = col(".")
    %substitute/\r\+//e | %substitute/\s\+$//e | retab
    call cursor(l, c)
endfun

function! generic#ACI()
    :mark Q
    :set fileformat=unix
    :silent substitute/([ ]\{0,}\(\"\w\+\"\)[ ]\{0,})/( \1 )/ge
    :silent substitute/([ ]\{0,}\(\<.*\>\)[ ]\{0,}\*[ ]\{0,})[ ]\{0,}\(.*\)/(\1 *)\2/ge
    :silent substitute/([ ]\{0,}\(char\|char16_t\|char32_t\|wchar_t\|signed char\|singed short int\|singed int\|singed long int\|singed long long int\|unsigned char\|unsigned short int\|unsigned int\|unsigned long int\|unsigned long long int\|float\|double\|long double\|bool\|decltype(nullptr)\)[ ]\{0,})[ ]\{0,}\(.*\)/(\1)\2/ge
    :silent substitute/sizeof[ ]\{0,}([ ]\{0,}\(\<.*\>\)[ ]\{0,})/sizeof( \1 )/ge
    :silent substitute/}\s\+\/\/[ ]\{0,5\}/}   \/\/  /ge
    :silent substitute/ \/\/[ ]\{0,4\}\(\w\+\)/ \/\/  \1/ge
    :silent! 1,20substitute/Copyright.*\zs\d\{4}\ze/2022/ge
    :normal `Q
endfunction
