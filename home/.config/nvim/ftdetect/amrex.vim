" ftdetect/amrex.vim

" vint: -ProhibitAutocmdWithNoGroup
" According to :h ftdetect, the augroup is set before this file is sourced.

autocmd BufRead,BufNewFile *.H setfiletype cpp
autocmd BufRead,BufNewFile *.F90 setfiletype fortran
autocmd BufRead,BufNewFile Make.* setfiletype make
