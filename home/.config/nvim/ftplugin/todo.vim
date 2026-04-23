" ftplugin/todo.vim
scriptencoding utf-8

" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR>.

" defaults:
" tc: automatic formatting for comments and text (list items are comments)
" q: allow formatting of comments with 'gq'
" j: remove comment leader when joining lines
setlocal formatoptions=tcqj
" r: insert comment leader after hitting <Enter> in Insert mode
" o: insert comment leader after hitting 'o' or 'O' in Normal mode
setlocal formatoptions+=r

setlocal comments=fb:-,fb:*,fb:✓,b:#
setlocal commentstring=#\ %s

setlocal textwidth=79
