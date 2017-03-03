"===============================================================================
"   Plugins
"===============================================================================

call plug#begin('~/.vim/plugged')

" colorshemes
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'danilo-augusto/vim-afterglow'

" ui
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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

" backspace key
set backspace=indent,eol,start
set smarttab
set nrformats-=octal
set ttimeout
set ttimeoutlen=100

" enable wildmenu
set wildmenu

" glob paths
set path+=**

"display last line
set display+=lastline

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

" highlight characters over limit
match ErrorMsg '\%>80v.\+'

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
execute "set colorcolumn=" . join(range(81,335), ',')
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
set ff=unix
echo "File successfully formatted!"
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
nnoremap <silent><Leader>6 :call ToggleColorColumn()<CR>

" map jj as <ESC>
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

" repeat previous command in visual mode
vnoremap . :norm.<CR>

" toggle tabs
nmap <silent><leader>t :tabnext<CR>

" create tab
nmap <silent><leader>tn :tabnew<CR>

" close tab
nmap <silent><leader>tc :tabclose<CR>

" toggle line numbers
nnoremap <leader>nu :call NumberToggle()<cr>

" map <C-O> to leader-o
nnoremap <Leader>o <C-O>

" keybindings for cscope addon
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>

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

" split / vsplit shortcuts
noremap <leader>s :sf
noremap <leader>vs :vert sf

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
colorscheme solarized8_dark_flat

" show ruler
set ruler

" show status line
set laststatus=2

" allow use of powerline fonts
let g:airline_powerline_fonts = 1

" disable airline arrows
let g:airline_left_sep=''
let g:airline_right_sep=''

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
