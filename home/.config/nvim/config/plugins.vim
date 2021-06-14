" config/plugins.vim
" Plugin configuration

" vim-airline
" -----------
set laststatus=2        " always show the status line
set noshowmode          " airline handles this

if $TERM ==# 'linux' && $NVIM_GUI != 1
  " use a more visible theme in the linux console
  let g:airline_theme           = 'monochrome'
  let g:airline_powerline_fonts = 0
else
  let g:airline_theme           = 'molokai'
  let g:airline_powerline_fonts = 1
endif
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" use full numbers instead of ugly superscripts
let g:airline#extensions#tabline#buffer_idx_mode = 0
let g:airline#extensions#tabline#buffer_nr_show = 1

" Don't show hunk indicators if they are all zero
let g:airline#extensions#hunks#non_zero_only = 1

" Word count
let g:airline#extensions#wordcount#filetypes = ['help', 'markdown', 'rst', 'org', 'text', 'asciidoc', 'tex', 'mail']
let g:airline#extensions#wordcount#filetypes += ['pandoc']


" better-whitespace
" -----------------
let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'man', 'pydoc', 'fugitive']


" vim-ref
" -------
" open help viewer in vertical split
let g:ref_open = 'vsplit'


" NERDCommenter
" Make Toggle behave as AlignLeft
let g:NERDDefaultAlign = 'left'


" ack.vim
" -------
" Use ag if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  " alias commands Ack -> Ag
  for command in ['Ack', 'AckAdd', 'AckFromSearch', 'LAck', 'LAckAdd', 'AckFile']
    execute 'command! -bang -nargs=* -complete=file ' . substitute(command, 'Ack', 'Ag', '') . ' ' . command . ' <args>'
  endfor
  for command in ['AckHelp', 'LAckHelp']
    execute 'command! -bang -nargs=* -complete=help ' . substitute(command, 'Ack', 'Ag', '') . ' ' . command . ' <args>'
  endfor
  for command in ['AckWindow', 'LAckWindow']
    execute 'command! -bang -nargs=* ' . substitute(command, 'Ack', 'Ag', '') . ' ' . command . ' <args>'
  endfor
endif


if ! g:minimal_rc
  " NCM2
  " ----
  inoremap <C-Space> <c-r>=ncm2#force_trigger()<cr>
  augroup ncm2AutoEnable
    autocmd!
    autocmd BufEnter * call ncm2#enable_for_buffer()
  augroup END

  " ultisnips
  " ---------
  " See keys.vim for CR handling
  let g:UltiSnipsExpandTrigger = '<F7>'
  let g:UltiSnipsJumpForwardTrigger = '<C-L>'
  let g:UltiSnipsJumpBackwardTrigger = '<C-H>'
  "let g:UltiSnipsRemoveSelectModeMappings = 0
  " disable by default
  let g:UltiSnipsEnableSnipMate = 0
  let g:UltiSnipsEditSplit = 'context'


  " LanguageClient-neovim
  " ---------------------
  "let g:LanguageClient_serverCommands = {
        "\ 'c': ['/home/eric/.cache/aurutils/sync/ccls/src/ccls-0.20181225.8/build/ccls', '--log-file=/tmp/ccls-lc.log', '-v=1'],
  let g:LanguageClient_serverCommands = {
        \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
        \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
        \ 'cuda': ['ccls', '--log-file=/tmp/cc.log'],
        \ 'objc': ['ccls', '--log-file=/tmp/cc.log'],
        \ }

  let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
  let g:LanguageClient_settingsPath = '/home/eric/.config/nvim/lc-settings.json'
  let g:LanguageClient_diagnosticsEnable = 0


  " ALE
  " ---
  " Open loclist automatically
  " 'on_save' avoids interrupting Ultisnips: https://github.com/dense-analysis/ale/issues/2961
  let g:ale_open_list = 'on_save'
  " Keep it open, so that stuff doesn't move around as much
  let g:ale_keep_list_window_open = 1
  " Also keep the signs gutter open
  let g:ale_sign_column_always = 1

  " Automatically close the loclist window when the buffer is closed
  augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
  augroup END

  " Show 5 lines of errors (default: 10)
  let g:ale_list_window_size = 5

  " Set message format
  let g:ale_echo_msg_error_str = 'E'
  let g:ale_echo_msg_warning_str = 'W'
  let g:ale_echo_msg_format = '%severity%: [%linter%] %s% [code]%'
  let g:ale_loclist_msg_format = '[%linter%] %s% [code]%'

  let g:ale_lint_on_text_changed = 'always'
  let g:ale_lint_delay = 1000

  let g:ale_python_mypy_options = '--strict --allow-untyped-defs --implicit-reexport --ignore-missing-imports'

  let g:ale_cpp_cppcheck_options = '--enable=style --inline-suppr'

  " Add support for https://github.com/Koihik/LuaFormatter
  call ale#fix#registry#Add('luaformatter', 'ale#fixers#luaformatter#Fix', ['lua'], 'Fix Lua files with LuaFormatter.')
  let g:ale_lua_luaformatter_executable = '/home/eric/.luarocks/bin/lua-format'

  " jedi-vim (disable everything)
  " This has to go in the vimrc instead of an ftplugin, due to how jedi-vim is
  " set up.
  let g:jedi#auto_initialization = 0
  let g:jedi#auto_vim_configuration = 0


  " vim-pandoc settings
  let g:pandoc#syntax#conceal#blacklist = ['definition', 'atx', 'list', 'quotes']

  let g:pandoc#modules#disabled = ['formatting', 'spell']
  let g:pandoc#command#custom_open = 'MyPandocOpen'

  "let g:pandoc#command#autoexec_on_writes = 1
  let g:pandoc#command#autoexec_command = 'Pandoc!'

  function! MyPandocOpen(file)
    let file = shellescape(fnamemodify(a:file, ':p'))
    let file_root = shellescape(fnamemodify(a:file, ':r'))
    let file_extension = fnamemodify(a:file, ':e')
    if file_extension is? 'pdf'
      if !empty($PDFVIEWER)
        return expand('$PDFVIEWER') . ' ' . file
      elseif executable('zathura')
        return 'zathura ' . file
      elseif executable('mupdf')
        return 'mupdf ' . file
      endif
    elseif file_extension is? 'html'
      let title_regex = file_root . '(.html(#\S*)?)?'
      if exists('b:pandoc_yaml_data') && has_key(b:pandoc_yaml_data, 'title')
        let title_regex = '(' . b:pandoc_yaml_data['title'] . '|' . title_regex . ')'
      endif
      return 'bash -c ''oldwindow=$(xdotool getactivewindow); xdotool search --onlyvisible --name "' . title_regex . ' - Chromium" windowfocus key F5 || chromium ' . file . ' >/dev/null; xdotool windowfocus "$oldwindow"'''
    elseif file_extension is? 'odt' && executable('okular')
      return 'okular ' . file
    elseif file_extension is? 'epub' && executable('okular')
      return 'okular ' . file
    else
      return 'xdg-open ' . file
    endif
  endfunction

  " localvimrc
  let g:localvimrc_persistence_file = expand('~/.local/share/localvimrc_persistent')
  let g:localvimrc_persistent = 1
endif
