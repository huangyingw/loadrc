#!/bin/zsh -
find . -type f -name *.ipynb | while read ss
do                                                                      
    jupyter nbconvert --to=python --template=python.tpl "$ss" --output "$(basename $ss).py" 
    sed -i"" '/^$/d' "$ss.py"
    sed -i"" '/^#$/d' "$ss.py"
    autopep8 --in-place "$ss.py"
    cp -nv "$ss.py" "$(echo $ss.py | sed 's/\.ipynb//g' )"
done
