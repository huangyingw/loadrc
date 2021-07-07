"let os = substitute(system('uname'), "\n", "", "")
"
"if os == "Linux"
"    set clipboard=unnamedplus
"else
"    set clipboard=unnamed
"endif
