" ftplugin/haskell.vim
" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif

" set indentation
setlocal tabstop=8 expandtab shiftwidth=4 shiftround

" ALE
if has_key(g:plugs, 'ale')
  " this check is needed so we don't change values overridden by the user or a
  " .lvimrc file if polyglot resets the filetype on BufWritePost (e.g.
  " polyglot#detect#H() for *.h files)
  if !exists('b:ale_ftplugin_already_run')
    let b:ale_fixers = ['hlint']
    let b:ale_linters = ['hie', 'hfmt', 'hlint']

    "let g:ale_haskell_hfmt_executable = 'stack exec -- hfmt'
    "let g:ale_haskell_hlint_executable = 'stack'
    "let g:ale_haskell_hlint_options = 'exec -- hlint'

    let b:ale_ftplugin_already_run = 1
  endif
endif

" intero-neovim
if has_key(g:plugs, 'intero-neovim')
  " Maps for intero. Restrict to Haskell buffers so the bindings don't collide.

  " Background process and window management
  nnoremap <buffer> <silent> <leader>is :InteroStart<CR>
  nnoremap <buffer> <silent> <leader>ik :InteroKill<CR>

  " Open intero/GHCi split horizontally
  nnoremap <buffer> <silent> <leader>io :InteroOpen<CR>
  " Open intero/GHCi split vertically
  nnoremap <buffer> <silent> <leader>iov :InteroOpen<CR><C-W>H
  nnoremap <buffer> <silent> <leader>ih :InteroHide<CR>

  " Automatically reload on write
  augroup interoReload
    autocmd!
    autocmd BufWritePost *.hs InteroReload
  augroup END
  " Disable neomake automake on write
  "au FileType haskell call neomake#configure#automake_for_buffer('')

  " Load individual modules
  nnoremap <buffer> <silent> <leader>il :InteroLoadCurrentModule<CR>
  nnoremap <buffer> <silent> <leader>if :InteroLoadCurrentFile<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  map <buffer> <silent> <leader>t <Plug>InteroGenericType
  map <buffer> <silent> <leader>T <Plug>InteroType
  nnoremap <buffer> <silent> <leader>it :InteroTypeInsert<CR>

  " Navigation
  nnoremap <buffer> <silent> gd :InteroGoToDef<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  nnoremap <buffer> <leader>ist :InteroSetTargets<SPACE>

  " Intero starts automatically. Set this to 0 if you'd like to prevent that.
  let g:intero_start_immediately = 1
endif
