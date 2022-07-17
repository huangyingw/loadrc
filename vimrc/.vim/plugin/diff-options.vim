if &filetype !=# python
    set diffopt+=iwhiteall
endif

set diffopt+=iblank
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
