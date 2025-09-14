" Syntax file for my personal todo-list. Vaguely markdown-ish.

" Quit when a syntax file was already loaded.
if exists('b:current_syntax')
  finish
endif

syn region todoHeader start=/^\s*-- / end=/ --$/ keepend
syn match  todoHeaderMark /\(^\s*--\|--$\)/ contained containedin=todoHeader

syn region todoPending start=/^\s*\*\s\+.*$/ end=/$/ oneline contains=todoCode,todoInlineURL
syn match  todoPendingMark /^\s*\*/ contained containedin=todoPending

syn region todoCompleted start=/^\s*✓\s\+.*$/ end=/$/ oneline contains=todoCode,todoInlineURL
syn match  todoCompletedMark /^\s*✓/ contained containedin=todoCompleted

syn region todoCancelled start=/^\s*✗\s\+.*$/ end=/$/ oneline contains=todoCode,todoInlineURL
syn match  todoCancelledMark /^\s*✗/ contained containedin=todoCancelled

syn region todoInfo start=/^\s*-\s\+.*$/ end=/$/ oneline contains=todoCode,todoInlineURL
syn match  todoInfoMark /^\s*-/ contained containedin=todoInfo

" cribbed from vim-polyglot/syntax/markdown.vim
syn region todoCode start=/\(\([^\\]\|^\)\\\)\@<!`/ end=/`/ display

" Autolink without angle brackets.
" mkd  inline links:      protocol     optional  user:pass@  sub/domain                    .com, .co.uk, etc         optional port   path/querystring/hash fragment
"                         ------------ _____________________ ----------------------------- _________________________ ----------------- __
syn match  todoInlineURL /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z0-9][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?[^] \t,]*/

" Autolink with parenthesis.
syn region todoInlineURL matchgroup=todoDelimiter start="(\(https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z0-9][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?[^] \t]*)\)\@=" end=")"

" Autolink with angle brackets.
syn region todoInlineURL matchgroup=todoDelimiter start="\\\@<!<\ze[a-z][a-z0-9,.-]\{1,22}:\/\/[^> ]*>" end=">"

syn match  todoComment /^\s*#.*$/

hi link todoHeader Title
hi link todoHeaderMark Title

hi link todoPendingMark Identifier
hi link todoCompletedMark PreProc
hi link todoInfoMark Operator
hi link todoCancelledMark Keyword

hi link todoCode String
hi link todoInlineURL Underlined

hi link todoComment Comment
