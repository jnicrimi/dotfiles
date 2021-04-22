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
set nocompatible
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
set t_vb=
set tabstop=2
set timeout timeoutlen=1000 ttimeoutlen=10
set title
set updatetime=300
set visualbell
set whichwrap=b,s,[,],<,>
set wrapscan

" mapleader
let g:mapleader = "\<Space>"

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

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'Raimondi/delimitMate'
Plug 'Townk/vim-autoclose'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'dag/vim-fish'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'

call plug#end()

" ColorScheme
autocmd ColorScheme * highlight NonText    ctermbg=NONE ctermfg=239
autocmd ColorScheme * highlight SpecialKey ctermbg=NONE ctermfg=239

colorscheme gruvbox

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1

" fzf.vim
nnoremap [Fzf] <Nop>
nmap <Leader>f [Fzf]
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

" vim-easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

map <Leader>s <Plug>(easymotion-bd-f2)
map <Leader>l <Plug>(easymotion-bd-jk)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" ale
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\ }

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" coc.nvim
inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Mappings using CoCList:
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" init.local.vim
if filereadable($XDG_CONFIG_HOME.'/nvim/init.local.vim')
  runtime! init.local.vim
endif
