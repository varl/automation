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
    local BASE="$1"
    declare -a array
    readarray -t array < <(hub pr list --base="$BASE" --format='%I|%t%n')

    for PR in "${array[@]}"; do
        local pr_id="$(echo $PR | cut -d "|" -f 1)"
        local pr_title="$(echo $PR | cut -d "|" -f 2)"
        local scope="$(echo $pr_title | cut -d ":" -f 1)"
        local body="/tmp/${pr_id}-body.json"

        if [ "chore(translations)" == "$scope" ]; then
            pr_url=$(hub pr show "$pr_id" --url)
            echo "Transifex PR: ${pr_id} ${pr_title}"
            echo "${pr_url}"
            cat << EOF > "$body"
{
  "commit_title": "${pr_title}",
  "commit_message": "Automatically merged.",
  "merge_method": "squash"
}
EOF
            res=$(hub api --method PUT "repos/{owner}/{repo}/pulls/${pr_id}/merge" --input "$body")
            echo "Result: $res"
            rm "$body"
            sleep 1
        fi
    done
}

for repo in "${repos[@]}"; do
    git clone --depth 1 "https://github.com/dhis2/${repo}.git" "./repos/${repo}" 
    pushd "./repos/${repo}"
    for branch in "$@"; do
        echo "... ${branch}"
        main "$branch" 
    done
    popd
done
