" Stiched together from the existing function and ale_linters#cpp#cc#GetCommand
function! ale_linters#cuda#nvcc#GetCommand(buffer) abort
    let l:cflags = ale#cuda#GetCFlags(a:buffer)
    let l:ale_flags = ale#Var(a:buffer, 'cuda_nvcc_options')

    if l:cflags =~# '-std='
        let l:ale_flags = substitute(
        \   l:ale_flags,
        \   '-std=\(c\|gnu\)++[0-9]\{2\}',
        \   '',
        \   'g')
    endif

    return '%e -cuda'
    \   . ale#Pad(l:cflags)
    \   . ale#Pad(l:ale_flags)
    \   . ' %s -o ' . g:ale#util#nul_file
endfunction
