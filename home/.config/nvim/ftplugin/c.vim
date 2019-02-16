" ftplugin/c.vim

" ALE linters
let b:ale_linters = ['ccls', 'cppcheck']
let b:ale_linters += ['clangtidy']

let b:ale_fixers = ['clang-format']

let b:ale_fix_on_save = 1

let g:ale_c_ccls_init_options = {
      \ 'cacheDirectory': '/tmp/ccls'
      \ }
