" Copied from autoload/ale/c.vim, with some modifications to ale#c#ParseCFlags

" Make sure the parent file is loaded, so default variables are set
runtime autoload/ale/c.vim

" Cache compile_commands.json data in a Dictionary, so we don't need to read
" the same files over and over again. The key in the dictionary will include
" the last modified time of the file.
if !exists('s:compile_commands_cache')
    let s:compile_commands_cache = {}
endif

function! ale#cuda#ResetCompileCommandsCache() abort
    let s:compile_commands_cache = {}
endfunction

function! s:GetLookupFromCompileCommandsFile(compile_commands_file) abort
    let l:empty = [{}, {}]

    if empty(a:compile_commands_file)
        return l:empty
    endif

    let l:time = getftime(a:compile_commands_file)

    if l:time < 0
        return l:empty
    endif

    let l:key = a:compile_commands_file . ':' . l:time

    if has_key(s:compile_commands_cache, l:key)
        return s:compile_commands_cache[l:key]
    endif

    let l:raw_data = []
    silent! let l:raw_data = json_decode(join(readfile(a:compile_commands_file), ''))

    if type(l:raw_data) isnot v:t_list
        let l:raw_data = []
    endif

    let l:file_lookup = {}
    let l:dir_lookup = {}

    for l:entry in (type(l:raw_data) is v:t_list ? l:raw_data : [])
        let l:filename = ale#path#GetAbsPath(l:entry.directory, l:entry.file)

        " Store a key for lookups by the absolute path to the filename.
        let l:file_lookup[l:filename] = get(l:file_lookup, l:filename, []) + [l:entry]

        " Store a key for fuzzy lookups by the absolute path to the directory.
        let l:dirname = fnamemodify(l:filename, ':h')
        let l:dir_lookup[l:dirname] = get(l:dir_lookup, l:dirname, []) + [l:entry]

        " Store a key for fuzzy lookups by just the basename of the file.
        let l:basename = tolower(fnamemodify(l:entry.file, ':t'))
        let l:file_lookup[l:basename] = get(l:file_lookup, l:basename, []) + [l:entry]

        " Store a key for fuzzy lookups by just the basename of the directory.
        let l:dirbasename = tolower(fnamemodify(l:entry.directory, ':p:h:t'))
        let l:dir_lookup[l:dirbasename] = get(l:dir_lookup, l:dirbasename, []) + [l:entry]
    endfor

    if !empty(l:file_lookup) && !empty(l:dir_lookup)
        let l:result = [l:file_lookup, l:dir_lookup]
        let s:compile_commands_cache[l:key] = l:result

        return l:result
    endif

    return l:empty
endfunction

