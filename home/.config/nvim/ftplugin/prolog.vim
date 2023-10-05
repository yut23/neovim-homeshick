" ftplugin/erlang.vim
" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" set indentation
setlocal tabstop=4 expandtab shiftwidth=4
