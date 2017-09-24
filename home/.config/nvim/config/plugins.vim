" config/plugins.vim
" Plugin configuration

" vim-airline
" -----------
set laststatus=2        " always show the status line
set noshowmode          " airline handles this

let g:airline_theme             = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_powerline_fonts   = 1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'


" better-whitespace
" -----------------
let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'unite', 'qf', 'help', 'man', 'pydoc']


" Neomake
" -------
" enable automake on write
call neomake#configure#automake('w')

" use clang-tidy on C and C++ files
let g:neomake_c_enabled_makers = ['clangtidy']
let g:neomake_cpp_enabled_makers = ['clangtidy']

" automatically open location-list/quickfix window, but preserve cursor position
let g:neomake_open_list = 2


" supertab
" --------
let g:SuperTabDefaultCompletionType = "<c-n>"


" deoplete
" --------
" Use deoplete.
let g:deoplete#enable_at_startup = 1
autocmd CompleteDone * pclose " To close preview window of deoplete automagically
" deoplete-jedi
let g:deoplete#sources#jedi#show_docstring = 1


" vim-pydoc
" ---------
let g:pydoc_open_cmd = 'new'
let g:pydoc_highlight = 0
"let g:pydoc_window_lines = 0.5


" Haskell
" -------
" intero-neovim
augroup interoMaps
  au!
  " Maps for intero. Restrict to Haskell buffers so the bindings don't collide.

  " Background process and window management
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  " Open intero/GHCi split horizontally
  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  " Open intero/GHCi split vertically
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>

  " Automatically reload on write
  au BufWritePost *.hs InteroReload
  " Disable neomake automake on write
  au FileType haskell call neomake#configure#automake_for_buffer('')

  " Load individual modules
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  au FileType haskell map <silent> <leader>t <Plug>InteroGenericType
  au FileType haskell map <silent> <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  " Navigation
  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
augroup END

" Intero starts automatically. Set this to 0 if you'd like to prevent that.
let g:intero_start_immediately = 1
