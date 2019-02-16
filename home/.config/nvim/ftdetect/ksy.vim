" ftdetect/ksy.vim

" vint: -ProhibitAutocmdWithNoGroup
" According to :h ftdetect, the augroup is set before this file is sourced.

" use YAML syntax for Kaitai Struct files
autocmd BufRead,BufNewFile *.ksy setfiletype yaml
