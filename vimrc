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

autocmd VimEnter * if exists(":FZF")
            \ |     nnoremap <c-p> :FZF<CR>
            \ |     nnoremap <leader>ff :Rg
            \ | else
            \ |     nnoremap <c-p> :find
            \ | endif
"=============================================================================
" Commands
"=============================================================================
command! MakeTags !ctags -R .
"=============================================================================
" Plugins
"=============================================================================
call plug#begin('~/.vim/plugged')
Plug 'lifepillar/vim-solarized8'
Plug 'Loumiakas/moonlight-vim'
Plug 'Rigellute/rigel'
Plug 'Valloric/ListToggle'
Plug 'Yggdroot/indentLine'
Plug 'bluz71/vim-moonfly-colors'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'brookhong/cscope.vim'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'chriskempson/base16-vim'
Plug 'davidhalter/jedi-vim'
Plug 'fcpg/vim-farout'
Plug 'gruvbox-community/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rafalbromirski/vim-aurora'
Plug 'relastle/bluewery.vim'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'sheerun/vim-polyglot'
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/Tagbar'
Plug 'whatyouhide/vim-gotham'
call plug#end()

"=============================================================================
" Plugin Settings
"=============================================================================
let g:csv_no_conceal = 1
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_preview_window = ['up:70%', 'ctrl-/']
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='soft'
let g:tagbar_autoclose=1
let g:tagbar_sort=0
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
    colorscheme nightfly
    set guioptions-=r
    set guioptions-=L
    set guioptions-=T
    set guioptions-=m
    if has("gui_gtk2")
        set guifont=Ubuntu\ Mono:h12
    elseif has("gui_macvim")
        set guifont=Ubuntu\ Mono:h15
    elseif has("gui_win32")
        set guifont=Ubuntu\ Mono:h12
    elseif exists('g:GuiLoaded')
        set guifont=Ubuntu\ Mono:h12
    endif
    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

else
    if has('termguicolors')
        set t_8f=[38;2;%lu;%lu;%lum
        set t_8b=[48;2;%lu;%lu;%lum
        set termguicolors
    endif
    colorscheme nightfly
endif

"=============================================================================
" Mappings
"=============================================================================
cnoremap w!! w !sudo tee > /dev/null %
inoremap jj <esc>
nnoremap gp `[v`]a
nnoremap <pageup> <c-u>
nnoremap <pagedown> <c-d>

nnoremap <silent><leader>2  :call explorer#ToggleExplorer()<cr>
nnoremap <silent><leader>3  :TagbarToggle<cr>
nnoremap <silent><leader>5  :set cursorline!<cr>
nnoremap <silent><leader>4  :set list!<cr>
nnoremap <silent><leader>6  :call colorcolumn#ToggleColorColumn()<cr>
nnoremap <silent><leader>hl :set hlsearch!<cr>
nnoremap <silent><leader>sp :set spell!<cr>

if v:version >= 802
    map <silent><Leader>gb :call setbufvar(winbufnr(popup_atcursor(
                \systemlist("cd " . shellescape(fnamemodify(resolve(
                \expand('%:p')), ":h")) . " && git log --no-merges -n 1 -L " .
                \shellescape(line("v") . "," . line(".") . ":" . resolve(
                \expand("%:p")))), { "padding": [1,1,1,1], "pos": "botleft",
                \"wrap": 0 })), "&filetype", "git")<CR>
endi

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
