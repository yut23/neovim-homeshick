" ~/.config/nvim/init.vim

if hostname() ==? 'mandelbrot'
  let g:minimal_rc = 0
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/usr/bin/python3'
else
  let g:minimal_rc = 1
endif

source $HOME/.config/nvim/config/init.vim
source $HOME/.config/nvim/config/general.vim
source $HOME/.config/nvim/config/plugins.vim
source $HOME/.config/nvim/config/keys.vim
