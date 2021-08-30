" config/general.vim
" vim: foldmethod=marker
scriptencoding utf-8

let s:data_dir = $HOME . '/.local/share/nvim/'
"if has('nvim')
"  let s:data_dir = stdpath('data')
"else
"  let s:data_dir = $HOME . '/.local/share/vim/'
"endif

"" Colors {{{
if $TERM ==# 'linux' && $NVIM_GUI != 1
  " better theme for 8-color console
  if &diff
    colorscheme industry
  else
    colorscheme delek
  endif
else
  " pretty colors everywhere else
  colorscheme molokai
  if has('termguicolors')
    if $TERM ==# 'rxvt-unicode-256color' && $NVIM_GUI != 1
      " urxvt doesn't like true color yet
      set notermguicolors
    else
      if $TERM =~# 'tmux\|screen' && !has('nvim')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      endif
      set termguicolors
    endif
  endif
endif
set background=dark
" }}}

"" Misc {{{
set splitbelow          " split in a sensible manner
set splitright

" More effective block editing
set virtualedit=block

" Mark columns 80 and 90, and past 120
let &colorcolumn='80,90,120'

" Decrease delay on escape
set ttimeoutlen=50

" use system clipboard
set clipboard+=unnamed
" automatically copy visual selection to system clipboard
"vmap <LeftRelease> "*ygv
" enable bracketed paste in vim
if !has('nvim') && $TERM =~# 'tmux\|screen' && exists('&t_BE')
  let &t_BE = "\e[?2004h"
  let &t_BD = "\e[?2004l"
  exec "set t_PS=\e[200~"
  exec "set t_PE=\e[201~"
endif

" hooks for clipboard syncing
if filereadable(expand('~/.tmux/clipboard/vimhooks.vim'))
  source ~/.tmux/clipboard/vimhooks.vim
endif

set modeline

if exists('##TermOpen')
  " don't delete terminal buffers when switching buffers or closing windows
  " see https://github.com/neovim/neovim/issues/2368
  autocmd TermOpen * set bufhidden=hide
elseif exists('##TerminalOpen')
  " vim 8.1+ version, from terminal.txt
  autocmd TerminalOpen * if &buftype ==# 'terminal' | setlocal bufhidden=hide | endif
endif

" }}}

"" Spaces and Tabs {{{
set tabstop=2           " number of visual spaces per tab
set softtabstop=2       " number of spaces in tab when editing
set shiftwidth=2        " number of spaces in tab when reindenting
set expandtab           " tabs are spaces
set nojoinspaces        " only insert one space after [.?!] when joining lines
" }}}

"" UI Config {{{
set ruler               " always show the cursor position
set number              " line numbers
set title               " display a title
set cursorline          " highlight current line

set wildmode=list:longest
set lazyredraw          " redraw only when necessary (faster macros)

set scrolloff=2         " keep the cursor at least 2 lines from the top and bottom

" change cursor shape in insert mode
if $TERM !=# 'linux' || $NVIM_GUI == 1
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
else
  set guicursor=
endif
if !has('nvim')
  if $TEMU ==# 'konsole'
    let &t_ti.="\e]50;CursorShape=0\007"
    let &t_SI.="\e]50;CursorShape=1\007"
    let &t_EI.="\e]50;CursorShape=0\007"
    let &t_te.="\e]50;CursorShape=0\007"
  elseif $TERM !=# 'linux' && $TERM !~# 'rxvt-unicode.*'
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[5 q"
  endif
endif
set mouse=a

if has('patch-7.4.314')
  set shortmess+=c        " don't give |ins-completion-menu| messages.
endif
" for ncm2
if exists('+completeopt') && has('patch-7.4.775')
  set completeopt=noinsert,menuone,noselect
endif

" show tabs and trailing spaces as dim characters
if has('patch-8.1.759') || has('nvim-0.4.0')
  set listchars=tab:――→,trail:~,extends:>,nbsp:␣
else
  set listchars=tab:→\ ,trail:~,extends:>,nbsp:␣
endif
set list
" }}}

"" Searching {{{
set ignorecase          " See below
set smartcase           " Only case-sensitive if there are uppercase letters
" }}}

"" Folding {{{
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level
" }}}

"" Backups {{{
let &backupdir = s:data_dir . '/backup'
" Create dir
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p')
endif
set backup
" }}}

"" Undo {{{
" Keep undo history across sessions by storing it in a file
if has('nvim-0.5')
  " New format in https://github.com/neovim/neovim/pull/13973 (f42e932,
  " 2021-04-13).
  let &undodir = s:data_dir . '/undo2'
else
  let &undodir = s:data_dir . '/undo'
endif
" Create dir
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p')
endif
set undofile
" }}}

"" Commands {{{
" Open the config folder for editing
command Cfg e ~/.config/nvim | normal 3jO
" }}}
