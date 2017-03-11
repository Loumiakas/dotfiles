"===============================================================================
"   Plugins
"===============================================================================

call plug#begin('~/.vim/plugged')

" colorshemes
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'

" ui
Plug 'vim-scripts/Tagbar'

" salesforce development
Plug 'neowit/vim-force.com'

" editing and completion
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'brookhong/cscope.vim'

" navigation
Plug 'wellle/targets.vim'

" formatting and indentation
Plug 'scrooloose/nerdcommenter'
Plug 'Townk/vim-autoclose'

" non categorized packages

call plug#end()

"===============================================================================
"   Settings
"===============================================================================

" utf-8 encoding
set encoding=utf-8

" when editing a file, always jump to the last cursor position
if has("autocmd")
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif
endif

" auto indent
set autoindent
set copyindent

" check for changes in file
set autoread

" enable wildmenu
set wildmenu

" glob paths
set path+=**

" display last line
set display+=lastline

" set default file format to UNIX
set fileformats=unix

" modify list characters
set listchars=tab:>.,trail:.,extends:>,precedes:<,nbsp:.,eol:¬

" required for addons
filetype plugin indent on

" disable [scratch] window on autocomplete
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

set incsearch

" disable swapfiles
set noswapfile

" ignore case when searching
set ignorecase

" allow mouse clicks inside terminal
set mouse=a

" set 15 lines to the cursor when using j/k movement keys
set so=15

if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" fix backspace
set bs=2

" map new leader key to space bar
let mapleader=" "

" use space key for tab key
set expandtab
set tabstop=4
set shiftwidth=4

" automatically break after 80th character
set textwidth=80

" replace grep with ag, if exists
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif

"Toggles explorer buffer
function! ToggleVExplorer()
if exists("t:expl_buf_num")
    let expl_win_num = bufwinnr(t:expl_buf_num)
    if expl_win_num != -1
        let cur_win_nr = winnr()
        exec expl_win_num . 'wincmd w'
        close
        exec cur_win_nr . 'wincmd w'
        unlet t:expl_buf_num
    else
        unlet t:expl_buf_num
    endif
else
    exec '1wincmd w'
    Vexplore
    let t:expl_buf_num = bufnr("%")
endif
endfunction
let g:netrw_liststyle=3
let g:netrw_winsize=20

" toggle colored right border after 80 chars
set colorcolumn=81

let s:color_column_old = 0
function! g:ToggleColorColumn()
if s:color_column_old == 0
    let s:color_column_old = &colorcolumn
    windo let &colorcolumn = 0
else
    windo let &colorcolumn=s:color_column_old
    let s:color_column_old = 0
endif
endfunction
call ToggleColorColumn()

" strip trailing whitespace, unix line endings, retab
function! g:FormatCode()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
    retab
    %s///g
    echo "File successfully formatted!"
endfunction

" get buffer list
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

" toggle quickfix window
function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'),
              \ 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

" switch between numbers
function! g:NumberToggle()
if(&relativenumber == 1)
    set relativenumber!
    set number
else
    set relativenumber
endif
endfunc

" autoclose Tagbar on selection
let g:tagbar_autoclose = 1

" ignore case filepaths
set wildignorecase

" move mod key is ctrl
let g:move_key_modifier = 'C'

" show numbers
set number

" add relative numbers
set relativenumber number

" better splitting
set splitbelow
set splitright

" apex development
let g:apex_tooling_force_dot_com_path=
                        \ "/Users/macbook/.force/tooling-force.com-0.3.8.0.jar"
if !exists("g:apex_backup_folder")
    " full path required here, relative may not work
    let g:apex_backup_folder="/Users/macbook/.force/backup"
endif
if !exists("g:apex_temp_folder")
    " full path required here, relative may not work
    let g:apex_temp_folder="/Users/macbook/.force/temp"
endif
if !exists("g:apex_properties_folder")
    " full path required here, relative may not work
    let g:apex_properties_folder="/Users/macbook/.force/properties"
endif

