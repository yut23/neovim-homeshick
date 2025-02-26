" config/plugins.vim
" Plugin configuration

" vim-airline
" -----------
if has_key(g:plugs, 'vim-airline')
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
endif


" better-whitespace
" -----------------
if has_key(g:plugs, 'vim-better-whitespace')
  " disable the red highlight, since we have 'list' enabled
  let g:better_whitespace_enabled = 0
  let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'man', 'pydoc', 'fugitive']
endif


" EditorConfig
" ------------
if has_key(g:plugs, 'editorconfig-vim')
  " fugitive compatibility
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']

  " disable built-in neovim support, since it doesn't like vim-symlink
  if has('nvim-0.9')
    let g:editorconfig = v:false
  endif
endif


" vim-ref
" -------
if has_key(g:plugs, 'vim-ref')
  " open help viewer in vertical split
  let g:ref_open = 'vsplit'
endif


" linediff
" --------
if has_key(g:plugs, 'linediff.vim')
  " use scratch buffers for the diff sections
  let g:linediff_buffer_type = 'scratch'
endif


" NERDCommenter
" -------------
if has_key(g:plugs, 'nerdcommenter')
  " Make Toggle behave as AlignLeft
  let g:NERDDefaultAlign = 'left'
  " Add delimiter mappings for todo list
  let g:NERDCustomDelimiters = {
        \ 'todo': { 'left': '# ', 'leftAlt': '#' },
        \ }
endif


" gitgutter
" ---------
if has_key(g:plugs, 'vim-gitgutter')
  " Use floating/popup window for hunk previews where available (the plugin
  " automatically falls back to a preview window if not)
  let g:gitgutter_preview_win_floating = 1
endif


" vim-tmux-navigator
" ------------------
if has_key(g:plugs, 'vim-tmux-navigator')
  " disable the default mappings, so I can consistently restore Ctrl-L in
  " visual mode afterward (see config/keys.vim)
  let g:tmux_navigator_no_mappings = 1
  " Disable tmux navigator when the current tmux pane is zoomed
  let g:tmux_navigator_disable_when_zoomed = 1
endif


" LSP client settings
" vim requires join(), neovim does not
let g:lsp_settings = json_decode(join(readfile(expand('~/.config/nvim/lc-settings.json'))))

" NCM2
" ----
if has_key(g:plugs, 'ncm2')
  inoremap <C-Space> <c-r>=ncm2#force_trigger()<cr>
  augroup ncm2AutoEnable
    autocmd!
    autocmd BufEnter * call ncm2#enable_for_buffer()
  augroup END
endif

" ultisnips
" ---------
if has_key(g:plugs, 'ultisnips')
  " See keys.vim for CR handling
  if has('nvim')
    let g:UltiSnipsExpandTrigger = '<F13>'
  else
    let g:UltiSnipsExpandTrigger = '<S-F1>'
  endif
  let g:UltiSnipsJumpForwardTrigger = '<C-L>'
  let g:UltiSnipsJumpBackwardTrigger = '<C-H>'
  "let g:UltiSnipsRemoveSelectModeMappings = 0
  " disable by default
  let g:UltiSnipsEnableSnipMate = 0
  let g:UltiSnipsEditSplit = 'context'
endif


" ALE
" ---
if has_key(g:plugs, 'ale')
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
  let g:ale_lua_luaformatter_executable = expand('~/.luarocks/bin/lua-format')
  if filereadable(g:ale_lua_luaformatter_executable)
    call ale#fix#registry#Add('luaformatter', 'ale#fixers#luaformatter#Fix', ['lua'], 'Fix Lua files with LuaFormatter.')
  endif

  " disable pylint for type stub files
  let g:ale_pattern_options = {
        \ '\.pyi$': {
        \   'ale_linters_ignore': ['pylint'],
        \ },
        \}
endif


" context.vim
if has_key(g:plugs, 'context.vim')
  " disable by default, since it's slow and makes scrolling inconsistent
  let g:context_enabled = 0
  let g:context_filetype_blacklist = ['help', 'man', 'ref-man', 'pydoc', 'fugitive']
endif


" jedi-vim (disable everything)
if has_key(g:plugs, 'jedi-vim')
  " This has to go in the vimrc instead of an ftplugin, due to how jedi-vim is
  " set up.
  let g:jedi#auto_initialization = 0
  let g:jedi#auto_vim_configuration = 0
endif


" vim-pandoc settings
if has_key(g:plugs, 'vim-pandoc')
  let g:pandoc#syntax#conceal#blacklist = ['definition', 'atx', 'list', 'quotes']

  let g:pandoc#modules#disabled = ['spell']
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
      return 'bash -c ''oldwindow=$(xdotool getactivewindow); xdotool search --onlyvisible --name "' . title_regex . ' - Google Chrome" windowfocus key F5 || google-chrome-stable ' . file . ' >/dev/null; xdotool windowfocus "$oldwindow"'''
    elseif file_extension is? 'odt' && executable('okular')
      return 'okular ' . file
    elseif file_extension is? 'epub' && executable('okular')
      return 'okular ' . file
    else
      return 'xdg-open ' . file
    endif
  endfunction
endif


" localvimrc
if has_key(g:plugs, 'vim-localvimrc')
  let g:localvimrc_persistence_file = expand('~/.local/share/localvimrc_persistent')
  let g:localvimrc_persistent = 1
endif
