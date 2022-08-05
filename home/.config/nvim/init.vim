" ~/.config/nvim/init.vim

if hostname() ==? 'mandelbrot' || hostname() ==? 'blackwidow'
  let g:minimal_rc = 0
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/usr/bin/python3'
elseif hostname() ==? 'xrb'
  let g:minimal_rc = 0
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/home/eric/mambaforge/bin/python3'
elseif $system_name ==? 'cantor'
  let g:minimal_rc = 0
else
  let g:minimal_rc = 1
endif

source $HOME/.config/nvim/config/init.vim
source $HOME/.config/nvim/config/general.vim
source $HOME/.config/nvim/config/keys.vim
source $HOME/.config/nvim/config/plugins.vim
