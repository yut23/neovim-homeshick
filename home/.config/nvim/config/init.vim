" config/init.vim

" automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  call mkdir(data_dir . '/autoload', 'p')
  silent execute '!curl -fLo '.shellescape(data_dir).'/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  " work around https://github.com/neovim/neovim/issues/28128
  let &runtimepath = &runtimepath
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

" syntax
" can't do comments inside a multiline list, so this will have to do
let g:polyglot_disabled = []
" broken for any sort of advanced expansion; the default zsh syntax works well
" enough
let g:polyglot_disabled += ['zinit']
" using my own forks below
let g:polyglot_disabled += ['python', 'python-indent']
" using vim-pandoc-syntax instead
let g:polyglot_disabled += ['markdown']
" conflicts with *.ll for llvm (it's some genealogy software)
let g:polyglot_disabled += ['lifelines']

Plug 'sheerun/vim-polyglot'
Plug 'sukima/xmledit'
Plug 'yut23/vim-python-pep8-indent', {'branch': 'personal'}
Plug 'yut23/python-syntax', {'branch': 'pep_622'}
Plug 'factor/factor.vim'

if g:vimcat
  call plug#end()
  finish
endif

" ui
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" utilities
Plug 'AndrewRadev/linediff.vim'
Plug 'chrisbra/unicode.vim'
Plug 'FooSoft/vim-argwrap'
Plug 'haya14busa/vim-asterisk'
Plug 'jremmen/vim-ripgrep', Cond(executable('rg'))
"Plug 'junegunn/vim-peekaboo'
Plug 'justinmk/vim-sneak'
Plug 'mbbill/undotree'
Plug 'ntpeters/vim-better-whitespace'
"Plug 'rickhowe/diffchar.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'thinca/vim-ref'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

" other
Plug 'christoomey/vim-tmux-navigator'
Plug 'LucHermitte/lh-vim-lib'

Plug 'moll/vim-bbye' " optional dependency
Plug 'aymericbeaumet/vim-symlink'

Plug 'editorconfig/editorconfig-vim'

" local vimrc
Plug 'embear/vim-localvimrc'

if g:rc_level >= 1
  " coding
  Plug 'dense-analysis/ale'
  Plug 'wellle/context.vim'

  " python
  " jedi-vim for documentation support
  Plug 'davidhalter/jedi-vim'

  " Pandoc
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
endif

if g:rc_level >= 2
  " coding
  Plug 'ncm2/ncm2'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc', Cond(!has('nvim'))

  " LSP
  Plug 'prabirshrestha/vim-lsp'
  Plug 'rhysd/vim-lsp-ale'

  " ncm2 sources
  Plug 'ncm2/ncm2-bufword'
  Plug 'ncm2/ncm2-path'
  Plug 'fgrsnau/ncm2-otherbuf'
  Plug 'ncm2/ncm2-jedi'
  Plug 'ncm2/ncm2-vim-lsp'

  " snippets
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'ncm2/ncm2-ultisnips'
endif

if hostname() ==? 'mandelbrot'
  " ActionScript
  Plug 'jeroenbourgois/vim-actionscript'

  " haskell
  Plug 'itchyny/vim-haskell-indent'
  Plug 'parsonsmatt/intero-neovim'

  " Kerboscript (kOS)
  Plug 'KSP-KOS/EditorTools', {'branch': 'develop', 'rtp': 'VIM/vim-kerboscript'}

  " Crafttweaker/Zenscript
  Plug 'DaeZak/crafttweaker-vim-highlighting'

  " MIPS
  Plug 'harenome/vim-mipssyntax'

  " udev rules
  Plug 'wilriker/udev-vim-syntax'
endif

call plug#end()
