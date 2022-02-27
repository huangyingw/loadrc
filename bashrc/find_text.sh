#!/bin/zsh

cd ~/loadrc/

function fun1()
{
    find . -type f -exec grep -Il "" {} + > fun1.log
}

function fun2()
{
    find . -type f -exec grep -Iq . {} \; -print > fun2.log
}

function fun3()
{
    find . -type f -exec grep -Il "" {} \; > fun3.log
}

function fun4()
{
    find . -type f -exec grep -Il . {} + > fun4.log
}

function fun5()
{
    find . -type f -print0 | xargs -0 grep -IZl . > fun5.log
}

fun1
fun2
fun3
fun4
fun5
