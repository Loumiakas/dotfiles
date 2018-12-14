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
Plug 'ayu-theme/ayu-vim'
Plug 'brookhong/cscope.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
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
set smartcase
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

colorscheme ayu
"=============================================================================
" Mappings
"=============================================================================
cnoremap w!! w !sudo tee > /dev/null %
inoremap jj <ESC>
nnoremap <C-P> :find<SPACE>
nnoremap <PAGEUP> <C-U>
nnoremap <PAGEDOWN> <C-D>

nnoremap <SILENT><LEADER>1  :%substitute/\s\+$//g<CR>
nnoremap <SILENT><LEADER>2  :call explorer#ToggleExplorer()<CR>
nnoremap <SILENT><LEADER>3  :TagbarToggle<CR>
nnoremap <SILENT><LEADER>5  :set cursorline!<CR>
nnoremap <SILENT><LEADER>4  :set list!<CR>
nnoremap <SILENT><LEADER>6  :call colorcolumn#ToggleColorColumn()<CR>
nnoremap <SILENT><LEADER>hl :set hlsearch!<CR>

if &diff
    set cursorline
    set diffopt+=algorithm:patience
    set diffopt+=indent-heuristic

    nnoremap <SILENT><LEADER><SPACE> :call DiffModeToggle()<CR>
    nnoremap <LEADER>du :diffupdate<CR>

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
    vnoremap <LEADER>y "+y
    nnoremap <LEADER>Y "+yg_
    nnoremap <LEADER>y "+y
    nnoremap <LEADER>p "+p
    nnoremap <LEADER>P "+P
    vnoremap <LEADER>p "+p
    vnoremap <LEADER>P "+P
endif

" better quickfix window navigation
nnoremap <SILENT>[q :cprev<CR>
nnoremap <SILENT>]q :cnext<CR>
nnoremap <SILENT>[Q :cfirst<CR>
nnoremap <SILENT>]Q :clast<CR>
