" ftplugin/cuda.vim
" CUDA ftplugin
" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif

" Behaves mostly just like C++
runtime! ftplugin/c.vim ftplugin/c_*.vim ftplugin/c/*.vim

" ALE settings
" this check is needed so we don't change values overridden by the user or a
" .lvimrc file if polyglot resets the filetype on BufWritePost (e.g.
" polyglot#detect#H() for *.h files)
if !exists('b:ale_ftplugin_cuda_already_run')
  let b:ale_linters = lh#list#push_if_new(b:ale_linters, 'nvcc')
  let b:ale_linters_ignore = lh#list#push_if_new(b:ale_linters_ignore, 'cppcheck')

  let b:ale_ftplugin_cuda_already_run = 1
endif
