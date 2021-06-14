" ftplugin/haskell.vim
" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" set indentation
setlocal tabstop=8 expandtab softtabstop=4 shiftwidth=4 shiftround

if ! g:minimal_rc
  " ALE
  let b:ale_fixers = ['hlint']
  let b:ale_linters = ['hie', 'hfmt', 'hlint']

  "let g:ale_haskell_hfmt_executable = 'stack exec -- hfmt'
  "let g:ale_haskell_hlint_executable = 'stack'
  "let g:ale_haskell_hlint_options = 'exec -- hlint'

  " intero-neovim
  " Maps for intero. Restrict to Haskell buffers so the bindings don't collide.

  " Background process and window management
  nnoremap <silent> <leader>is :InteroStart<CR>
  nnoremap <silent> <leader>ik :InteroKill<CR>

  " Open intero/GHCi split horizontally
  nnoremap <silent> <leader>io :InteroOpen<CR>
  " Open intero/GHCi split vertically
  nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  nnoremap <silent> <leader>ih :InteroHide<CR>

  " Automatically reload on write
  augroup interoReload
    au BufWritePost *.hs InteroReload
  augroup END
  " Disable neomake automake on write
  "au FileType haskell call neomake#configure#automake_for_buffer('')

  " Load individual modules
  nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  map <silent> <leader>t <Plug>InteroGenericType
  map <silent> <leader>T <Plug>InteroType
  nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  " Navigation
  nnoremap <silent> gd :InteroGoToDef<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  nnoremap <leader>ist :InteroSetTargets<SPACE>

  " Intero starts automatically. Set this to 0 if you'd like to prevent that.
  let g:intero_start_immediately = 1
endif
