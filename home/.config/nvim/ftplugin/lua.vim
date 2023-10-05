" ftplugin/lua.vim
"" Only do this when not done yet for this buffer
"if exists('b:did_ftplugin')
"  finish
"endif

let b:ale_fixers = ['luaformatter']
let b:ale_fix_on_save = 1
