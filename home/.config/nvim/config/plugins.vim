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

" Revert https://github.com/vim-airline/vim-airline/commit/62e7fc6
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  let a:palette.tabline = get(a:palette, 'tabline', {})
  let a:palette.tabline.airline_tab = a:palette.normal.airline_b
endfunction


" better-whitespace
" -----------------
" disable the red highlight, since we have 'list' enabled
let g:better_whitespace_enabled = 0
let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'man', 'pydoc', 'fugitive']


" EditorConfig
" ------------
" fugitive compatibility
let g:EditorConfig_exclude_patterns = ['fugitive://.*']


" vim-ref
" -------
" open help viewer in vertical split
let g:ref_open = 'vsplit'


" NERDCommenter
" -------------
" Make Toggle behave as AlignLeft
let g:NERDDefaultAlign = 'left'


" ack.vim
" -------
" Use ag if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  " alias commands Ack -> Ag
  for command in ['Ack', 'AckAdd', 'AckFromSearch', 'LAck', 'LAckAdd', 'AckFile']
    execute 'command! -bang -nargs=* -complete=file ' . substitute(command, 'Ack', 'Ag', '') . ' ' . command . '<bang> <args>'
  endfor
  for command in ['AckHelp', 'LAckHelp']
    execute 'command! -bang -nargs=* -complete=help ' . substitute(command, 'Ack', 'Ag', '') . ' ' . command . '<bang> <args>'
  endfor
  for command in ['AckWindow', 'LAckWindow']
    execute 'command! -bang -nargs=* ' . substitute(command, 'Ack', 'Ag', '') . ' ' . command . '<bang> <args>'
  endfor
endif


" LSP client settings
" vim requires join(), neovim does not
let g:lsp_settings = json_decode(join(readfile(expand('~/.config/nvim/lc-settings.json'))))

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
  let g:UltiSnipsExpandTrigger = '<F13>'
  let g:UltiSnipsJumpForwardTrigger = '<C-L>'
  let g:UltiSnipsJumpBackwardTrigger = '<C-H>'
  "let g:UltiSnipsRemoveSelectModeMappings = 0
  " disable by default
  let g:UltiSnipsEnableSnipMate = 0
  let g:UltiSnipsEditSplit = 'context'


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

  " Add support for https://github.com/Koihik/LuaFormatter
  call ale#fix#registry#Add('luaformatter', 'ale#fixers#luaformatter#Fix', ['lua'], 'Fix Lua files with LuaFormatter.')
  let g:ale_lua_luaformatter_executable = expand('~/.luarocks/bin/lua-format')

  " disable pylint for type stub files
  let g:ale_pattern_options = {
        \ '\.pyi$': {
        \   'ale_linters_ignore': ['pylint'],
        \ },
        \}


  " context.vim
  " disable by default, since it's pretty slow
  let g:context_enabled = 0
  let g:context_filetype_blacklist = ['help', 'man', 'ref-man', 'pydoc', 'fugitive']


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
