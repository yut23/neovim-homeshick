" ftplugin/erlang.vim
" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif

" Set omnifunc
setlocal omnifunc=erlang_complete#Complete
