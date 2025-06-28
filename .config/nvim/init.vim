" shell
if $SHELL =~ '/fish$'
  set shell=bash
endif

" set
set autoindent
set background=dark
set backspace=2
set backspace=indent,eol,start
set cursorline
set display=lastline
set history=50
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=trail:-,eol:¬,tab:▸\ ,extends:»,precedes:«
set nobackup
set noerrorbells
set noswapfile
set notitle
set nowritebackup
set number
set ruler
set shiftwidth=2
set shortmess+=I
set shortmess+=c
set showbreak=↪
set showcmd
set showmatch
set showmode
set signcolumn=yes
set smartcase
set smartindent
set smarttab
set tabstop=2
set termguicolors
set timeout timeoutlen=1000 ttimeoutlen=10
set title
set updatetime=300
set visualbell
set whichwrap=b,s,[,],<,>
set wrapscan

" mapleader
let g:mapleader = "\<Space>"

" termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" tabpage
nnoremap [Tag] <Nop>
nmap t [Tag]

for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>

" CursorShape
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" Remap Esc key
inoremap <silent> jj <ESC>

" Cursor key
nnoremap <Down> gj
nnoremap <Up>   gk

" ZenkakuSpace
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=grey
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif

" vim-polyglot
let g:polyglot_disabled = ['vue']

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'Raimondi/delimitMate'
Plug 'Townk/vim-autoclose'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'dag/vim-fish'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

call plug#end()

colorscheme gruvbox

" fzf.vim
nmap <Leader>f [Fzf]
nnoremap [Fzf] <Nop>
nnoremap [Fzf]f :<C-u>Files<CR>
nnoremap [Fzf]g :<C-u>GFiles<CR>
nnoremap [Fzf]G :<C-u>GFiles?<CR>
nnoremap [Fzf]h :<C-u>History<CR>

" indentLine
let g:indentLine_color_term = 239

" vim-gitgutter
nnoremap [gitgutter] <Nop>
nmap <C-h> [gitgutter]
nmap [gitgutter]j <Plug>(GitGutterNextHunk)
nmap [gitgutter]k <Plug>(GitGutterPrevHunk)

" ale
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\ }

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
