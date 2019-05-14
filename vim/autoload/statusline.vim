" show function name at cursor
function! statusline#ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  let name = getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
  return substitute(name,'(.*','','')
endfunction

" set statusline view
function! statusline#SetStatusLine()
    set statusline=
    set statusline+=%-3.3n\                             " buffer number
    set statusline+=%t\                                 " file name
    set statusline+=%h%m%r%w                            " flags
    set statusline+=[%{strlen(&ft)?&ft:'none'},\        " filetype
    set statusline+=%{strlen(&fenc)?&fenc:&enc},\       " encoding
    set statusline+=%{&fileformat}]\                    " file format
    if ( &filetype=='c'   ||
                \&filetype=='cc'  ||
                \&filetype=='cpp' ||
                \&filetype=='cxx' ||
                \&filetype=='hpp' )
        set statusline+=<%{statusline#ShowFuncName()}>      " show function name
    endif
    set statusline+=%=                                  " right align
    set statusline+=%b,0x%-8B\                          " current char
    set statusline+=%-14.(%l,%c%V%)\ %<%P               " offset
endfunction
