" config/init.vim

" automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  augroup vimplug_install
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif


" from https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin((has('nvim') ? stdpath('data') : '~/.vim') . '/plugged')

" add help files
Plug 'junegunn/vim-plug'

" colorschemes
Plug 'justinmk/molokai'

" ui
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" utilities
Plug 'chrisbra/unicode.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'junegunn/vim-peekaboo'
Plug 'mbbill/undotree'
Plug 'mileszs/ack.vim', Cond(executable('ag'))
Plug 'ntpeters/vim-better-whitespace'
"Plug 'rickhowe/diffchar.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'thinca/vim-ref'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

" syntax
Plug 'sheerun/vim-polyglot'
Plug 'sukima/xmledit'

" other
Plug 'christoomey/vim-tmux-navigator'
Plug 'LucHermitte/lh-vim-lib'

" local vimrc
Plug 'embear/vim-localvimrc'

if ! g:minimal_rc
  " coding
  Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
  Plug 'ncm2/ncm2'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc', Cond(!has('nvim'))
  Plug 'dense-analysis/ale'

  " ncm2 sources
  Plug 'ncm2/ncm2-bufword'
  Plug 'ncm2/ncm2-path'
  Plug 'fgrsnau/ncm2-otherbuf'

  " snippets
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'ncm2/ncm2-ultisnips'

  " python
  " jedi-vim for documentation support
  Plug 'davidhalter/jedi-vim'
  Plug 'ncm2/ncm2-jedi'

  " Pandoc
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
endif

if hostname() ==? 'mandelbrot'
  " haskell
  Plug 'itchyny/vim-haskell-indent'
  Plug 'parsonsmatt/intero-neovim'

  " Kerboscript (kOS)
  Plug 'KSP-KOS/EditorTools', {'branch': 'develop', 'rtp': 'VIM/vim-kerboscript'}

  " MIPS
  Plug 'harenome/vim-mipssyntax'

  " udev rules
  Plug 'wilriker/udev-vim-syntax'
endif

call plug#end()
