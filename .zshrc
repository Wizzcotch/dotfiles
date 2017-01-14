# Created by newuser for 5.3

~/bin/capstoctrl.sh

git_clone () {
    if [[ $1 != "" && $2 != "" ]]; then
        git clone https://github.com/$1/$2.git
    fi
}

alias clone=git_clone

