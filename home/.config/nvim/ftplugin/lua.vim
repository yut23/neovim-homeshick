" ftplugin/lua.vim
"" Only do this when not done yet for this buffer
"if exists('b:did_ftplugin')
"  finish
"endif

"" Don't load another plugin for this buffer
"let b:did_ftplugin = 1

let b:ale_fixers = ['luaformatter']
let b:ale_fix_on_save = 1
