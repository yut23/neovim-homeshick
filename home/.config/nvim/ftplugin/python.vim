" ftplugin/python.vim
"" Only do this when not done yet for this buffer
"if exists('b:did_ftplugin')
"  finish
"endif

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR>.
setlocal fo-=t fo+=crql/

" ALE settings
" this check is needed so we don't change values overridden by the user or a
" .lvimrc file if polyglot resets the filetype on BufWritePost (e.g.
" polyglot#detect#H() for *.h files)
if !exists('b:ale_ftplugin_already_run')
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
  "let g:ale_python_mypy_options = '--strict --allow-untyped-defs --implicit-reexport --ignore-missing-imports --no-silence-site-packages'
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

  let b:ale_ftplugin_already_run = 1
endif

" vim-snippets
" documentation style
let g:ultisnips_python_style = 'sphinx'

" jedi-vim mappings
if has_key(g:plugs, 'jedi-vim')
  nnoremap <buffer> <silent> K :call jedi#show_documentation()<CR>
  nnoremap <buffer> <silent> gd :call jedi#goto()<CR>
  nnoremap <buffer> <silent> <Leader>r :call jedi#rename()<CR>
  " default JetBrains mapping
  nnoremap <buffer> <silent> <S-F6> :call jedi#rename()<CR>
  " Apparently <S-F6> is <F18> in Terminator
  nnoremap <buffer> <silent> <F18> :call jedi#rename()<CR>
  nnoremap <buffer> <silent> <F7> :call jedi#usages()<CR>
endif

" disable keys
let g:jedi#goto_command = ''
let g:jedi#goto_assignments_command = ''
let g:jedi#rename_command = ''
let g:jedi#usages_command = ''
