" config/keys.vim

" Fix mappings in vim
if !has('nvim')
  if $TERM =~# 'tmux\|screen'
    set <xUp>=[1;*A
    set <xDown>=[1;*B
    set <xRight>=[1;*C
    set <xLeft>=[1;*D
    set <xHome>=[1;*H
    set <xEnd>=[1;*F
    set <xF1>=[1;*P
    set <xF2>=[1;*Q
    set <xF3>=[1;*R
    set <xF4>=[1;*S
    set <Del>=[3;*~
  endif
  if !has('patch-8.1.2134') || has('patch-8.1.2145')
    " Custom libvte ctrl-backspace (xterm modifyOtherKeys / CSI u format)
    " Patch 2134 adds built-in handling for modifyOtherKeys, so everything
    " just works, but 2145 breaks mappings for C-H, C-L, etc. after C-BS is
    " pressed, because vim expects that all keys will generate the modified
    " codes (which is not the case for my simple libvte patch).
    set <BS>=[127;*u
    " normal, visual, select, and operator-pending
    map  <BS>
    " insert and command-line
    map!  <BS>
  end
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
  nmap <Leader>al <Plug>(ale_lint)
  nmap <Leader>ah <Plug>(ale_hover)
  nmap <Leader>ar <Plug>(ale_find_references)
endif

"" Other Shortcuts

" Leave terminal mode with escape
if exists(':tnoremap')
  tnoremap <Esc> <C-\><C-N>
endif

" Use C-/ to comment current line in insert mode, or a block of lines in visual mode
nmap <C-/> <Plug>NERDCommenterToggle<CR>
xmap <C-/> <Plug>NERDCommenterToggle<CR>gv
" Terminal sends <C-_> instead of <C-/>
nmap <C-_> <Plug>NERDCommenterToggle<CR>
xmap <C-_> <Plug>NERDCommenterToggle<CR>gv
" Use default mappings as well
nmap <Leader>c<Space> <Plug>NERDCommenterToggle<CR>
xmap <Leader>c<Space> <Plug>NERDCommenterToggle<CR>gv

if ! g:minimal_rc
  function ALE_LC_maps()
    let l:ale_language_clients = {'c': 'ccls', 'cpp': 'ccls', 'cuda': 'ccls', 'objc': 'ccls'}
    if has_key(l:ale_language_clients, &filetype)
      nnoremap <buffer> <silent> <C-Q> <Plug>(ale_hover)
      nnoremap <buffer> <silent> gd <Plug>(ale_go_to_definition)
      " Apparently <S-F6> is <F18> in Terminator.
      nnoremap <buffer> <silent> <F18> <Plug>(ale_rename)
      nnoremap <buffer> <silent> <S-F6> <Plug>(ale_rename)
      nnoremap <buffer> <silent> <Leader>r <Plug>(ale_rename)
      nnoremap <buffer> <silent> <F7> <Plug>(ale_find_references)
    endif
  endfunction
  augroup ALE_LC
    autocmd!
    autocmd FileType * call ALE_LC_maps()
  augroup END
endif

" delete back word with Ctrl-Backspace (^H in most terminals) and forward word with Ctrl-Delete
map!  <C-W>
map! <C-BS> <C-W>
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

" Digraphs
digraph -^ 8593  " UPWARDS ARROW

" vim-asterisk mappings
" The z prefix makes the cursor stay at the current word instead of jumping
" to the next match.
if has_key(g:plugs, 'vim-asterisk')
  map *  <Plug>(asterisk-z*)
  map #  <Plug>(asterisk-z#)
  map g* <Plug>(asterisk-gz*)
  map g# <Plug>(asterisk-gz#)
endif
