command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject BinaryGrep :execute s:BinaryGrep(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Copy :execute s:Copy(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Dodev :execute s:Dodev()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Dps :execute s:Dps()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Fcscope :execute s:Fcscope()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject FindDeleted :execute s:FindDeleted()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Fnotinuse :execute s:Fnotinuse()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Fr :execute s:Fr(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Fsync :execute s:Fsync()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject G :execute s:G(<q-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Ga :execute s:Ga(<q-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gbib :execute s:Gbib()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gbidebug :execute s:Gbidebug()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gbig :execute s:Gbig()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gbil :execute s:Gbil()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gbis :execute s:Gbis()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gbr :execute s:Gbr()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gbra :execute s:Gbra()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gbrd :execute s:Gbrd(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gbrm :execute s:Gbrm(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gclean :execute s:Gclean()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gco :execute s:Gco(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gcob :execute s:Gcob(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gcof :execute s:Gcof(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gcom :execute s:Gcom(<q-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gcp :execute s:Gcp(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gdev :execute s:Gdev()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gdi :execute s:Gdi(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gdi2 :execute s:Gdi2(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gdif :execute s:Gdif(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gdifo :execute s:Gdifo(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gdio :execute s:Gdio(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gdit :execute s:Gdit()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gfix :execute s:Gfix()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gicb :execute s:Gicb()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gitk :execute s:Gitk(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Glf :execute s:Glf()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Glg :execute s:Glg()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gme2 :execute s:Gme2(<q-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gmet :execute s:Gmet()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gpl :execute s:Gpl()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gps :execute s:Gps()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gres :execute s:Gres()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Greview :execute s:Greview()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Grsh :execute s:Grsh(<q-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Grta :execute s:Grta(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Grtu :execute s:Grtu()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Grtv :execute s:Grtv()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gs :execute s:Gs()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gsave :execute s:Gsave()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gshow :execute s:Gshow(<q-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gst :execute s:Gst()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gsti :execute s:Gsti()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gstl :execute s:Gstl()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gstlv :execute s:Gstlv()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gstp :execute s:Gstp(<q-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gstv :execute s:Gstv(<q-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gsync :execute s:Gsync()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gtg :execute s:Gtg()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gvd :execute s:Gvd(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gvdo :execute s:Gvdo()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gwap :execute s:Gwap()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Jformat :execute s:Jformat()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject LcTest :execute s:LcTest()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject LogFilter :execute s:LogFilter(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Prune :execute s:Prune()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SortBySize :execute s:SortBySize()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SortByTime :execute s:SortByTime()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SvnApply :execute s:SvnApply()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SvnDiff :execute s:SvnDiff()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SvnReset :execute s:SvnReset()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SvnRevert :execute s:SvnRevert()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SvnSt :execute s:SvnSt()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SvnUp :execute s:SvnUp()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Tail :execute s:Tail()

function! s:LogFilter(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    call asyncrun#run('<bang>', '', '~/loadrc/bashrc/logFilter.sh ' . '"' .  expand('%:p') . '" "' .  arg1 . '"')
endfunction

function! s:Jformat(...) abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/bashrc/jformat.sh ')
endfunction

function! s:Gvd(...) abort
    let worktree = Cd2Worktree()

    if expand('%:t') != 'index'
        if a:0 == 0
            call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gvd.sh ' . 'HEAD ' . '"' .  expand('%:p') . '"')
        else
            let arg1 = (a:0 >= 1) ? a:1 : ''
            call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gvd.sh ' . '"' .  arg1 . '" "' .  expand('%:p') . '"')
        endif
    else
        let arg1 = (a:0 >= 1) ? a:1 : ''
        let arg2 = (a:0 >= 2) ? a:2 : ''
        call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gvd.sh ' . '"' .  arg1 . '" "' .  arg2 . '"')
    endif
endfunction

function! s:Gvdo() abort
    let worktree = Cd2Worktree()
    let remote = substitute(system("git config gsync.remote"), '\n', '', '')
    let branch = substitute(system("git config gsync.branch"), '\n', '', '')

    if expand('%:t') != 'index'
        call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gvd.sh ' . '"' .  remote . '/' . branch . '" "' .  expand('%:p') . '"')
    else
        call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gvd.sh ' . '"' .  remote . '/' . branch . '"')
    endif
endfunction

function! s:Fr(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    let arg2 = (a:0 >= 2) ? a:2 : ''
    call asyncrun#run('<bang>', '', '~/loadrc/bashrc/fr.sh ' . '"' .  arg1 . '" "' .  arg2 . '"')
endfunction

function! s:Ga(args, ...) abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/ga.sh ' . '"' .  a:args . '"')
endfunction

function! s:Gsave() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gsave.sh')
endfunction

function! s:Gst() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gst.sh')
endfunction

function! s:Gcp(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    let arg2 = (a:0 >= 2) ? a:2 : ''
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gcp.sh ' . '"' .  arg1 . '" "' .  arg2 . '"')
endfunction

function! s:BinaryGrep(...) abort
    call Cd2ProjectRoot("files.proj")
    let b:keyword = (a:0 >= 1) ? a:1 : ''
    call asyncrun#run('<bang>', '', '~/loadrc/bashrc/binaryGrep.sh ' . '"' .  b:keyword . '"')
    let b:keyword = substitute(b:keyword, " ", "_", "g")
    let b:keyword = substitute(b:keyword, "/", "_", "g")
    call OpenOrSwitch(b:keyword . '.binaryGrep.findresult', 'vs')
endfunction

function! s:Fnotinuse() abort
    call Cd2ProjectRoot("files.proj")
    call asyncrun#run('<bang>', '', '~/loadrc/bashrc/fnotinuse.sh')
    call OpenOrSwitch('fnotinuse.findresult', 'vs')
endfunction

function! s:Fcscope() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/bashrc/fcscope.sh')
endfunction

function! s:Glf() abort
    let worktree = Cd2Worktree()
    silent exec '!git ls-files | tee glf.findresult'
    call OpenOrSwitch('glf.findresult', 'vs')
endfunction

function! s:Glg() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/glg.sh'
    call OpenOrSwitch('glg.findresult', 'vs')
endfunction

function! s:Gps() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gps.sh 2>&1 | tee gps.findresult')
endfunction

function! s:Gstp(args, ...) abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gstp.sh ' . '"' .  a:args . '"')
endfunction

function! s:Gstv(args, ...) abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gstv.sh ' . '"' .  a:args . '"')
endfunction

function! s:Gcof(...) abort
    let worktree = Cd2Worktree()
    let b:relativePath = substitute(expand('%:p'), worktree . '/', "", "g")
    let arg1 = (a:0 >= 1) ? a:1 : ''
    silent exec '!~/loadrc/gitrc/gcof.sh ' . '"' .  b:relativePath . '" "' .  arg1 . '"'
    call OpenOrSwitch(expand('%:p') . '.bak', 'vs')
endfunction

function! s:Gpl() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gpl.sh 2>&1 | tee gpl.findresult')
endfunction

function! s:Fsync() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/fsync.sh 2>&1 | tee fsync.findresult')
    call OpenOrSwitch('fsync.findresult', 'vs')
endfunction

function! s:Gbis() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/gitrc/gbis.sh'
endfunction

function! s:Gbidebug() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/gitrc/gbidebug.sh'
endfunction

function! s:Gbib() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/gitrc/gbib.sh'
endfunction

function! s:Gbig() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/gitrc/gbig.sh'
endfunction

function! s:Gbil() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/gitrc/gbil.sh'
    call OpenOrSwitch('gbil.log', 'vs')
endfunction

function! s:Gbr() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/gbr.sh'
    call OpenOrSwitch('gbr.findresult', 'vs')
endfunction

function! s:Gclean() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/gclean.sh'
endfunction

function! s:Gbra() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/gbra.sh'
    call OpenOrSwitch('gbra.findresult', 'vs')
endfunction

function! s:Gs() abort
    let indexFolder = substitute(system("~/loadrc/gitrc/get_git.sh " . '"' . expand('%:p') . '"'), '\n', '', '')
    call OpenOrSwitch(indexFolder . '/index', 'vs')
endfunction

function! s:Gsync() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gsync.sh 2>&1 | tee gsync.findresult')
    call OpenOrSwitch('gsync.findresult', 'vs')
endfunction

function! s:Grta(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    let arg2 = (a:0 >= 2) ? a:2 : ''
    silent exec '!git remote add ' . '"' .  arg1 . '" "' .  arg2 . '"'
endfunction

function! s:Grsh(args, ...) abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/grsh.sh ' . '"' .  a:args . '"'
endfunction

function! s:Gsti() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gsti.sh')
endfunction

function! s:Gstl() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/gstl.sh'
    call OpenOrSwitch('gstl.findresult', 'vs')
endfunction

function! s:Gstlv() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gstlv.sh')
endfunction

function! s:Gme2(args, ...) abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/gme2.sh ' . '"' .  a:args . '" 2>&1 | tee gme2.findresult'
    call OpenOrSwitch(worktree . '/' . 'gme2.findresult', 'vs')
endfunction

function! s:G(args, ...) abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/g.sh ' . '"' .  a:args . '" 2>&1 | tee g.findresult')
endfunction

function! s:Gdev() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gdev.sh')
endfunction

function! s:Gdi(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    let output = 'gdi.diff'

    if expand('%:t') != 'index'
        let output = expand('%:t') . '.diff'

        if a:0 == 0
            silent exec '!~/loadrc/gitrc/gdi.sh ' . 'HEAD "' .  expand('%:p') . '" 2>&1 | tee ' . '"' .  output . '"'
        else
            let arg1 = (a:0 >= 1) ? a:1 : ''
            silent exec '!~/loadrc/gitrc/gdi.sh ' . '"' .  arg1 . '" "' .  expand('%:p') . '" 2>&1 | tee ' . '"' .  output . '"'
        endif
    else
        let arg1 = (a:0 >= 1) ? a:1 : ''
        silent exec '!~/loadrc/gitrc/gdi.sh ' . '"' .  arg1 . '" HEAD 2>&1 | tee ' . '"' .  output . '"'
    endif

    if bufwinnr('^' . output . '$') > 0
        exe "bd!" . output
    endif

    let worktree = Cd2Worktree()
    call OpenOrSwitch(output, 'vs')
    call s:DiffClean()
endfunction

function! s:Gdit() abort
    let worktree = Cd2Worktree()
    let current_branch = substitute(system("~/loadrc/gitrc/get_current_branch.sh"), '\n', '', '')
    let output = current_branch . '.gdit.diff'
    let output = substitute(output, "/", "_", "g")
    exec '!~/loadrc/gitrc/gdit.sh' . ' ' . '"' .  output . '"'

    if bufwinnr('^' . output . '$') > 0
        exe "bd!" . output
    endif

    let worktree = Cd2Worktree()
    call OpenOrSwitch(output, 'vs')
    call s:DiffClean()
endfunction

function! s:Gdio(...) abort
    let worktree = Cd2Worktree()
    let current_branch = substitute(system("~/loadrc/gitrc/get_current_branch.sh"), '\n', '', '')
    let local_branch = (a:0 >= 1) ? a:1 : current_branch
    let output = local_branch . '.gdio.diff'
    let output = substitute(output, "/", "_", "g")
    exec '!~/loadrc/gitrc/gdio.sh' . ' ' . '"' . local_branch . '"' . ' ' . '"' .  output . '"'

    if bufwinnr('^' . output . '$') > 0
        exe "bd!" . output
    endif

    let worktree = Cd2Worktree()
    call OpenOrSwitch(output, 'vs')
    call s:DiffClean()
endfunction

function! s:Gdi2(...) abort
    if (expand("%") !~ '.*fix.gdit.diff')
        return
    endif

    let worktree = Cd2Worktree()
    let output = 'gdi2.findresult'
    let arg1 = (a:0 >= 1) ? a:1 : ''
    exec '!~/loadrc/gitrc/gdi2.sh 2>&1 | tee ' . '"' .  output . '"'
    call OpenOrSwitch(output, 'vs')
endfunction

function! s:Grtv() abort
    let worktree = Cd2Worktree()
    call OpenOrSwitch('git/config', 'vs')
endfunction

function! s:Grtu() abort
    let worktree = Cd2Worktree()
    silent exec '!git remote update'
endfunction

function! s:Gtg() abort
    let worktree = Cd2Worktree()
    silent exec '!git tag -l -n1 2>&1 | tee gtg.findresult'
    call OpenOrSwitch('gtg.findresult', 'vs')
endfunction

function! s:Gmet() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', 'git mergetool')
endfunction

function! s:Gicb() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gicb.sh')
endfunction

function! s:Gitk(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    let arg2 = (a:0 >= 2) ? a:2 : ''
    call asyncrun#run('<bang>', '', 'gitk ' . '"' .  arg1 . '"' . ' ' . '"' .  arg2 . '"')
endfunction

function! s:Gbrm(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    exec '!~/loadrc/gitrc/gbrm.sh ' . '"' .  arg1 . '"'
endfunction

function! s:Gbrd(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    exec '!~/loadrc/gitrc/gbrd.sh ' . '"' .  arg1 . '"'
endfunction

function! s:Gdifo(...) abort
    let worktree = Cd2Worktree()
    let remote = substitute(system("git config gsync.remote"), '\n', '', '')
    let branch = substitute(system("git config gsync.branch"), '\n', '', '')
    silent exec '!~/loadrc/gitrc/gdif.sh ' . '"' .  remote . '/' . branch . '"'
    call OpenOrSwitch('gdif.findresult', 'vs')
endfunction

function! s:Gdif(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    silent exec '!~/loadrc/gitrc/gdif.sh ' . '"' .  arg1 . '"'
    call OpenOrSwitch('gdif.findresult', 'vs')
endfunction

function! s:Gco(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gco.sh ' . '"' .  arg1 . '"')
endfunction

function! s:Gcob(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    let arg2 = (a:0 >= 2) ? a:2 : ''
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gcob.sh ' . '"' .  arg1 . '" "' .  arg2 . '"')
endfunction

function! s:Dodev() abort
    let worktree = Cd2Worktree()
    call OpenOrSwitch('docker-compose.yml', 'vs')
endfunction

function! s:Gcom(args, ...) abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/gcom.sh ' . '"' .  a:args . '"')
endfunction

function! s:Gshow(args, ...) abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/gshow.sh ' . '"' .  a:args . '" 2>&1 | tee gshow.diff'
    call OpenOrSwitch('gshow.diff', 'vs')
endfunction

function! s:Copy(...) abort
    let newFile = (a:0 >= 1) ? a:1 : expand("%:p") . '.bak'
    exec '!rm ' . newFile
    exec 'w ' . newFile
    call OpenOrSwitch(newFile, 'vs')
endfunction

function! s:Tail() abort
    exec '!tail -f ' . expand("%:p")
endfunction

function! s:Greview() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/gitrc/greview.sh')
endfunction

function! s:Gres() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/gitrc/gres.sh'
endfunction

function! s:Dps() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/dockerrc/dps.sh'
    call OpenOrSwitch('dps.findresult', 'vs')
endfunction

function! s:SvnUp() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/svnrc/svnup.sh')
endfunction

function! s:SvnReset() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/svnrc/svnreset.sh'
    call OpenOrSwitch('svnreset.findresult', 'vs')
endfunction

function! s:SvnRevert() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/svnrc/svnrevert.sh ' . '"' .  expand('%:p') . '"')
endfunction

function! s:SvnSt() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/svnrc/svnst.sh'
    call OpenOrSwitch('svnst.findresult', 'vs')
endfunction

function! s:SvnApply() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/svnrc/svnapply.sh')
endfunction

function! s:SvnDiff() abort
    let worktree = Cd2Worktree()
    call asyncrun#run('<bang>', '', '~/loadrc/svnrc/svndiff.sh ' . '"' .  expand('%:p') . '"')
endfunction

function! s:LcTest() abort
    if (expand("%") !~ '.*leetcode.*') || (expand("%") =~ '.*\.sh')
        return
    endif
    silent exec '!~/loadrc/vishrc/lc_test.sh ' . '"' .  expand('%:p') . '"'
    call OpenOrSwitch(expand('%:p') . '.sh', 'vs')
endfunction

function! s:Prune() abort
    call asyncrun#run('<bang>', '', '~/loadrc/vishrc/prune.sh ' . '"' .  expand('%:p') . '"')
endfunction

function! s:Fr(find, replace) abort
    call Cd2ProjectRoot("files.proj")
    silent exec '!~/loadrc/bashrc/fr.sh ' . '"' .  a:find . '"' . ' ' . '"' .  a:replace . '"'
    call s:Gs()
endfunction

function! s:FindDeleted() abort
    call Cd2ProjectRoot("files.proj")
    silent exec '!~/loadrc/gitrc/find_deleted.sh 2>&1 | tee find_deleted.findresult'
    call OpenOrSwitch('find_deleted.findresult', 'vs')
endfunction

function! s:Gwap() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/gwap.sh'
    call s:Gs()
endfunction

function! s:DiffClean() abort
    if expand('%:e') != "diff"
        return
    endif

    silent exec '%s/^--- a\//--- \.\//g'
    silent exec '%s/^+++ b\//+++ \.\//g'
    w
endfunction

function! s:Gfix() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/gitrc/gfix.sh'
endfunction

function! s:SortByTime() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/vishrc/sort_entries.sh ' . '"' .  expand('%:p') . '"' . ' time'
endfunction

function! s:SortBySize() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/vishrc/sort_entries.sh ' . '"' .  expand('%:p') . '"' . ' size'
endfunction
