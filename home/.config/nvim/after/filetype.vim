augroup filetypedetect
  " set file type for any otherwise unknown XKB configuration files
  au BufNewFile,BufRead /usr/share/X11/xkb/* setfiletype xkb
  au BufNewFile,BufRead **/Doc/Zsh/*.yo setfiletype zyodl
  au BufNewFile,BufRead /home/eric/TODO.txt setfiletype todo
augroup END
