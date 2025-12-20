" Author: yut23 <yut23@gvljohnsons.com>
" Description: bellybutton linter for python files

call ale#Set('python_bellybutton_executable', 'bellybutton')
call ale#Set('python_bellybutton_use_global', get(g:, 'ale_use_global_executables', 0))

function! ale_linters#python#bellybutton#GetExecutable(buffer) abort
    return ale#python#FindExecutable(a:buffer, 'python_bellybutton', ['bellybutton'])
endfunction

" The directory to change to before running bellybutton (borrowed from mypy)
function! ale_linters#python#bellybutton#GetCwd(buffer) abort
    " If we find a directory with ".bellybutton.yml" in it use that,
    " else try and find the "python project" root, or failing
    " that, run from the same folder as the current file
    for l:path in ale#path#Upwards(expand('#' . a:buffer . ':p:h'))
        if filereadable(l:path . '/.bellybutton.yml')
            return l:path
        endif
    endfor

    let l:project_root = ale#python#FindProjectRoot(a:buffer)

    return !empty(l:project_root)
    \   ? l:project_root
    \   : expand('#' . a:buffer . ':p:h')
endfunction

function! ale_linters#python#bellybutton#GetCommand(buffer) abort
    return expand('~/bin/lib/ale_bellybutton.py') . ' %t'
endfunction

function! ale_linters#python#bellybutton#Handle(buffer, lines) abort
    let l:output = ale#python#HandleTraceback(a:lines, 10)

    if !empty(l:output)
        return l:output
    endif

    " Matches patterns like the following:
    "
    " bellybutton/linting.py:10	IllicitPrint: Use of print outside the CLI module is disallowed.
    let l:pattern = '\v^[^:]+:(\d+)\t([^:]+): (.*)$'

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \   'lnum': l:match[1] + 0,
        \   'code': l:match[2],
        \   'text': l:match[3],
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('python', {
\   'name': 'bellybutton',
\   'executable': function('ale_linters#python#bellybutton#GetExecutable'),
\   'cwd': function('ale_linters#python#bellybutton#GetCwd'),
\   'command': function('ale_linters#python#bellybutton#GetCommand'),
\   'callback': 'ale_linters#python#bellybutton#Handle',
\})
