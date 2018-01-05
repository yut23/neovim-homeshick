" config/init.vim

" automatically install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.local/share/nvim/plugged')

" colorschemes
Plug 'justinmk/molokai'

" ui
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" utilities
Plug 'ntpeters/vim-better-whitespace'
Plug 'rickhowe/diffchar.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'sjl/gundo.vim'
Plug 'thinca/vim-ref'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" syntax
Plug 'sheerun/vim-polyglot'

" completion
Plug 'ervandew/supertab'
if ! g:minimal_rc
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  " coding
  Plug 'neomake/neomake'

  " erlang
  Plug 'vim-erlang/vim-erlang-omnicomplete'

  " haskell
  Plug 'eagletmt/neco-ghc'
  Plug 'itchyny/vim-haskell-indent'
  Plug 'parsonsmatt/intero-neovim'

  " MIPS
  Plug 'harenome/vim-mipssyntax'

  " prolog
  Plug 'soli/prolog-vim'

  " python
  Plug 'zchee/deoplete-jedi'
endif

" other
Plug 'christoomey/vim-tmux-navigator'

call plug#end()
