#!/bin/zsh

cd ~/loadrc/

function fun1()
{
    find . -type f -exec grep -Il "" {} + > fun1.log
}

function fun2()
{
    find . -type f -exec grep -Iq . {} \; -print > fun2.log # auto-ignore the zero size file  
}

function fun3()
{
    find . -type f -exec grep -Il "" {} \; > fun3.log 
}

function fun4()
{
    find . -type f -exec grep -Il . {} + > fun4.log # auto-ignore the zero size file  
}

function fun5()
{
    find . -type f -print0 | xargs -0 grep -Il . > fun5.log # auto-ignore the zero size file
}

if [ "$1" = "1" ]
