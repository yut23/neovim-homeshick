" config/keys.vim

" Fix mappings in vim
if !has('nvim')
  if $TERM ==# 'tmux-256color'
    set <xUp>=[@;*A
    set <xDown>=[@;*B
    set <xRight>=[@;*C
    set <xLeft>=[@;*D
    set <xHome>=[1;*H
    set <xEnd>=[1;*F
    set <xF1>=[1;*P
    set <xF2>=[1;*Q
    set <xF3>=[1;*R
    set <xF4>=[1;*S
    set <Del>=[3;*~
  endif
  " Custom ctrl-backspace (CSI u)
  map <ESC>[127;5u <C-BS>
  map! <ESC>[127;5u <C-BS>
endif

"" Movement Shortcuts

" move vertically by visual line
nnoremap j gj
nnoremap k gk
" only in visual mode, not select mode
xnoremap j gj
xnoremap k gk

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
if exists(':tnoremap')
  tnoremap <Esc> <C-\><C-N>
endif

" Use C-/ to comment current line in insert mode, or a block of lines in visual mode
nmap <C-_> <plug>NERDCommenterToggle<CR>
xmap <C-_> <plug>NERDCommenterToggle<CR>gv
" Use default mappings as well
nmap <Leader>c<Space> <plug>NERDCommenterToggle<CR>
xmap <Leader>c<Space> <plug>NERDCommenterToggle<CR>gv

if ! g:minimal_rc
  function LC_maps()
    if has_key(g:LanguageClient_serverCommands, &filetype)
      nnoremap <buffer> <silent> <C-Q> :call LanguageClient#textDocument_hover()<CR>
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

function! HandleCR() abort
  if !pumvisible()
    return "\<CR>"
  endif
  if exists('b:ncm2_enable')
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
    " check if the selected item is a snippet, and insert it if so
    if exists('g:ncm2_ultisnips#source')
      if ncm2_ultisnips#completed_is_snippet()
        "echo 'expanding snippet'
        return "\<C-Y>\<Plug>(ncm2_ultisnips_expand_completed)"
      endif
    endif
  endif
  " otherwise, just close the menu
  "echo 'closing menu'
  return "\<C-Y>"
endfunction
imap <expr> <CR> HandleCR()
