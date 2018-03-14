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
nnoremap <Leader>u :GundoToggle<CR>

" Leave terminal mode with escape
tnoremap <Esc> <C-\><C-n>

nmap <C-_> <plug>NERDCommenterToggle<CR>
vmap <C-_> <plug>NERDCommenterToggle<CR>gv
