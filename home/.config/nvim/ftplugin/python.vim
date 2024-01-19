" ftplugin/python.vim
"" Only do this when not done yet for this buffer
"if exists('b:did_ftplugin')
"  finish
"endif

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using 'o'.
setlocal fo-=t fo+=croql/

" ALE linters
let b:ale_linters = ['pylint', 'mypy', 'bellybutton', 'ruff']
let b:ale_fixers = ['black', 'isort']
" Initialize this variable so we can add to it in autocmds or .lvimrc
let b:ale_linters_ignore = []

let b:ale_fix_on_save = 1

" use globally-installed black and isort
let g:ale_python_black_executable = 'black'
let g:ale_python_black_use_global = 1
let g:ale_python_isort_executable = 'isort'
let g:ale_python_isort_use_global = 1

let g:ale_python_isort_options = '--profile black'

" pylint
" always use multiple cores (overrides project-specific settings)
" this seems to reduce run times, even for checking a single file
let g:ale_python_pylint_options = '--jobs 2'

" mypy
let g:ale_python_mypy_options = '--strict --allow-untyped-defs --implicit-reexport --ignore-missing-imports'
" We have other linters to take care of syntax errors
let b:ale_python_mypy_ignore_invalid_syntax = 1

" ruff
" don't try changing to the project directory in fugitive blob buffers
if expand('%s') =~# '^fugitive:/'
  let b:ale_python_ruff_change_directory = 0
endif
" ignore implicit namespace package complaints for fugitive blob buffers
" This is supposed to be {'fugitive:/**': ['INP001']}, but there's no way to
" escape the first colon.
let b:ale_python_ruff_options = '--extend-per-file-ignores ''fugitive?/**:INP001'''

" pyls
let b:ale_python_pyls_extra_args = [
\   '-vv',
\   '--log-file', expand('/tmp/pyls.log')
\]

let b:ale_python_pyls_config = g:lsp_settings['pyls']

" vim-snippets
" documentation style
let g:ultisnips_python_style = 'sphinx'

" jedi-vim pydoc
if has_key(g:plugs, 'jedi-vim')
  nnoremap <silent> <buffer> K :call jedi#show_documentation()<CR>
endif

" disable keys
let g:jedi#goto_command = ''
let g:jedi#goto_assignments_command = ''
let g:jedi#rename_command = ''
let g:jedi#usages_command = ''
