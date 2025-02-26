" ftplugin/lua.vim
"" Only do this when not done yet for this buffer
"if exists('b:did_ftplugin')
"  finish
"endif

" this check is needed so we don't change values overridden by the user or a
" .lvimrc file if polyglot resets the filetype on BufWritePost (e.g.
" polyglot#detect#H() for *.h files)
if !exists('b:ale_ftplugin_already_run')
  let b:ale_fixers = ['luaformatter']
  let b:ale_fix_on_save = 1

  let b:ale_ftplugin_already_run = 1
endif
