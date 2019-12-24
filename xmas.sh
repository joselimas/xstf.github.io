#!/bin/bash
trap "tput reset; tput cnorm; exit" 2

clear
tput civis
lin=2
columns=$(tput cols)
col=$(($(tput cols) / 2))
c=$((col-1))
est=$((c-2))
color=0
tput setaf 2; tput bold

for ((i=1; i<20; i+=2))
{
    tput cup $lin $col
    for ((j=1; j<=i; j++))
    {
        echo -n \*
    }
    let lin++
    let col--
}

tput sgr0; tput setaf 3

for ((i=1; i<=2; i++))
{
    tput cup $((lin++)) $c
    echo 'xXx'
}

new_year=$(date +'%Y')
let new_year++
tput setaf 1; tput bold
tput cup $lin $((c - 6)); echo MERRY CHRISTMAS
tput cup $((lin + 1)) $((c - 11)); echo And lots of FLAGS in $new_year
let c++
k=1

tput setaf 2; tput bold
ll=$(echo "ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAoKICAgICAgICAgIC4tOjovLy8vLy8rLy8vLy86Oi0uICAgICAgICAgIAogICAgICAgLS8vOjotLytvb3MrOm9vby9vKy8tOjovLy0gICAgICAgCiAgICAgICA6Ly06b28vKytvK3Mvc3NzbysvK3MrLy0vOiAgICAgICAKICAgICAgIGBvLSs6LS0tLy9vby8vK28vLzotLTovLStgICAgICAgIAogICAgIC1gICs6LS0tLSsvby95aGh5L28vKy0tLS06KyBgLSAgICAgCiAgLy9gKy8vLystLS0rLSstOk5NTU4tLSstKy0tLSsvLy8rYC86ICAKYC8vLy86Ly0tLzotLSsvby8vb01Oby8vby8rLS06Ky0tLzovLy8vIAogLi0vLzo6Ly9gKzotOi8vLzpkTU1oOi8vLzotOisuKzovOi8vLS4gCiBgLjorIC0uLjovbzotOisrK3Nvc3MrKys6LTpvLzouLi0gKzouICAKICAgICAgICAgICAuKzotLTovKysrKy86LS06Ky4gICAgICAgICAgIAogICAgICAgICAgICAgOi8tc29oc2hvZHM6LzogICAgICAgICAgICAgCiAgICAgICAgICAgICAgLisrLy86LzorLysuICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgLisrOi0tOisrLiAgICAgICAgICAgICAgIAogICAgICAgICAgIGAtOi8tYCAtLy8tIGAtLzouICAgICAgICAgICAgCiAgICAgICAgIC4vK28rICAgICAgICAgICAgK28rOi4gICAgICAgICAKICAgICAgICAgYCsrKzogICAgICAgICAgICAvKysrICAgICAgICAgIAogICAgICAgICAgIGAgICAgICAgICAgICAgICAgYCAgICAgICAgICAgCiA=" | base64 --decode)
while IFS= read -r line; do
    printf "%*s\n" $(((${#line}+$columns)/2)) "$line"
done <<< "$ll"

while true; do
    for ((i=1; i<=35; i++)) {
        [ $k -gt 1 ] && {
            tput setaf 2; tput bold
            tput cup ${line[$[k-1]$i]} ${column[$[k-1]$i]}; echo \*
            unset line[$[k-1]$i]; unset column[$[k-1]$i]
        }

        li=$((RANDOM % 9 + 3))
        start=$((c-li+2))
        co=$((RANDOM % (li-2) * 2 + 1 + start))
        tput setaf $color; tput bold
        tput cup $li $co
        echo o
        line[$k$i]=$li
        column[$k$i]=$co
        color=$(((color+1)%8))
        sh=0
        for l in F L A G S
        do
            tput cup $((lin+1)) $((c+sh))
            echo $l
            let sh++
            sleep 0.01
        done
    }
    
    k=$((k % 2 + 1))
done
