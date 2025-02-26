" ftdetect/ipynb.vim

" vint: -ProhibitAutocmdWithNoGroup
" According to :h ftdetect, the augroup is set before this file is sourced.

" set indent width to 1 for Jupyter notebooks so folds work properly
autocmd BufRead,BufNewFile *.ipynb setlocal shiftwidth=1