"===============================================================================
"   Mappings
"===============================================================================

" format code
nmap <leader>1 :call FormatCode()<CR>

" toggle Explorer
nmap <silent><leader>2 :call ToggleVExplorer()<CR>

" toggle TagBar
nmap <silent><leader>3 :TagbarToggle<CR>

" show hidden chars
nmap <silent><Leader>4 :set list!<CR>

" toggle cursorline
nmap <silent><Leader>5 :set cursorline!<CR>
:hi CursorLine gui=underline cterm=underline
:hi clear CursorLine

" toggle color column
nnoremap <silent><Leader>6 :call ToggleColorColumn()<CR> " map jj as <ESC>

" toggle color on characteras over 80
nnoremap <silent> <Leader>7
    \ :if exists('w:long_line_match') <Bar>
    \   silent! call matchdelete(w:long_line_match) <Bar>
    \   unlet w:long_line_match <Bar>
    \ elseif &textwidth > 0 <Bar>
    \   let w:long_line_match = matchadd('ErrorMsg', '\%>'.&tw.'v.\+', -1) <Bar>
    \ else <Bar>
    \   let w:long_line_match = matchadd('ErrorMsg', '\%>80v.\+', -1) <Bar>
    \ endif<CR>


" map jj to ESC
inoremap jj <Esc>

" map <enter> to run macro
nnoremap <enter> @@

" back to previous buffer
map <Leader>b <C-^>

" better window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" better quickfix window navigation
nnoremap <silent>[q :cprev<CR>
nnoremap <silent>]q :cnext<CR>
nnoremap <silent>[Q :cfirst<CR>
nnoremap <silent>]Q :clast<CR>
nmap <silent> <leader>ql :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>qf :call ToggleList("Quickfix List", 'c')<CR>

" repeat previous command in visual mode
vnoremap . :norm.<CR>

" toggle line numbers
nnoremap <leader>nu :call NumberToggle()<cr>

" map <C-O> to leader-o
nnoremap <Leader>o <C-O>

" keybindings for cscope addon
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>

" grep  keybindings
nnoremap <leader>s :Ag <C-R><C-W><CR>
vnoremap <leader>s "zy:Ag '<C-R>z'<CR>

" toggle highlighting (search)
nnoremap <silent><leader>hl :set hlsearch!<CR>

" ultiSnips key maps
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetDirectories  = ["snips"]

" sudo write to file
cmap w!! w !sudo tee > /dev/null %

" copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" poor man's ctrlp
nnoremap <C-p> :find

" use magic mode by default in search mode
nnoremap / /\v
vnoremap / /\v

"===============================================================================
"   Style
"===============================================================================

" show syntax hightlighting
syntax on

if has('gui_running')

    " set background color
    set background=dark

    " disable left and right scrollbars in GUI
    set guioptions-=r
    set guioptions-=L

    " set to 40 lines of text
    set lines=40

    " 256 color support in gui
    set t_Co=256
else
    " set background color
    set background=dark

    " set truecolor support if supported
    if has('termguicolors')
        set t_Co=256
        set t_8f=[38;2;%lu;%lu;%lum
        set t_8b=[48;2;%lu;%lu;%lum
        set termguicolors
    endif
endif

" set colorscheme
let g:gruvbox_contrast_light="soft"
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox

" colorcolumn colors
highlight ColorColumn ctermbg=12
highlight ColorColumn guibg=#b55614
let w:long_line_match = matchadd('ErrorMsg', '\%>80v.\+', -1)

" show ruler
set ruler

" ruler settings
set statusline=
set statusline+=%-3.3n\                        " buffer number
set statusline+=%f\                            " file name
set statusline+=%h%m%r%w                       " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},\   " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc},\  " encoding
set statusline+=%{&fileformat}]                " file format
set statusline+=%=                             " right align
set statusline+=%b,0x%-8B\                     " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P          " offset

" show command
set showcmd

" show status line
set laststatus=2

" allow cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"===============================================================================
"   Testing
"===============================================================================
