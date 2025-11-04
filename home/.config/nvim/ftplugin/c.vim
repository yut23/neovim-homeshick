" ftplugin/c.vim
" Combined C/C++ ftplugin
" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using 'o'.
setlocal formatoptions-=t formatoptions+=croql
if has('patch-8.2.4907') || has('nvim-0.7.1')
  setlocal formatoptions+=/
endif

" ALE settings
" this check is needed so we don't change values overridden by the user or a
" .lvimrc file if polyglot resets the filetype on BufWritePost (e.g.
" polyglot#detect#H() for *.h files)
if !exists('b:ale_ftplugin_already_run')
  let b:ale_linters = ['vim-lsp', 'cppcheck']
  let b:ale_linters += ['clangtidy']
  let b:ale_linters_ignore = []

  let b:ale_fixers = ['clang-format']

  let b:ale_fix_on_save = 1

  if executable('clangd-tidy')
    let b:ale_c_clangtidy_executable = 'clangd-tidy'
    let b:ale_cpp_clangtidy_executable = b:ale_c_clangtidy_executable
    let b:ale_cuda_clangtidy_executable = b:ale_c_clangtidy_executable
    " forcibly turn off color in case it's enabled in .clang-tidy
    let b:ale_c_clangtidy_extra_options = '--color=never'
  else
    let b:ale_c_clangtidy_checks = ['-security.insecureAPI.DeprecatedOrUnsafeBufferHandling', '-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling']
    let b:ale_cpp_clangtidy_checks = b:ale_c_clangtidy_checks
    let b:ale_cuda_clangtidy_checks = b:ale_c_clangtidy_checks
    " forcibly turn off color in case it's enabled in .clang-tidy
    let b:ale_c_clangtidy_extra_options = '-use-color=false'
  endif
  let b:ale_cpp_clangtidy_extra_options = b:ale_c_clangtidy_extra_options
  let b:ale_cuda_clangtidy_extra_options = b:ale_c_clangtidy_extra_options

  let b:ale_c_cppcheck_options = '--enable=style --inline-suppr'
  let b:ale_cpp_cppcheck_options = b:ale_c_cppcheck_options

  let b:ale_ftplugin_already_run = 1
endif
