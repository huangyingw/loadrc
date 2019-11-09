cscopes=($(find . -type f -name files.proj))
for cscope in "${cscopes[@]}"
do
  echo "${cscope}"
  ~/loadrc/bashrc/cscope.sh $(dirname "${cscope}")
done
