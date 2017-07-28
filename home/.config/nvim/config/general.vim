" config/general.vim

"" Colors {{{
set termguicolors
colorscheme molokai
set background=dark
" }}}

"" Misc {{{
set splitbelow          " split in a sensible manner
set splitright

" More effective block editing
set virtualedit=block

" Mark columns 80 and 90, and past 120
let &colorcolumn="80,90,120"

" Decrease delay on escape
set ttimeoutlen=50

" use system clipboard
set clipboard+=unnamed
" automatically copy visual selection to system clipboard
vmap <LeftRelease> "*ygv

" man pages?
" }}}

"" Spaces and Tabs {{{
set tabstop=2           " number of visual spaces per tab
set softtabstop=2       " number of spaces in tab when editing
set shiftwidth=2        " number of spaces in tab when reindenting
set expandtab           " tabs are spaces
" }}}

"" UI Config {{{
set ruler               " always show the cursor position
set number              " line numbers
set title               " display a title
set cursorline          " highlight current line

set wildmode=list:longest
set lazyredraw          " redraw only when necessary (faster macros)

set scrolloff=2         " don't let it touch the edge!

"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=2
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
set mouse=a
" }}}

"" Searching {{{
set ignorecase          " We don't care about case...
set smartcase           " ...or do we? Only if there are uppercase letters
" }}}

"" Folding {{{
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level
" }}}

"" Backups {{{
set backup
set backupdir=~/.local/share/nvim/backup
" }}}

" vim:foldmethod=marker
