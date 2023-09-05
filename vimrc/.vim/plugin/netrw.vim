fun! GetCleanLine()
    setl nosol
    let dirname = getline('.')
    let dirname = substitute(dirname, '\s\+$', '', 'e')
    let dirname = substitute(dirname, "@$", "", "")
    let dirname = substitute(dirname, "\*$", "", "")
    let dirname = substitute(dirname, "^\"", "", "")
    let dirname = substitute(dirname, ",\"", ",", "")
    let dirname = substitute(dirname, "\"$", "", "")
    return dirname
endfun

fun! ComposePath(base, subdir)
    if has("amiga")
        let ec = a:base[s:Strlen(a:base)-1]
        if ec != '/' && ec != ':'
            let ret = a:base."/" . a:subdir
        else
            let ret = a:base.a:subdir
        endif

        " COMBAK: test on windows with changing to root directory: :e C:/
    elseif a:subdir =~ '^\a:[/\\]\([^/\\]\|$\)' && (has("win32") || has("win95") || has("win64") || has("win16"))
        let ret= a:subdir

    elseif a:base =~ '^\a:[/\\]\([^/\\]\|$\)' && (has("win32") || has("win95") || has("win64") || has("win16"))
        if a:base =~ '[/\\]$'
            let ret= a:base.a:subdir
        else
            let ret= a:base.'/'.a:subdir
        endif

    elseif a:base =~ '^\a\{3,}://'
        let urlbase = substitute(a:base,'^\(\a\+://.\{-}/\)\(.*\)$','\1','')
        let curpath = substitute(a:base,'^\(\a\+://.\{-}/\)\(.*\)$','\2','')
        if a:subdir == '../'
            if curpath =~ '[^/]/[^/]\+/$'
                let curpath= substitute(curpath,'[^/]\+/$','','')
            else
                let curpath=""
            endif
            let ret= urlbase.curpath
        else
            let ret= urlbase.curpath.a:subdir
        endif

    else
        let ret = substitute(a:base."/".a:subdir, "//", "/", "g")
        if a:base =~ '^//'
            " keeping initial '//' for the benefit of network share listing support
            let ret= '/'.ret
        endif
        let ret= simplify(ret)
    endif

    return ret
endfunction

function! LocalRename() range
    " Process a line to remove unwanted characters
    function! ProcessLine(line)
        let l = substitute(a:line, '^[0-9]*,', '', '')
        let l = substitute(l, '\\', '', 'g')
        let l = substitute(l, '^"', '', '')
        let l = substitute(l, '"\s*$', '', '')
        let l = substitute(l, '\s\+$', '', '')
        return l
    endfunction

    " Get the current line and the next line
    let current_line = getline(line("."))
    let next_line = getline(line(".") + 1)

    " Process the lines
    let current_line = ProcessLine(current_line)
    let next_line = ProcessLine(next_line)

    " Debugging: Print the processed lines
    echo "Processed current line: " . current_line
    echo "Processed next line: " . next_line

    " Check if either line is empty to prevent unmatched " error
    if empty(current_line) || empty(next_line)
        echo "Error: One or both lines are empty."
        return
    endif

    " Escape the lines for shell command
    let current_line = shellescape(current_line)
    let next_line = shellescape(next_line)

    " Execute the rename script with the processed lines as arguments
    execute '!~/loadrc/bashrc/rename.sh ' . current_line . ' ' . next_line

    " Delete the current line in the buffer
    normal! dd

    " Call the UpdateProj() function
    call UpdateProj()
endfunction
