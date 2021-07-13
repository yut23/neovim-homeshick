" ftdetect/amrex.H.vim

" vint: -ProhibitAutocmdWithNoGroup
" According to :h ftdetect, the augroup is set before this file is sourced.

autocmd BufRead,BufNewFile *.H setfiletype cpp
