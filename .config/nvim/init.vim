" VIM-PLUG START ===============
" https://github.com/junegunn/vim-plug
" Specify a directory for plugins
" Plug itself is installed in ~/.local/share/nvim/site/autoload/plug.vim
"
" PlugInstall :: Install plugins
" PlugUpdate :: Install or update plugins
" PlugClean[!] :: Remove unused directories (bang version will clean without prompt)
" PlugUpgrade :: Upgrade vim-plug itself
" PlugStatus :: Check the status of plugins
" PlugDiff :: Examine changes from the previous update and the pending changes
" PlugSnapshot[!] :: Generate script for restoring the current snapshot of the plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'https://github.com/pangloss/vim-javascript'
Plug 'https://github.com/mxw/vim-jsx'
Plug 'https://github.com/mhartington/oceanic-next'
Plug 'vim-airline/vim-airline'
Plug 'lifepillar/vim-solarized8'
Plug 'nvie/vim-flake8'

" Initialize plugin system
call plug#end()

" VIM-PLUG END ===============

" Turn on filetype detection
filetype plugin indent on
syntax enable

" Turn off vim's backup system. Because you're using git or hg, right? right?
set nobackup
set nowritebackup
"
" Turn off the swap files. As far as I can tell, it just annoys me
set noswapfile

" Don't use Ex mode. Use Q for formatting
map Q gq

" add a bit of leading
set linespace=2

" Tabs and whitespace
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set smartindent

" use relative instead of absolute line numbers
set relativenumber

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

" scroll up and down one line in an intuitive manner
nnoremap j gj
nnoremap k gk

" easier to swap between vsplit windows.
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

"in normal mode, press space to half-page down (like a webpage)·
nnoremap <space> <C-D>·

" make semicolon equal the colon. But not the other way
" this breaks the "press ; to go to next find character
" not a big deal at the moment
nnoremap ; :

" map I to jump to start of line in insert mode
nnoremap I ^i

" map K to split the line without exiting normal mode
" @brennen's version:
nnoremap K i<CR><Esc>l;

" jj to exit insert mode
inoremap jj <ESC><Paste>

" highlight tabs and trailing spaces
nmap <silent> <leader>s :set nolist!<CR>:redr<CR>
set listchars=tab:⇾\ ,trail:·
set list

" exclude .DS_Store and .pyc files from directory listings
" remember: you can always press `a` in the netrw screen to switch between 
" hiding and unhiding files
let g:netrw_list_hide= '^\.DS_Store$,^.*\.pyc$'

" mww/vim-jsx: Enable jsx highlighting in *.js files
let g:jsx_ext_required = 0

" Enable termguicolors. Needed for most neovim color schemes
if (has("termguicolors"))
 set termguicolors
endif
colorscheme OceanicNext

" Make comments italic
highlight Comment cterm=italic

