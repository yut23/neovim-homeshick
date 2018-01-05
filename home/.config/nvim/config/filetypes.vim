" config/filetypes.vim

" set Haskell indentation
autocmd FileType haskell setlocal tabstop=8 expandtab softtabstop=4 shiftwidth=4 shiftround

" Set Erlang omnifunc
autocmd FileType erlang setlocal omnifunc=erlang_complete#Complete

" set Prolog indentation
autocmd FileType swiprolog setlocal tabstop=4 expandtab softtabstop=4 shiftwidth=4
