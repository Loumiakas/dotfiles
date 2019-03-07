filetype plugin indent on
syntax on

"=============================================================================
" Autocommands
"=============================================================================
" download plugin manager, if not found
if has('gui_running') == 0
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
         \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif
" statusline plugin
autocmd BufNewFile,BufRead * call statusline#SetStatusLine()
autocmd FileType cpp,c call statusline#SetStatusLineCpp()
" when editing a file, always jump to the last cursor position
autocmd BufReadPost *
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \   exe "normal g'\"" |
            \ endif
" automatically resize windows on change
autocmd VimResized * wincmd =

"=============================================================================
" Plugins
"=============================================================================
call plug#begin('~/.vim/plugged')
Plug 'ayu-theme/ayu-vim'
Plug 'brookhong/cscope.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/Tagbar'
Plug 'wellle/targets.vim'
Plug 'whatyouhide/vim-gotham'
call plug#end()

"=============================================================================
" Plugin Settings
"=============================================================================
let g:tagbar_autoclose=1
let g:gruvbox_contrast_light='soft'
let g:gruvbox_contrast_dark='hard'

"=============================================================================
" Settings
"=============================================================================
let mapleader=" "
set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set colorcolumn=0
set copyindent
set display+=lastline
set expandtab
set hidden
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set listchars=tab:>.,trail:.,extends:>,precedes:<,nbsp:.,eol:$
set mouse=a
set noswapfile
set number
set path=.,**
set regexpengine=1
set ruler
set scrolloff=10
set shiftwidth=4
set showcmd
set smartcase
set smarttab
set splitbelow
set splitright
set t_Co=256
set tabstop=4
set textwidth=78
set timeoutlen=800
set wildignorecase
set wildmenu
set wildmode=longest:full,full


if has('gui_running')
    colorscheme solarized8_flat
    set guioptions-=r
    set guioptions-=L
    set guioptions-=T
    set guioptions-=m
    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h10:cANSI
    endif
    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
else
    colorscheme gruvbox
    if has('termguicolors')
        set t_8f=[38;2;%lu;%lu;%lum
        set t_8b=[48;2;%lu;%lu;%lum
        set termguicolors
    endif
endif

"=============================================================================
" Mappings
"=============================================================================
cnoremap w!! w !sudo tee > /dev/null %
inoremap jj <esc>
nnoremap <c-p> :find<space>
nnoremap <pageup> <c-u>
nnoremap <pagedown> <c-d>

nnoremap <silent><leader>1  :%substitute/\s\+$//g<cr>
nnoremap <silent><leader>2  :call explorer#ToggleExplorer()<cr>
nnoremap <silent><leader>3  :TagbarToggle<cr>
nnoremap <silent><leader>5  :set cursorline!<cr>
nnoremap <silent><leader>4  :set list!<cr>
nnoremap <silent><leader>6  :call colorcolumn#ToggleColorColumn()<cr>
nnoremap <silent><leader>hl :set hlsearch!<cr>

if &diff
    colorscheme gruvbox
    set cursorline
    set diffopt+=algorithm:patience
    set diffopt+=indent-heuristic

    nnoremap <silent><leader><space> :call DiffModeToggle()<cr>
    nnoremap <leader>du :diffupdate<cr>

    let g:is_diff_mode = 1
    function! DiffModeToggle()
        if g:is_diff_mode
            diffoff
            let g:is_diff_mode = 0
        else
            diffthis
            let g:is_diff_mode = 1
        endif
    endfunction
endif

if has('clipboard') " clipboard buffer shortcuts
    vnoremap <leader>y "+y
    nnoremap <leader>Y "+yg_
    nnoremap <leader>y "+y
    nnoremap <leader>p "+p
    nnoremap <leader>P "+P
    vnoremap <leader>p "+p
    vnoremap <leader>P "+P
endif

" better quickfix window navigation
nnoremap <silent>[q :cprev<cr>
nnoremap <silent>]q :cnext<cr>
nnoremap <silent>[Q :cfirst<cr>
nnoremap <silent>]Q :clast<cr>
