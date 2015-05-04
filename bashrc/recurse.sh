#!/bin/bash
recurse()
{
  # since the example runs slowly, the following
  # if-elif avoid unuseful output; the elif was
  # added after a first run ended with a segmentation
  # fault after printing "10000"
  if [[ $(($1 % 50)) -eq 0 ]]; then 
    echo $1;
  elif [[ $1 -gt 100 ]]; then
    echo $1
  fi
  recurse $(($1 + 1))
}

recurse 0
