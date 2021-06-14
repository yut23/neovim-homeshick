" config/keys.vim

"" Movement Shortcuts

" move vertically by visual line
nnoremap j gj
nnoremap k gk

"" Leader Shortcuts

" Much more convienient than \
let mapleader = "\<Space>"

" Faster save and quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" Write, darn you!
nnoremap <Leader>W :w!<CR>
" Die!
nnoremap <Leader>Q :q!<CR>

" za is so awkward
nnoremap <Leader>z za

nnoremap <silent> <Leader>hi :let @/ = ""<CR>

nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>u :UndotreeToggle<CR>

nnoremap <silent> <Leader>gg :GitGutter<CR>

if ! g:minimal_rc
  nmap <Leader>al <plug>(ale_lint)
  nmap <Leader>ah <plug>(ale_hover)
  nmap <Leader>ar <plug>(ale_find_references)
endif

"" Other Shortcuts

" Leave terminal mode with escape
tnoremap <Esc> <C-\><C-n>

" Use C-/ to comment current line in insert mode, or a block of lines in visual mode
nmap <C-_> <plug>NERDCommenterToggle<CR>
vmap <C-_> <plug>NERDCommenterToggle<CR>gv

if ! g:minimal_rc
  function LC_maps()
    if has_key(g:LanguageClient_serverCommands, &filetype)
      "nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
      nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
      " Apparently <S-F6> is <F18> in Terminator.
      nnoremap <buffer> <silent> <F18> :call LanguageClient#textDocument_rename()<CR>
      nnoremap <buffer> <silent> <S-F6> :call LanguageClient#textDocument_rename()<CR>
      nnoremap <buffer> <silent> <F7> :call LanguageClient#textDocument_references()<CR>
    endif
  endfunction
  augroup LCneovim
    autocmd!
    autocmd FileType * call LC_maps()
  augroup END
endif

" delete back word with Ctrl-Backspace (^H in most terminals) and forward word with Ctrl-Delete
imap  <C-W>
imap <C-BS> <C-W>
inoremap <C-Del> <C-G>u<C-O>de

" disable help.txt on F1
nnoremap <F1> <nop>
inoremap <F1> <nop>
" starts ex mode
nnoremap Q <nop>

" fix inconsistency between D, C, and Y
nnoremap Y y$

" move gi (jump to last place insert mode was exited) to gI
" use gi for `. (jump to last changed position)
nnoremap gI gi
nnoremap gi `.

" Show unicode info with ga
nmap ga <Plug>(UnicodeGA)

" Completion menu/supertab replacement
inoremap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"

" Insert selected match with cursor keys as well
inoremap <expr> <Up> pumvisible() ? "\<C-P>" : "\<Up>"
inoremap <expr> <Down> pumvisible() ? "\<C-N>" : "\<Down>"

" CR mapping from https://github.com/ncm2/ncm2/issues/163
" Insert newline only if nothing changes after accepting the current match
"inoremap <expr> <Plug>(cr_prev) execute('let g:_prev_line = getline(".")')
"inoremap <expr> <Plug>(cr_do) (g:_prev_line == getline('.') ? "\<cr>" : "")
"inoremap <expr> <Plug>(cr_post) execute('unlet g:_prev_line')

function! HandleCR() abort
  if !pumvisible()
    return "\<CR>"
  endif
  if empty(v:completed_item) || !b:ncm2_enable
    " no info about whether a completion item is selected, so close menu and insert <CR>
    "echo 'no info'
    return "\<C-Y>\<CR>"
  endif
  " now we know v:completed_item is not empty and ncm2 is enabled
  if empty(v:completed_item.user_data)
    " no completion item selected
    "echo 'no completion item selected'
    return "\<C-Y>\<CR>"
  endif
  " otherwise, just close the menu
  "echo 'closing menu'
  return "\<C-Y>"
endfunction
"imap <expr> <CR> (pumvisible() ? "\<Plug>(cr_prev)\<C-Y>\<Plug>(cr_do)\<Plug>(cr_post)" : "\<CR>")
"imap <expr> <Plug>(cr_hook) ""
"imap <expr> <Plug>(cr_do) ((empty(v:completed_item) || (!b:ncm2_enable || empty(v:completed_item.user_data))) ? "\<CR>" : "")
"imap <expr> <CR>
"      \ !pumvisible() ? "\<CR>" :
"      \ empty(v:completed_item) \|\| (!b:ncm2_enable \|\| empty(v:completed_item.user_data))
"      \ ? "\<C-Y>\<CR>"
"      \ : "\<C-Y>\<Plug>(cr_hook)"
"imap <expr> <Plug>(HandleCR) HandleCR()
imap <expr> <CR> HandleCR()
