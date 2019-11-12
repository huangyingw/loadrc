#!/bin/bash
find . -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.hpp" -o -name "*.java"> cscope.files
cscope -Rq cscope.files
