" ~/.config/nvim/init.vim

if hostname() ==? 'mandelbrot' || hostname() ==? 'blackwidow'
  let g:minimal_rc = 0
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/usr/bin/python3'
else
  let g:minimal_rc = 1
endif

if hostname() ==? 'blackwidow'
  let g:ale_python_pylint_executable = 'pylint-3'
endif

source $HOME/.config/nvim/config/init.vim
source $HOME/.config/nvim/config/general.vim
source $HOME/.config/nvim/config/keys.vim
source $HOME/.config/nvim/config/plugins.vim
