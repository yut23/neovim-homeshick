" Largely copied from autoload/ale/fixers/luafmt.vim
call ale#Set('lua_luaformatter_executable', 'lua-format')
call ale#Set('lua_luaformatter_options', '')

function! ale#fixers#luaformatter#Fix(buffer) abort
  let l:executable = ale#Var(a:buffer, 'lua_luaformatter_executable')
  let l:options = ale#Var(a:buffer, 'lua_luaformatter_options')

  return {
  \   'command': ale#Escape(l:executable)
  \       . (empty(l:options) ? '' : ' ' . l:options)
  \       . ' /dev/stdin',
  \}
endfunction
