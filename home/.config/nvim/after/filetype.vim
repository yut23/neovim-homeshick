augroup filetypedetect
  " set file type for any otherwise unknown XKB configuration files
  au BufNewFile,BufRead /usr/share/X11/xkb/* setfiletype xkb
  au BufNewFile,BufRead **/Doc/Zsh/*.yo setfiletype zyodl
  au BufNewFile,BufRead $HOME/TODO.txt setfiletype todo

  " override filetype for gdb sources
  au BufNewFile,BufRead /scratch/build/gdb/binutils-gdb/**/*.c setfiletype cpp

  " configure tabs when viewing libstdc++ code
  au BufRead /usr/include/c++/**/* setlocal ts=8 sw=2
augroup END
