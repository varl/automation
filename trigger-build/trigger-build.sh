#!/usr/bin/env bash

#
## bash environment
#

if test "$BASH" = "" || "$BASH" -uc "a=();true \"\${a[@]}\"" 2>/dev/null; then
    # Bash 4.4, Zsh
    set -uo pipefail
else
    # Bash 4.3 and older chokes on empty arrays with set -u.
    set -o pipefail
fi
shopt -s nullglob globstar




#
## script environment
#

source ./repo-list.sh




#
## funcs
#

main () {
    local BRANCH="$1"
    git checkout "$BRANCH"
    git commit --allow-empty -m "ci(trigger): build artifact with latest translations"
    git push origin "$BRANCH"
}





#
## run it
#

echo "https://${GITHUB_TOKEN}:@github.com" > $HOME/.git_credentials

git config --global credential.helper "store --file=$HOME/.git_credentials"
git config --global user.name "@dhis2-bot"
git config --global user.email "apps@dhis2.org"

for repo in "${repos[@]}"; do
    git clone "https://github.com/dhis2/${repo}.git" "./repos/${repo}" 
    pushd "./repos/${repo}"
    for branch in "$@"; do
        echo "... ${branch}"
        main "$branch" 
    done
    popd
done
