" ftplugin/python.vim

" ALE linters
"let b:ale_enabled = 0
let b:ale_linters = ['pylint', 'mypy']

" mypy
" We have other linters to take care of syntax errors
let b:ale_python_mypy_ignore_invalid_syntax = 1
let b:ale_python_mypy_options = '--strict --allow-untyped-defs'

" pyls
let b:ale_python_pyls_extra_args = [
\   '-vv',
\   '--log-file', expand('/tmp/pyls.log')
\]

"let b:ale_python_pyls_config = {
"      \ 'pyls': {
"      \   'plugins': {
"      \     'pycodestyle': {
"      \       'enabled': v:false
"      \     },
"      \     'pyflakes': {
"      \       'enabled': v:false
"      \     }
"      \   }
"      \ }}

" jedi-vim pydoc
nnoremap <silent> <buffer> K :call jedi#show_documentation()<CR>

" disable keys
let g:jedi#goto_command = ''
let g:jedi#goto_assignments_command = ''
let g:jedi#rename_command = ''
let g:jedi#usages_command = ''
