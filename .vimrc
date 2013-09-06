execute pathogen#infect()
syntax on
filetype plugin indent on

" mode is active (on by default), so the active_filetype can be empty
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['html'] }

set nocompatible

" Turn off vim's backup system. Because you're using git or hg, right? right?
set nobackup
set nowritebackup

" Turn off the swap files. As far as I can tell, it just annoys me
set noswapfile

" Don't use Ex mode. Use Q for formatting
map Q gq

" Allows unwritten changes in the buffer if you open another one.
set hidden

" security
set modelines=0

" This is mostly based on 
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/

" Tabs and whitespace
" overridden for python in ~/.vim/after/ftplugin/python.vim
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set linespace=2  " add a bit of leading

" Make vim behave in a sane manner
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2

if has("relativenumber")
  set relativenumber      " use relative instead of absolute line numbers
endif

" persistent undo. new in 7.3
if has("undofile")
  set undofile
  set undodir=~/.vim_backups/undo
endif

" tame backups so they don't pollute my source trees.
" come to think of it, should I just turn them off?
set backupdir=~/.vim_backups
set directory=~/.vim_backups

" new leader character
let mapleader = ","

" tame searching & moving
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" set ,r to save the current buffer and refresh
" the most recent browswer window
" depends, obviously, on the applescript file
" would probably be better as a function where I include
" the applescript inline in the vimrc file
" nnoremap <leader>r :w<CR> :silent !osascript ~/src/applescript/refreshChrome.scpt<CR>

" line length
set wrap
set linebreak "don't break up words...
set textwidth=80
set wrapmargin=0
set showbreak="+++ "
set formatoptions=qrn1tc2w
if ("colorcolumn")
  set colorcolumn=""  " set to +1 for one column after textwidth
endif

" scroll up and down one line in an intuitive manner
nnoremap j gj
nnoremap k gk

"in normal mode, press space to half-page down (like a webpage) 
nnoremap <space> <C-D> 

" easier to swap between vsplit windows.
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

" make semicolon equal the colon. But not the other way
" this breaks the "press ; to go to next find character
" not a big deal at the moment
nnoremap ; :

" map I to jump to start of line in insert mode
nnoremap I ^i

" map K to split the line without exiting normal mode
" @brennen's version:
nnoremap K i<CR><Esc>l;
" @vimrc's version:
" nnoremap K i<cr><esc><right>mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" map cc to always start at the begining of the line content
nnoremap cc ^cc

" quick php parser check
noremap <C-O> :!php -l %<CR>

" jj to exit insert mode
inoremap jj <ESC>

" highlight tabs and trailing spaces
nmap <silent> <leader>s :set nolist!<CR>:redr<CR>
set listchars=tab:⇾\ ,trail:·
set list

" maps ,U to make a word uppercase and change into append mode afterwards.
nnoremap <leader>U gUaWEa
inoremap <leader>U <Esc>gUaWEa

" use mysql as the default sql type for improved syntax highlighting
" see `:h sql.txt` for more info
let g:sql_type_default = 'mysql'
" not sure if I need this, but leaving it here in case I need it later
" if has("autocmd")
"         autocmd BufRead *.sql set filetype=mysql      
" endif


"  exclude .DS_Store and .pyc files from directory listings
" remember: you can always press `a` in the netrw screen to switch between 
" hiding and unhiding files
let g:netrw_list_hide= '^\.DS_Store$,^.*\.pyc$'
let NERDTreeIgnore = ['\.pyc$']

" Color scheme (terminal)
syntax on
set t_Co=256
set background=dark
if has("gui_running")
    colorscheme BusyBee
    " colorscheme mustang 
else
    colorscheme ir_black
endif



" ========================
" REMAPPING THE ARROW KEYS
" This is a great idea. Instead of disabling the arrow keys altogether
" in normal mode, simply change their behavior to change white space
" originally found here:http://jeetworks.org/node/89

function! DelEmptyLineAbove()
    if line(".") == 1
        return
    endif
    let l:line = getline(line(".") - 1)
    if l:line =~ '^\s*$'
        let l:colsave = col(".")
        .-1d
        silent normal! <C-y>
        call cursor(line("."), l:colsave)
    endif
endfunction
 
function! AddEmptyLineAbove()
    let l:scrolloffsave = &scrolloff
    " Avoid jerky scrolling with ^E at top of window
    set scrolloff=0
    call append(line(".") - 1, "")
    if winline() != winheight(0)
        silent normal! <C-e>
    endif
    let &scrolloff = l:scrolloffsave
endfunction
 
function! DelEmptyLineBelow()
    if line(".") == line("$")
        return
    endif
    let l:line = getline(line(".") + 1)
    if l:line =~ '^\s*$'
        let l:colsave = col(".")
        .+1d
        ''
        call cursor(line("."), l:colsave)
    endif
endfunction
 
function! AddEmptyLineBelow()
    call append(line("."), "")
endfunction

" Arrow key remapping: Up/Dn = move line up/dn; Left/Right = indent/unindent
function! SetArrowKeysAsTextShifters()
    " normal mode
    nmap <silent> <Left> <<
    nmap <silent> <Right> >>
    nnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>
    nnoremap <silent> <Down>  <Esc>:call AddEmptyLineAbove()<CR>
    nnoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>
    nnoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>
 
    " visual mode
    vmap <silent> <Left> <
    vmap <silent> <Right> >
    vnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>gv
    vnoremap <silent> <Down>  <Esc>:call AddEmptyLineAbove()<CR>gv
    vnoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>gv
    vnoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>gv
 
    " insert mode
    imap <silent> <Left> <C-D>
    imap <silent> <Right> <C-T>
    inoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>a
    inoremap <silent> <Down> <Esc>:call AddEmptyLineAbove()<CR>a
    inoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>a
    inoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>a
 
    " disable modified versions we are not using
    nnoremap  <S-Up>     <NOP>
    nnoremap  <S-Down>   <NOP>
    nnoremap  <S-Left>   <NOP>
    nnoremap  <S-Right>  <NOP>
    vnoremap  <S-Up>     <NOP>
    vnoremap  <S-Down>   <NOP>
    vnoremap  <S-Left>   <NOP>
    vnoremap  <S-Right>  <NOP>
    inoremap  <S-Up>     <NOP>
    inoremap  <S-Down>   <NOP>
    inoremap  <S-Left>   <NOP>
    inoremap  <S-Right>  <NOP>
endfunction
 
call SetArrowKeysAsTextShifters()

