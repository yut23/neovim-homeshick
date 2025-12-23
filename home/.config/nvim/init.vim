" ~/.config/nvim/init.vim

" RC levels:
" 0: default set of plugins
" 1: additional coding plugins and ALE (fully vim compatible)
" 2: NCM2 and snippets (can't get nvim-yarp to work on Frontier with vim)
if $system_name ==? 'mandelbrot' || $system_name ==? 'blackwidow'
  let g:rc_level = 2
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/usr/bin/python3'
elseif $system_name ==? 'xrb'
  let g:rc_level = 2
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/home/eric/mambaforge/bin/python3'
elseif $system_name =~? 'VRCC-3' || $system_name ==? 'zedbox'
  let g:rc_level = 2
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/usr/bin/python3'
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
  if has('patch-8.0.1832')
    " this needs to be guarded by execute, as it triggers an E488 otherwise
    execute 'unlet $TMUX'
  endif
endif

" fix neovim settings under MSYS2
" see https://github.com/neovim/neovim/issues/16957
if has('nvim') && !empty($MSYSTEM) && (&shell =~? 'bash' || &shell =~? 'zsh')
  " search for MSWIN in https://github.com/neovim/neovim/blob/release-0.11/src/nvim/options.lua
  let &grepprg = 'grep -n $* /dev/null'
  let &isident = '@,48-57,_,192-255'
  let &keywordprg = ':Man'
  let &shellcmdflag = '-c'
  let &shellpipe = '| tee'
  let &shellredir = '>'
  if exists('+shellslash')
    let &shellslash = 1
  endif
  let &shellxquote = ''
endif

source $HOME/.config/nvim/config/init.vim
source $HOME/.config/nvim/config/general.vim
source $HOME/.config/nvim/config/keys.vim
source $HOME/.config/nvim/config/plugins.vim
