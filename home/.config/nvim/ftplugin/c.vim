" ftplugin/c.vim
" Combined C/C++ ftplugin
" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using 'o'.
setlocal fo-=t fo+=croql/

" ALE linters
let b:ale_linters = ['ccls', 'cppcheck']
let b:ale_linters += ['clangtidy']

let b:ale_fixers = ['clang-format']

let b:ale_fix_on_save = 1

let b:ale_c_clangtidy_checks = ['-security.insecureAPI.DeprecatedOrUnsafeBufferHandling', '-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling']
let b:ale_cpp_clangtidy_checks = b:ale_c_clangtidy_checks

let b:ale_c_cppcheck_options = '--enable=style --inline-suppr'
let b:ale_cpp_cppcheck_options = b:ale_c_cppcheck_options
let b:ale_c_ccls_init_options = g:lsp_settings['ccls']
let b:ale_cpp_ccls_init_options = b:ale_c_ccls_init_options
