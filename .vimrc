" Vim's default behavior
syntax enable
set nocompatible
set nobackup
set novisualbell
set backspace=indent,eol,start
let g:loaded_matchparen=1
set showmatch
set matchtime=0

" Solve cursor update delays when switching mode
set ttimeout
set ttimeoutlen=1
set ttyfast

call plug#begin()

" List your plugins here
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'derekwyatt/vim-fswitch'
Plug '42paris/42header'

call plug#end()

let g:netrw_liststyle=3

" Set cursor shapes in particular modes
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
let &t_SR = "\e[4 q"

" Hide GUI in GVIM
set guioptions-=m  " no menu bar
set guioptions-=T  " no toolbar
set guioptions-=r  " no scrollbar

" Set color and font
set termguicolors
set background=dark
colorscheme lunadark
if has("gui_running")
	if has("gui_win32")
		set guifont=Iosevka\ Fixed\ Regular:h14:cANSI
	else
		set guifont=Iosevka\ Fixed\ Regular:\14
	endif
endif

" Set editor options
set noexpandtab
set tabstop=4
set shiftwidth=4
set number
set numberwidth=4
set ruler
set colorcolumn=80
set showcmd
"set list listchars=tab:»\ ,trail:·
"set list listchars=tab:¦\ ,trail:·
set list listchars=tab:❘\ ,trail:·
set laststatus=2
set wildmenu
set mousefocus

" NERDTree
let g:NERDTreeWinSize = 25
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let NERDTreeIgnore=['\.pyc$', '\.bin$', '\.o$', '\.a$', '\.swp$', 'node_modules/[[dir]]']

" Tagbar
let g:tagbar_width = 30

" 42header plugin
let g:user42 = 'ssrimaha'
let g:mail42 = 'ssrimaha@student.42.fr'

" Set keyboard shortcuts
let mapleader=","

" Edit VIMRC
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Buffer navigation
nnoremap <leader>1 :bp<CR>
nnoremap <leader>2 :bn<CR>

" Tab navigation
nnoremap ! :tabprevious<CR>
nnoremap @ :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-c> :tabclose<CR>

" Pane navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
tnoremap <C-n> <C-w>N

" Save
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

" Set tabstop
nnoremap <leader>ts :set tabstop=
nnoremap <leader>t1 :set tabstop=2<CR>
nnoremap <leader>t2 :set tabstop=4<CR>
nnoremap <leader>t3 :set tabstop=8<CR>

" Code helper
nnoremap <leader>3 O/*<ESC>77a-<ESC>
nnoremap <leader>4 o<ESC>77a-<ESC>a*/<ESC>
inoremap <leader>` /*  */<ESC>hhi
inoremap <leader>, ,
inoremap <leader>< <><ESC>i
inoremap <leader>[ []<ESC>i
inoremap <leader>( ()<ESC>i
inoremap <leader>{ {}<ESC>i
inoremap <leader>b {<CR><TAB><CR>}<ESC>hxkA
nnoremap <leader>w bi(<ESC>wwi)<ESC>
vnoremap <C-c> "+y

" Strip empty line from selection
vnoremap <C-l> :g/^\s*$/d<CR>

" NERDTree
nnoremap <F2> :NERDTreeToggle<CR>

" Tagbar
nnoremap <F3> :TagbarToggle<CR>

" FSwitch
nnoremap <F4> :FSHere<CR>

" Header Guard
nnoremap <F5> :call <SID>InsertHeaderGuard()<CR>

" Quickfix Window
nnoremap <F6> :copen<CR>
nnoremap <F7> :cprev<CR>
nnoremap <F8> :cnext<CR>

" ---- Auto Commands ---------------------------------------------------------
autocmd BufNewFile *.{h,hpp} call <SID>InsertHeaderGuard()
autocmd BufWrite *.h,*.c,*.sh call DeleteTrailingWS()
autocmd BufWritePost * NERDTreeRefreshRoot
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"autocmd InsertEnter * set cursorline
"autocmd InsertLeave * set nocursorline

" ---- Functions -------------------------------------------------------------
function! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

function! s:InsertHeaderGuard()
  let guardName = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . guardName
  execute "normal! o# define " . guardName . " "
  execute "normal! Go#endif"
  normal! kk
endfunction

