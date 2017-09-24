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
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" utilities
Plug 'ntpeters/vim-better-whitespace'
Plug 'rickhowe/diffchar.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-unimpaired'

" syntax
Plug 'sheerun/vim-polyglot'

" completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'

" coding
Plug 'neomake/neomake'

" haskell
Plug 'parsonsmatt/intero-neovim'
Plug 'eagletmt/neco-ghc'
Plug 'itchyny/vim-haskell-indent'

"Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" python
Plug 'somini/pydoc.vim'
Plug 'zchee/deoplete-jedi'

" MIPS
Plug 'harenome/vim-mipssyntax'

" other
Plug 'christoomey/vim-tmux-navigator'

call plug#end()
