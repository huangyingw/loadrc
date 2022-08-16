if (expand('%:e') !=# 'py')
    set diffopt+=iwhiteall
endif

set diffopt+=iblank
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