" Get [should_quote, arguments] from either 'command' or 'arguments'
" 'arguments' should be quoted later, the split 'command' strings should not.
function! s:GetArguments(json_item) abort
    if has_key(a:json_item, 'arguments')
        return [1, a:json_item.arguments]
    elseif has_key(a:json_item, 'command')
        return [0, ale#c#ShellSplit(a:json_item.command)]
    endif

    return [0, []]
endfunction

function! ale#cuda#ParseCFlags(path_prefix, should_quote, raw_arguments) abort
    " Expand @file arguments now before parsing
    let l:arguments = ale#c#ExpandAtArgs(a:path_prefix, a:raw_arguments)
    " A list of [already_quoted, argument]
    let l:items = []
    let l:option_index = 0

    while l:option_index < len(l:arguments)
        let l:option = l:arguments[l:option_index]
        let l:option_index = l:option_index + 1

        " Include options, that may need relative path fix
        if stridx(l:option, '-I') == 0
        \ || stridx(l:option, '-iquote') == 0
        \ || stridx(l:option, '-isystem') == 0
        \ || stridx(l:option, '-idirafter') == 0
        \ || stridx(l:option, '-iframework') == 0
            if stridx(l:option, '-I') == 0 && l:option isnot# '-I'
                let l:arg = join(split(l:option, '\zs')[2:], '')
                let l:option = '-I'
            elseif l:option =~# '\v^-i(quote|system|dirafter|framework)='
                " separated by an equals sign
                let l:parts = split(l:option, '=')
                let l:option = l:parts[0]
                let l:arg = join(l:parts[1:], '=')
            else
                " separated by a space
                let l:arg = l:arguments[l:option_index]
                let l:option_index = l:option_index + 1
            endif

            " Fix relative paths if needed
            if !ale#path#IsAbsolute(l:arg)
                let l:rel_path = substitute(l:arg, '"', '', 'g')
                let l:rel_path = substitute(l:rel_path, '''', '', 'g')
                let l:arg = ale#path#GetAbsPath(a:path_prefix, l:rel_path)
            endif

            call add(l:items, [1, l:option])
            call add(l:items, [1, ale#Escape(l:arg)])
        " Options with arg that can be grouped with the option or separate
        elseif stridx(l:option, '-D') == 0 || stridx(l:option, '-B') == 0
            if l:option is# '-D' || l:option is# '-B'
                call add(l:items, [1, l:option])
                call add(l:items, [0, l:arguments[l:option_index]])
                let l:option_index = l:option_index + 1
            else
                call add(l:items, [0, l:option])
            endif
        " Options that have an argument (always separate)
        elseif l:option is# '-iprefix' || stridx(l:option, '-iwithprefix') == 0
        \ || l:option is# '-isysroot' || l:option is# '-imultilib'
        \ || l:option is# '-include' || l:option is# '-imacros'
            call add(l:items, [0, l:option])
            call add(l:items, [0, l:arguments[l:option_index]])
            let l:option_index = l:option_index + 1
        " Options without argument
        elseif (stridx(l:option, '-W') == 0 && stridx(l:option, '-Wa,') != 0 && stridx(l:option, '-Wl,') != 0 && stridx(l:option, '-Wp,') != 0)
        \ || l:option is# '-w' || stridx(l:option, '-pedantic') == 0
        \ || l:option is# '-ansi' || stridx(l:option, '-std=') == 0
        \ || stridx(l:option, '-f') == 0 && l:option !~# '\v^-f(dump|diagnostics|no-show-column|stack-usage)'
        \ || stridx(l:option, '-O') == 0
        \ || l:option is# '-C' || l:option is# '-CC' || l:option is# '-trigraphs'
        \ || stridx(l:option, '-nostdinc') == 0 || stridx(l:option, '-iplugindir=') == 0
        \ || stridx(l:option, '--sysroot=') == 0 || l:option is# '--no-sysroot-suffix'
        \ || stridx(l:option, '-m') == 0
        \ || stridx(l:option, '--expt-') == 0
            call add(l:items, [0, l:option])
        " Options that need quoting
        elseif stridx(l:option, '-gencode') == 0
        \ || stridx(l:option, '--generate-code') == 0
            call add(l:items, [0, ale#c#QuoteArg(l:option)])
        endif
    endwhile

    if a:should_quote
        " Quote C arguments that haven't already been quoted above.
        " If and only if we've been asked to quote them.
        call map(l:items, 'v:val[0] ? v:val[1] : ale#c#QuoteArg(v:val[1])')
    else
        call map(l:items, 'v:val[1]')
    endif

    return join(l:items, ' ')
endfunction

function! ale#cuda#ParseCompileCommandsFlags(buffer, file_lookup, dir_lookup) abort
    let l:buffer_filename = ale#path#Simplify(expand('#' . a:buffer . ':p'))
    let l:basename = tolower(fnamemodify(l:buffer_filename, ':t'))
    " Look for any file in the same directory if we can't find an exact match.
    let l:dir = fnamemodify(l:buffer_filename, ':h')

    " Search for an exact file match first.
    let l:file_list = get(a:file_lookup, l:buffer_filename, [])

    " We may have to look for /foo/bar instead of C:\foo\bar
    if empty(l:file_list) && has('win32')
        let l:file_list = get(
        \   a:file_lookup,
        \   ale#path#RemoveDriveLetter(l:buffer_filename),
        \   []
        \)
    endif

    " Try the absolute path to the directory second.
    let l:dir_list = get(a:dir_lookup, l:dir, [])

    if empty(l:dir_list) && has('win32')
        let l:dir_list = get(
        \   a:dir_lookup,
        \   ale#path#RemoveDriveLetter(l:dir),
        \   []
        \)
    endif

    if empty(l:file_list) && empty(l:dir_list)
        " If we can't find matches with the path to the file, try a
        " case-insensitive match for any similarly-named file.
        let l:file_list = get(a:file_lookup, l:basename, [])

        " If we can't find matches with the path to the directory, try a
        " case-insensitive match for anything in similarly-named directory.
        let l:dir_list = get(a:dir_lookup, tolower(fnamemodify(l:dir, ':t')), [])
    endif

    " A source file matching the header filename.
    let l:source_file = ''

    if empty(l:file_list) && l:basename =~? '\.h$\|\.hpp$'
        for l:suffix in ['.c', '.cpp']
            " Try to find a source file by an absolute path first.
            let l:key = fnamemodify(l:buffer_filename, ':r') . l:suffix
            let l:file_list = get(a:file_lookup, l:key, [])

            if empty(l:file_list) && has('win32')
                let l:file_list = get(
                \   a:file_lookup,
                \   ale#path#RemoveDriveLetter(l:key),
                \   []
                \)
            endif

            if empty(l:file_list)
                " Look fuzzy matches on the basename second.
                let l:key = fnamemodify(l:basename, ':r') . l:suffix
                let l:file_list = get(a:file_lookup, l:key, [])
            endif

            if !empty(l:file_list)
                let l:source_file = l:key
                break
            endif
        endfor
    endif

    for l:item in l:file_list
        let l:filename = ale#path#GetAbsPath(l:item.directory, l:item.file)

        " Load the flags for this file, or for a source file matching the
        " header file.
        if (
        \   bufnr(l:filename) is a:buffer
        \   || (
        \       !empty(l:source_file)
        \       && l:filename[-len(l:source_file):] is? l:source_file
        \   )
        \)
            let [l:should_quote, l:args] = s:GetArguments(l:item)

            return ale#cuda#ParseCFlags(l:item.directory, l:should_quote, l:args)
        endif
    endfor

    for l:item in l:dir_list
        let l:filename = ale#path#GetAbsPath(l:item.directory, l:item.file)

        if ale#path#RemoveDriveLetter(fnamemodify(l:filename, ':h'))
        \  is? ale#path#RemoveDriveLetter(l:dir)
            let [l:should_quote, l:args] = s:GetArguments(l:item)

            return ale#cuda#ParseCFlags(l:item.directory, l:should_quote, l:args)
        endif
    endfor

    return ''
endfunction

function! ale#cuda#GetCFlags(buffer) abort
    let l:cflags = v:null

    if ale#Var(a:buffer, 'c_parse_compile_commands')
        let [l:root, l:json_file] = ale#c#FindCompileCommands(a:buffer)

        if !empty(l:json_file)
            let l:lookups = s:GetLookupFromCompileCommandsFile(l:json_file)
            let l:file_lookup = l:lookups[0]
            let l:dir_lookup = l:lookups[1]
            return ale#cuda#ParseCompileCommandsFlags(a:buffer, l:file_lookup, l:dir_lookup)
        endif
    endif

    if l:cflags is v:null
        let l:cflags = ale#c#IncludeOptions(ale#c#FindLocalHeaderPaths(a:buffer))
    endif

    return l:cflags isnot v:null ? l:cflags : ''
endfunction

