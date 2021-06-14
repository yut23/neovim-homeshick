" ftplugin/c.vim
" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" ALE linters
let b:ale_linters = ['ccls', 'cppcheck']
let b:ale_linters += ['clangtidy']

let b:ale_fixers = ['clang-format']

let b:ale_fix_on_save = 1

let g:ale_c_ccls_init_options = {
      \ 'cacheDirectory': '/tmp/ccls'
      \ }
