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
