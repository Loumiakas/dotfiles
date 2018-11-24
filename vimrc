filetype plugin indent on
syntax on

"=============================================================================
" Autocommands
"=============================================================================
" download plugin manager, if not found
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
         \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
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
Plug 'brookhong/cscope.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'morhetz/gruvbox'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'lifepillar/vim-solarized8'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/Tagbar'
Plug 'wellle/targets.vim'
call plug#end()

"=============================================================================
" Plugin Settings
"=============================================================================
let g:tagbar_autoclose=1
let g:gruvbox_contrast_light="soft"
let g:gruvbox_contrast_dark="hard"

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
set smartcase
set incsearch
set laststatus=2
set lazyredraw
set listchars=tab:>.,trail:.,extends:>,precedes:<,nbsp:.,eol:¬
set mouse=a
set noswapfile
set number
set path=.,**
set regexpengine=1
set ruler
set scrolloff=10
set shiftwidth=4
set showcmd
set smarttab
set splitbelow
set splitright
set t_Co=256
set tabstop=4
set textwidth=78
set timeoutlen=500
set wildignorecase
set wildmenu
set wildmode=longest:full,full


if has('gui_running')
    set guioptions-=r
    set guioptions-=L
else
    if has('termguicolors')
        set t_8f=[38;2;%lu;%lu;%lum
        set t_8b=[48;2;%lu;%lu;%lum
        set termguicolors
    endif
endif

colorscheme solarized8_high
"=============================================================================
" Mappings
"=============================================================================
cnoremap w!! w !sudo tee > /dev/null %
inoremap jj <ESC>
nnoremap <C-P> :find 
nnoremap <PageUp> <C-U>
nnoremap <PageDown> <C-D>

nnoremap <silent><leader>1  :%substitute/\s\+$//g<CR>
nnoremap <silent><leader>2  :call explorer#ToggleExplorer()<CR>
nnoremap <silent><leader>3  :TagbarToggle<CR>
nnoremap <silent><leader>5  :set cursorline!<CR>
nnoremap <silent><leader>4  :set list!<CR>
nnoremap <silent><leader>6  :call colorcolumn#ToggleColorColumn()<CR>
nnoremap <silent><leader>hl :set hlsearch!<CR>

if &diff
    set cursorline
    nnoremap <leader>do :diffoff<CR>
    nnoremap <leader>dt :diffthis<CR>
    nnoremap <leader>du :diffupdate<CR>
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
nnoremap <silent>[q :cprev<CR>
nnoremap <silent>]q :cnext<CR>
nnoremap <silent>[Q :cfirst<CR>
nnoremap <silent>]Q :clast<CR>
