" set file type for any otherwise unknown XKB configuration files
augroup filetypedetect
  au BufNewFile,BufRead /usr/share/X11/xkb/*  setf xkb
augroup END
