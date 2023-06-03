command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject AppendRate :execute s:AppendRate(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject ApplyBranch :execute s:ApplyBranch(<q-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject BinaryGrep :execute s:BinaryGrep(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject CatDu :execute s:CatDu(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject CatMove :execute s:CatMove(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject CatPlay :execute s:CatPlay(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject CatRate :execute s:CatRate(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject CatBadFiles :execute s:CatBadFiles(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject CatRun :execute s:CatRun(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Copy :execute s:Copy(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Dodev :execute s:Dodev()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Dps :execute s:Dps()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Fcscope :execute s:Fcscope()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Fdisklog :execute s:Fdisklog()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject FileMove :execute s:FileMove(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject FindDeleted :execute s:FindDeleted()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject FindSimilarFiles call s:FindSimilarFilenames(<f-args>)
command! -bang -bar -nargs=+ -complete=customlist,fugitive#CompleteObject FindFolder call s:CustomFolderFinder(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Fnotinuse :execute s:Fnotinuse()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Fr :execute s:Fr(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Fsync :execute s:Fsync()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject G call s:G(<q-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject GResolveConflicts :execute s:GResolveConflicts()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Ga :execute s:Ga(<q-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gapply :execute s:Gapply()
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
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gdio :execute s:Gdio(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gdit :execute s:Gdit()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject GenerateIpynb :execute s:GenerateIpynb()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject GetOldestCommitByMe :execute s:GetOldestCommitByMe()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gfix :execute s:Gfix()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gicb :execute s:Gicb()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gitk :execute s:Gitk(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gkd :execute s:Gkd(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gkdo :execute s:Gkdo()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Glf :execute s:Glf()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Glg :execute s:Glg()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gme2 :execute s:Gme2(<q-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gpl :execute s:Gpl()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gps :execute s:Gps()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject GrevApply :execute s:GrevApply()
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
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gsubbr :execute s:Gsubbr()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gsync :execute s:Gsync()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gtg :execute s:Gtg()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Gwap :execute s:Gwap()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Hdi :execute s:Hdi()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Jformat :execute s:Jformat()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject KdiffFile :execute s:KdiffFile()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject LcTest :execute s:LcTest()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject LogFilter :execute s:LogFilter(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject MigrateFolders call s:FolderContentMigrator()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Portsforward :execute s:Portsforward()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Prune :execute s:Prune()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Reapply :execute s:Reapply()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject RelativePath :execute s:RelativePath()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject RmCat :execute s:RmCat(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SelectMove :execute s:SelectMove(<f-args>)
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SortBySize :execute s:SortBySize()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SortByTime :execute s:SortByTime()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Split :execute s:Split()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SvnApply :execute s:SvnApply()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SvnDiff :execute s:SvnDiff()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SvnReset :execute s:SvnReset()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SvnRevert :execute s:SvnRevert()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SvnSt :execute s:SvnSt()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject SvnUp :execute s:SvnUp()
command! -bang -bar -nargs=* -complete=customlist,fugitive#CompleteObject Tail :execute s:Tail()
command! -bang -bar -nargs=1 -complete=customlist,fugitive#CompleteObject Gmrg :execute s:MergeWithResolution(<f-args>)

function! s:LogFilter(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    call AsyncRunShellCommand('~/loadrc/bashrc/logFilter.sh ' . '"' .  expand('%:p') . '" "' .  arg1 . '"')
endfunction

function! s:Jformat(...) abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/bashrc/jformat.sh')
endfunction

function! s:Gkd(...) abort
    let worktree = Cd2Worktree()

    if expand('%:t') != 'index'
        if a:0 == 0
            call AsyncRunShellCommand('~/loadrc/gitrc/gkd.sh ' . 'HEAD ' . '"' .  expand('%:p') . '"')
        else
            let arg1 = (a:0 >= 1) ? a:1 : ''
            call AsyncRunShellCommand('~/loadrc/gitrc/gkd.sh ' . '"' .  arg1 . '" "' .  expand('%:p') . '"')
        endif
    else
        let arg1 = (a:0 >= 1) ? a:1 : ''
        let arg2 = (a:0 >= 2) ? a:2 : ''
        call AsyncRunShellCommand('~/loadrc/gitrc/gkd.sh ' . '"' .  arg1 . '" "' .  arg2 . '"')
    endif
endfunction

function! s:Gkdo() abort
    let worktree = Cd2Worktree()
    let target = substitute(system("git config gsync.target"), '\n', '', '')

    if expand('%:t') != 'index'
        call AsyncRunShellCommand('~/loadrc/gitrc/gkd.sh ' . '"' .  target . '" "' .  expand('%:p') . '"')
    else
        call AsyncRunShellCommand('~/loadrc/gitrc/gkd.sh ' . '"' .  target . '"')
    endif
endfunction

function! s:Ga(args, ...) abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/gitrc/ga.sh ' . '"' .  a:args . '"')
endfunction

function! s:Gsave() abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/gitrc/gsave.sh')
endfunction

function! s:Gst() abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/gitrc/gst.sh')
endfunction

function! s:Gcp(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    let arg2 = (a:0 >= 2) ? a:2 : ''
    call AsyncRunShellCommand('~/loadrc/gitrc/gcp.sh ' . '"' .  arg1 . '" "' .  arg2 . '"')
endfunction

function! s:BinaryGrep(...) abort
    call Cd2ProjectRoot("files.proj")
    let b:keyword = (a:0 >= 1) ? a:1 : ''
    call AsyncRunShellCommand('~/loadrc/bashrc/binaryGrep.sh ' . '"' .  b:keyword . '"')
    let b:keyword = substitute(b:keyword, " ", "_", "g")
    let b:keyword = substitute(b:keyword, "/", "_", "g")
    call OpenOrSwitch(b:keyword . '.binaryGrep.findresult', 'vs')
endfunction

function! s:Fnotinuse() abort
    call Cd2ProjectRoot("files.proj")
    call AsyncRunShellCommand('~/loadrc/bashrc/fnotinuse.sh')
    call OpenOrSwitch('fnotinuse.findresult', 'vs')
endfunction

function! s:Fcscope() abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/bashrc/fcscope.sh')
endfunction


function! s:Fdisklog() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/bashrc/fdisk_log.sh'
    call OpenOrSwitch(expand("$HOME") . '/loadrc/fdisk.log', 'vs')
endfunction

function! s:Glf() abort
    let worktree = Cd2Worktree()
    silent exec '!git ls-files | tee glf.runresult'
    call OpenOrSwitch('glf.runresult', 'vs')
endfunction

function! s:Glg() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/glg.sh'
    call OpenOrSwitch('glg.findresult', 'vs')
endfunction

function! s:Gps() abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/gitrc/gps.sh 2>&1 | tee gps.findresult')
endfunction

function! s:Gstp(args, ...) abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/gitrc/gstp.sh ' . '"' .  a:args . '"')
endfunction

function! s:Gstv(args, ...) abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/gitrc/gstv.sh ' . '"' .  a:args . '"')
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
    exec '!~/loadrc/gitrc/gpl.sh 2>&1 | tee gpl.findresult'
    call OpenOrSwitch('gpl.findresult', 'vs')
endfunction

function! s:Fsync() abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/gitrc/fsync.sh 2>&1 | tee fsync.findresult')
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
    exec '!~/loadrc/gitrc/gbib.sh | tee gbil.log.runresult'
    call OpenOrSwitch('gbil.log.runresult', 'vs')
endfunction

function! s:Gbig() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/gitrc/gbig.sh | tee gbil.log.runresult'
    call OpenOrSwitch('gbil.log.runresult', 'vs')
endfunction

function! s:Gbil() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/gitrc/gbil.sh'
    call OpenOrSwitch('gbil.log', 'vs')
endfunction

function! s:Gbr() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/gbr.sh'
    call OpenOrSwitch('gbr.log', 'vs')
endfunction

function! s:Gclean() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/gclean.sh'
endfunction

function! s:Gbra() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/gbra.sh'
    call OpenOrSwitch('gbra.log', 'vs')
endfunction

function! s:Gs() abort
    if expand('%:p') =~ '^fugitive:/'
        let indexFolder = substitute(expand('%:p'), '^fugitive:\/\/', '', 'g')
        let indexFolder = substitute(indexFolder, '.git.*', '.git', 'g')
    else
        let indexFolder = substitute(system("~/loadrc/gitrc/get_git.sh " . '"' . expand('%:p') . '"'), '\n', '', '')
    endif

    call OpenOrSwitch(indexFolder . '/index', 'vs')
endfunction

function! s:Gsync() abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/gitrc/gsync.sh 2>&1 | tee gsync.findresult')
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
    call AsyncRunShellCommand('~/loadrc/gitrc/gsti.sh')
endfunction

function! s:Gstl() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/gstl.sh'
    call OpenOrSwitch('gstl.findresult', 'vs')
endfunction

function! s:Gstlv() abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/gitrc/gstlv.sh')
endfunction

function! s:Gme2(args, ...) abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/gitrc/gme2.sh ' . '"' .  a:args . '" 2>&1 | tee gme2.findresult'
    call OpenOrSwitch(worktree . '/' . 'gme2.findresult', 'vs')
endfunction

function! s:G(message) abort
    let msg = empty(a:message) ? '' : input('Enter commit message: ')

    if &modified
        echom 'Please check and save your file first!!!'
        return 0
    endif

    if expand('%:p') =~ '^fugitive:/'
        return
    endif

    if &diff
        silent exec '!git reset HEAD ; git add ' . shellescape(expand('%:p'))
    endif

    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/gitrc/g.sh ' . shellescape(msg) . ' 2>&1 | tee g.runresult')

    if &diff
        on
        set winwidth=999999
        wincmd |
        syntax on
        windo diffoff
        windo set wrap
    endif
endfunction

function! s:Gdev() abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/gitrc/gdev.sh')
endfunction

function! s:Hdi() abort
    let worktree = Cd2Worktree()
    let output = 'hdi.diff'

    silent exec '!~/loadrc/hgrc/hdi.sh' . ' HEAD 2>&1 | tee ' . '"' .  output . '"'

    if bufwinnr('^' . output . '$') > 0
        silent exec "bd!" . output
    endif

    call OpenOrSwitch(output, 'vs')
endfunction

function! s:Gdi(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    let output = 'gdi.diff'

    if expand("%:t") ==# 'index' || expand("%:t") ==# 'gbr.log' || expand("%:t") ==# 'gbra.log' || expand('%:e') ==# 'findresult' || expand('%:e') ==# 'runresult' || expand('%:e') ==# 'bak'
        if a:0 >= 1
            exec '!~/loadrc/gitrc/gdi.sh HEAD ' . '"' .  a:1 . '" 2>&1 | tee ' . '"' .  output . '"'
        else
            exec '!~/loadrc/gitrc/gdi.sh 2>&1 | tee ' . '"' .  output . '"'
        endif
    elseif expand('%:t') != 'index'
        if arg1 == ''
            call fugitive#Diffsplit(0, 1, "vert", '', [])
        elseif tolower(arg1) == 'o'
            let target = substitute(system("git config gsync.target"), '\n', '', '')
            call fugitive#Diffsplit(1, 0, 'vert', target, [target])
        else
            call fugitive#Diffsplit(0, 1, "vert", arg1, [arg1])
        endif
        return
    endif

    if bufwinnr('^' . output . '$') > 0
        silent exec "bd!" . output
    endif

    let worktree = Cd2Worktree()
    call OpenOrSwitch(output, 'vs')
endfunction

function! s:Gdit() abort
    let worktree = Cd2Worktree()
    let current_branch = substitute(system("~/loadrc/gitrc/get_current_branch.sh"), '\n', '', '')
    let output = current_branch . '.gdit.diff'
    let output = substitute(output, "/", "_", "g")
    exec '!~/loadrc/gitrc/gdit.sh' . ' ' . '"' .  output . '" 2>&1 | tee ' . 'gdit.runresult'

    if bufwinnr('^' . output . '$') > 0
        silent exec "bd!" . output
    endif

    let worktree = Cd2Worktree()
    call OpenOrSwitch('gdit.runresult', 'vs')
    call OpenOrSwitch(output, 'vs')
endfunction

function! s:Gdio(...) abort
    let worktree = Cd2Worktree()
    let current_branch = substitute(system("~/loadrc/gitrc/get_current_branch.sh"), '\n', '', '')
    let output = current_branch . '.gdio.diff'
    let output = substitute(output, "/", "_", "g")
    exec '!~/loadrc/gitrc/gdio.sh'

    if bufwinnr('^' . output . '$') > 0
        silent exec "bd!" . output
    endif

    let worktree = Cd2Worktree()
    call OpenOrSwitch(output, 'vs')
endfunction

function! s:Gdi2(...) abort
    let worktree = Cd2Worktree()
    let output = 'gdi2.runresult'
    let arg1 = (a:0 >= 1) ? a:1 : ''
    exec '!~/loadrc/gitrc/gdi2.sh ' . '"' .  arg1 . '"' . ' 2>&1 | tee ' . '"' .  output . '"'
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
    call AsyncRunShellCommand('git mergetool')
endfunction

function! s:Gicb() abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/gitrc/gicb.sh')
endfunction

function! s:Gitk(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    let arg2 = (a:0 >= 2) ? a:2 : ''
    call AsyncRunShellCommand('gitk ' . '"' .  arg1 . '"' . ' ' . '"' .  arg2 . '"')
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

function! s:Gdif(...) abort
    let worktree = Cd2Worktree()
    let target = substitute(system("git config gsync.target"), '\n', '', '')
    let target = (a:0 >= 1) ? a:1 : target
    let reverse = (a:0 >= 2) ? a:2 : '-r'

    if target ==# '-r'
        let target = substitute(system("git config gsync.target"), '\n', '', '')
        let reverse = '-r'
    endif

    let output = GetEscapedResult(target) . '.diff'
    exec '!~/loadrc/gitrc/gdif.sh ' . '-b "' .  target . '" -f "' .  expand("%:p") . '" ' . reverse .  ' 2>&1 | tee ' . output
    call OpenOrSwitch(output, 'vs')
endfunction

function! s:Gco(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    exec '!~/loadrc/gitrc/gco.sh ' . '"' .  arg1 . '" 2>&1 | tee ' . 'gco.runresult'
    call OpenOrSwitch('gco.runresult', 'vs')
endfunction

function! s:Gcob(...) abort
    let worktree = Cd2Worktree()
    let arg1 = (a:0 >= 1) ? a:1 : ''
    let arg2 = (a:0 >= 2) ? a:2 : ''
    call AsyncRunShellCommand('~/loadrc/gitrc/gcob.sh ' . '"' .  arg1 . '" "' .  arg2 . '"')
endfunction

function! s:Dodev() abort
    let worktree = Cd2Worktree()
    call OpenOrSwitch('docker-compose.yml', 'vs')
endfunction

function! s:KdiffFile() abort
    only
    call asyncrun#stop('<bang>')
    call AsyncRunShellCommand('~/loadrc/leetcoderc/KdiffFile.py ' . '"' .  expand("%:p") . '"')
endfunction

function! s:ApplyBranch(args, ...) abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/gitrc/apply_branch.sh ' . '"' .  a:args . '"'
    call s:Gs()
endfunction

function! s:Gcom(args, ...) abort
    let worktree = Cd2Worktree()
    let output = 'gcom.runresult'
    exec '!~/loadrc/gitrc/gcom.sh ' . '"' .  a:args . '"' . ' 2>&1 | tee ' . '"' .  output . '"'
    call OpenOrSwitch(output, 'vs')
endfunction

function! s:Gshow(args, ...) abort
    let worktree = Cd2Worktree()
    let output = a:args . '.diff'
    silent exec '!~/loadrc/gitrc/gshow.sh ' . '"' .  a:args . '" 2>&1 | tee ' . output
    call OpenOrSwitch(output, 'vs')
endfunction

function! s:Gsubbr() abort
    let worktree = Cd2Worktree()
    let output = 'git_submodules_branch.log'
    silent exec '!~/loadrc/gitrc/git_submodules_branch.sh 2>&1 | tee ' . output
    call OpenOrSwitch(output, 'vs')
endfunction

function! s:Copy(...) abort
    if &modified
        echom 'Please check and save your file first!!!'
        return 0
    endif

    let newFile = (a:0 >= 1) ? a:1 : expand("%:p") . '.bak'
    exec '!rm ' . newFile
    exec 'w ' . newFile
    call OpenOrSwitch(newFile, 'vs')
endfunction

function! s:CatPlay(...) abort
    if &modified
        echom 'Please check and save your file first!!!'
        return 0
    endif

    let b:output = expand("%:p") . '.runresult'
    let file = expand("%:p")
    call AsyncRunShellCommand('python3 ~/loadrc/pythonrc/line_video_player.py ' . shellescape(file) . ' 2>&1 | tee -a ' . b:output)
    call OpenOrSwitch(b:output, 'vs')
endfunction

function! s:SelectMove(...) abort
    if &modified
        echom 'Please check and save your file first!!!'
        return 0
    endif

    if a:0 >= 1
        let b:output = expand("%:p") . '.runresult'
        exec '!~/loadrc/bashrc/select_move.sh ' . '"' .  expand("%:p") . '"' . ' ' . '"' . a:1 . '" 2>&1 | tee ' . b:output
        call OpenOrSwitch(b:output, 'vs')
    endif

    if a:0 >= 2
        exec '!' . '"' . a:2 . '"'
    endif

    call AsyncRunShellCommand('~/loadrc/bashrc/update_proj.sh')
endfunction

function! s:CatMove(...) abort
    if &modified
        echom 'Please check and save your file first!!!'
        return 0
    endif

    if a:0 >= 1
        exec '!~/loadrc/vishrc/cat_move.sh ' . '"' .  expand("%:p") . '"' . ' ' . '"' . a:1 . '"'
    endif

    call AsyncRunShellCommand('~/loadrc/bashrc/update_proj.sh')
endfunction

function! s:FileMove(...) abort
    if a:0 >= 1
        let curword = GetWord()
        let b:netrw_curdir = getcwd()
        let map_escape = "<|\n\r\\\<C-V>\""
        let mapsafecurdir = escape(b:netrw_curdir, map_escape)
        let oldname = ComposePath(mapsafecurdir, curword)

        if filereadable(oldname)
            exec '!~/loadrc/bashrc/file_move.sh ' . '"' .  oldname . '"' . ' ' . '"' . a:1 . '"'
            let newname = a:1 . '/' . substitute(system("basename " . '"' . oldname . '"'), '\n', '', '')
            let newname = substitute(system("realpath " . '"' . newname . '"'), '\n', '', '')
            let newname = substitute(newname, getcwd(), '.', 'e')
            call setline('.', '"' . newname . '"')
            call UpdateProj()
        endif

    endif

    call AsyncRunShellCommand('~/loadrc/bashrc/update_proj.sh')
endfunction

function! s:AppendRate(...) abort
    if a:0 >= 1
        let curword = GetWord()
        " Split curword by comma and pick the second part
        let split_curword = split(curword, ",")
        let curword = split_curword[1]
        let b:netrw_curdir = getcwd()
        let map_escape = "<|\n\r\\\<C-V>\""
        let mapsafecurdir = escape(b:netrw_curdir, map_escape)
        let oldname = ComposePath(mapsafecurdir, curword)

        if filereadable(oldname)
            exec '!~/loadrc/bashrc/append_rate.sh ' . '"' .  oldname . '"' . ' ' . '"' . a:1 . '"'
            let newname = substitute(system("~/loadrc/bashrc/append_num.sh " . '"' . oldname . '"' . ' ' . '"' . a:1 . '"'), '\n', '', '')
            let newname = substitute(newname, getcwd(), '.', 'e')
            let newname = split_curword[0] . "," . '"' . newname . '"' " Concatenate the number back to newname
            call setline('.', newname)
            call UpdateProj()
        endif
    endif

    call AsyncRunShellCommand('~/loadrc/bashrc/update_proj.sh')
endfunction

function! s:CatBadFiles(...) abort
    if &modified
        echom 'Please check and save your file first!!!'
        return 0
    endif

    exec '!~/loadrc/ffmpegrc/cat_bad_files.sh ' . '"' .  expand("%:p") . '" 2>&1 | tee cat_bad_files.runresult'

    if a:0 >= 1
        exec '!' . '"' . a:1 . '"'
    endif

    call OpenOrSwitch('cat_bad_files.runresult', 'vs')
    call AsyncRunShellCommand('~/loadrc/bashrc/update_proj.sh')
endfunction

function! s:CatRate(...) abort
    if &modified
        echom 'Please check and save your file first!!!'
        return 0
    endif

    if a:0 >= 1
        exec '!~/loadrc/vishrc/cat_rate.sh ' . '"' .  expand("%:p") . '"' . ' ' . '"' . a:1 . '"'
    endif

    call AsyncRunShellCommand('~/loadrc/bashrc/update_proj.sh')
endfunction

function! s:RmCat(...) abort
    if &modified
        echom 'Please check and save your file first!!!'
        return 0
    endif

    if expand('%:e') != "findresult"
        echom 'Please only run this command in findresult file'
        return 0
    endif

    let b:output = expand("%:p") . '.runresult'
    call RunShell('~/loadrc/vishrc/rm_cat.sh', expand("%:p"), b:output)
    call OpenOrSwitch(b:output, 'vs')
endfunction

function! s:CatDu(...) abort
    if &modified
        echom 'Please check and save your file first!!!'
        return 0
    endif

    let b:output = expand("%:p") . '.runresult'
    call RunShell('~/loadrc/vishrc/cat_du.sh', expand("%:p"), b:output)
    call OpenOrSwitch(b:output, 'vs')
endfunction

function! s:CatRun(...) abort
    if &modified
        echom 'Please check and save your file first!!!'
        return 0
    endif

    let b:output = expand("%:p") . '.runresult'
    call RunShell('~/loadrc/vishrc/cat_run.sh', expand("%:p"), b:output)
    call OpenOrSwitch(b:output, 'vs')
endfunction

function! s:Tail() abort
    exec '!tail -f ' . expand("%:p")
endfunction

function! s:GResolveConflicts() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/gitrc/resolve_merge_conflicts.sh'
endfunction

function! s:GrevApply() abort
    exec '!git apply --reverse --reject --whitespace=fix --recount --allow-empty ' . '"' .  expand('%:p') . '"'
endfunction

function! s:Gapply() abort
    exec '!git apply --reject --whitespace=fix --recount --allow-empty ' . '"' .  expand('%:p') . '"'
endfunction

function! s:Dps() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/dockerrc/dps.sh'
    call OpenOrSwitch('dps.findresult', 'vs')
endfunction

function! s:SvnUp() abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/svnrc/svnup.sh')
endfunction

function! s:SvnReset() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/svnrc/svnreset.sh'
    call OpenOrSwitch('svnreset.findresult', 'vs')
endfunction

function! s:SvnRevert() abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/svnrc/svnrevert.sh ' . '"' .  expand('%:p') . '"')
endfunction

function! s:SvnSt() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/svnrc/svnst.sh'
    call OpenOrSwitch('svnst.findresult', 'vs')
endfunction

function! s:SvnApply() abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/svnrc/svnapply.sh')
endfunction

function! s:SvnDiff() abort
    let worktree = Cd2Worktree()
    call AsyncRunShellCommand('~/loadrc/svnrc/svndiff.sh ' . '"' .  expand('%:p') . '"')
endfunction

function! s:LcTest() abort
    if (expand("%") !~ '.*leetcode.*') || (expand("%") =~ '.*\.sh')
        return
    endif
    silent exec '!~/loadrc/vishrc/lc_test.sh ' . '"' .  expand('%:p') . '"'
    call OpenOrSwitch(expand('%:p') . '.sh', 'vs')
endfunction

function! s:Portsforward() abort
    call Cd2Worktree()
    exec '!~/loadrc/bashrc/do_ports_forward.sh 2>&1 | tee do_ports_forward.runresult'
    call OpenOrSwitch('do_ports_forward.runresult', 'vs')
endfunction

function! s:Prune() abort
    call AsyncRunShellCommand('~/loadrc/vishrc/prune.sh ' . '"' .  expand('%:p') . '"')
endfunction

function! s:Fr(...) abort
    let find = (a:0 >= 1) ? a:1 : ''
    let replace = (a:0 >= 2) ? a:2 : ''
    let word_only = (a:0 >= 3) ? a:3 : ''
    call Cd2ProjectRoot("files.proj")

    if expand('%:t') != 'index'
        let fileList = expand('%:p')
    else
        let fileList = "files.proj"
    endif

    exec '!~/loadrc/bashrc/fr.sh ' . '"' .  find . '"' . ' ' . '"' .  replace . '"' . ' ' . '"' .  fileList . '"' . ' ' . '"' .  word_only . '"'
    call s:Gs()
endfunction

function! s:FindDeleted() abort
    call Cd2Worktree()
    silent exec '!~/loadrc/gitrc/find_deleted.sh 2>&1 | tee find_deleted.runresult'
    call OpenOrSwitch('find_deleted.runresult', 'vs')
endfunction

function! s:Gwap() abort
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/gwap.sh'
    call s:Gs()
endfunction

function! s:Gfix() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/gitrc/gfix.sh'
endfunction

function! s:Reapply() abort
    if (expand("%") !~ '.*.diff')
        echom 'Please only run on *gdio.diff!!!'
        return 0
    endif

    let worktree = Cd2Worktree()
    let output = 'reapply.runresult'
    exec '!~/loadrc/gitrc/reapply.sh ' . '"' .  expand("%:p") . '"' . ' 2>&1 | tee ' . '"' .  output . '"'
    call OpenOrSwitch(output, 'vs')
    call s:Gs()
endfunction

function! s:GetOldestCommitByMe() abort
    let worktree = Cd2Worktree()
    let l:script_path = "~/loadrc/gitrc/oldest_commit_by_me.sh"
    let l:output = "oldest_commit_by_me.runresult"

    silent exec "! " . l:script_path . " 2>&1 | tee " . l:output

    call OpenOrSwitch(l:output, 'vs')
endfunction

function! s:RelativePath() abort
    let worktree = Cd2Worktree()
    let file_path = getline(line("."))
    let file_path = substitute(file_path, '\\', '/', 'g') " Replace backslashes with forward slashes

    python3 << EOF
import os
import vim

file_path = vim.eval('file_path')
current_dir = vim.eval('expand("%:p:h")')

try:
    relative_path = os.path.relpath(file_path, current_dir)
    relative_path = relative_path.replace('/ ', '\\ ')
    vim.command("call setline('.', '{}')".format(relative_path))
except Exception as e:
    vim.command("echo 'Error: {}'".format(str(e)))
EOF

endfunction

function! s:Split() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/bashrc/split.sh ' . '"' .  expand('%:t') . '"'
endfunction

function! s:SortByTime() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/vishrc/sort_entries.sh ' . '"' .  expand('%:p') . '"' . ' time'
endfunction

function! s:SortBySize() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/vishrc/sort_entries.sh ' . '"' .  expand('%:p') . '"' . ' size'
endfunction

function! s:GenerateIpynb() abort
    let worktree = Cd2Worktree()
    exec '!~/loadrc/ipynbrc/generate_ipynb.sh ' . '"' .  expand('%:p') . '"'
    w
endfunction

function! s:MergeWithResolution(branch_to_merge)
    let worktree = Cd2Worktree()
    exec '!~/loadrc/gitrc/merge_with_resolution.sh ' . '"' .  a:branch_to_merge . '" 2>&1 | tee ' . 'merge_with_resolution.runresult'
    call OpenOrSwitch('merge_with_resolution.runresult', 'vs')
endfunction

function! s:CustomFolderFinder(search_directory, folder_name, ...)
    let worktree = Cd2Worktree()
    let l:script_path = "~/loadrc/zshrc/custom_folder_finder.zsh"
    let l:command = '!' . l:script_path . ' ' . a:search_directory . ' ' . a:folder_name

    " Check if the maxdepth parameter is provided and append it to the command
    if a:0 > 0
        let l:command .= ' ' . a:1
    endif

    let l:command .= ' 2>&1 | tee ' . 'custom_folder_finder.runresult'
    execute l:command
    call OpenOrSwitch('custom_folder_finder.runresult', 'vs')
endfunction

function! s:FolderContentMigrator()
    " Get the lines from the current buffer
    let lines = getline(1, '$')

    " Check if there are at least two lines
    if len(lines) < 2
        echo "Error: Not enough lines in the buffer."
        return
    endif

    " Get the source and target folders
    let target_folder = lines[0]
    let source_folders = lines[1:]

    " Call the folder_content_migrator.py script for each source folder
    let script_path = "~/loadrc/pythonrc/folder_content_migrator.py"
    for source_folder in source_folders
        let command = '!' . l:script_path . ' ' . l:source_folder . ' ' . l:target_folder . ' 2>&1 | tee ' . 'folder_content_migrator.runresult'
        execute command
    endfor
    call OpenOrSwitch('folder_content_migrator.runresult', 'vs')
endfunction

function! s:FindSimilarFilenames()
    let l:script_path = "~/loadrc/pythonrc/find_similar_filenames.py"
    let l:current_file = expand('%:p')
    let l:command = '!' . l:script_path . ' --file ' . shellescape(l:current_file) . ' 2>&1 | tee ' . 'find_similar_filenames.runresult'
    execute l:command

    call OpenOrSwitch('find_similar_filenames.runresult', 'vs')
endfunction

let g:fugitive_legacy_commands = 1
