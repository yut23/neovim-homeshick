" ~/.config/nvim/init.vim

" RC levels:
" 0: default set of plugins
" 1: additional coding plugins and ALE (fully vim compatible)
" 2: NCM2 and snippets (can't get nvim-yarp to work on Frontier with vim)
if hostname() ==? 'mandelbrot' || hostname() ==? 'blackwidow'
  let g:rc_level = 2
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/usr/bin/python3'
elseif hostname() ==? 'xrb'
  let g:rc_level = 2
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/home/eric/mambaforge/bin/python3'
elseif $system_name ==? 'frontier'
  let g:rc_level = 1
elseif $system_name ==? 'cantor'
  let g:rc_level = 1
else
  let g:rc_level = 0
endif

if !exists('g:vimcat')
  let g:vimcat = 0
endif

" use python 3 by default
set pyxversion=3

" if we're not in a terminal, clear $TMUX to disable vim-tmux-navigator
if !empty($TMUX) && $NVIM_GUI == 1
  let $TMUX = ''
  unlet $TMUX
endif

source $HOME/.config/nvim/config/init.vim
source $HOME/.config/nvim/config/general.vim
source $HOME/.config/nvim/config/keys.vim
source $HOME/.config/nvim/config/plugins.vim
