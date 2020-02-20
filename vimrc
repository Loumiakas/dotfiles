filetype plugin indent on
syntax on

"=============================================================================
" Autocommands
"=============================================================================
augroup editor_settings
    autocmd!
    " Download plugin manager, if it is not installed on the system
    if has('gui_running') == 0
        if empty(glob('~/.vim/autoload/plug.vim'))
            silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
             \ https://raw.githubusercontent.com/junegunn/vim-plug/master/
                                                                     \plug.vim
            autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
        endif
    endif
    " when editing a file, always jump to the last cursor position
     autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

    " automatically resize windows on change
    autocmd VimResized * wincmd =
    " statusline plugin
    autocmd FileType,BufEnter * call statusline#SetStatusLine()
augroup END

augroup filetype_settings
    autocmd!
    " remove external characters that should not be present in C/C++ files
    autocmd FileType c,cpp,h,hpp autocmd BufWritePre * call
                                                 \ generic#StripWhitespaceCR()
augroup END

"=============================================================================
" Commands
"=============================================================================
command! MakeTags !ctags -R .

"=============================================================================
" Plugins
"=============================================================================
call plug#begin('~/.vim/plugged')
Plug 'Loumiakas/moonlight-vim'
Plug 'chriskempson/base16-vim'
Plug 'Yggdroot/indentLine'
Plug 'whatyouhide/vim-gotham'
Plug 'gruvbox-community/gruvbox'
Plug 'brookhong/cscope.vim'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/Tagbar'
Plug 'davidhalter/jedi-vim'
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

if has('mouse_sgr')
    set ttymouse=sgr
endif

if has('gui_running') || exists('g:GuiLoaded')
    colorscheme moonlight
    set guioptions-=r
    set guioptions-=L
    set guioptions-=T
    set guioptions-=m
    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=gohufont-14:h11
    elseif exists('g:GuiLoaded')
        GuiFont! gohufont-14:h11
    endif
    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
else
    colorscheme badwolf
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

nnoremap <silent><leader>2  :call explorer#ToggleExplorer()<cr>
nnoremap <silent><leader>3  :TagbarToggle<cr>
nnoremap <silent><leader>5  :set cursorline!<cr>
nnoremap <silent><leader>4  :set list!<cr>
nnoremap <silent><leader>6  :call colorcolumn#ToggleColorColumn()<cr>
nnoremap <silent><leader>hl :set hlsearch!<cr>
nnoremap <silent><leader>sp :set spell!<cr>

if &diff
    colorscheme gruvbox
    set cursorline
    set diffopt+=algorithm:patience
    set diffopt+=indent-heuristic
    set diffopt+=vertical,filler,internal,context:3

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
