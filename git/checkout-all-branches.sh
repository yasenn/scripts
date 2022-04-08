# via [Git pull all remote branches](https://gist.github.com/grimzy/a1d3aae40412634df29cf86bb74a6f72)

for abranch in $(git branch -a | grep -v HEAD | grep remotes | sed "s/remotes\\/origin\\///g"); do git checkout $abranch ; done

## alternatives:
# git branch -r | grep -v '\->' | while read remote; do echo "parsing branch $remote"; git checkout "$remote";git pull; echo "$remote done";done
# current=$(git branch --show-current) ; for brname in $(git branch -r | grep origin | grep -v master | grep -v HEAD | awk '{gsub(/^[^\/]+//,"",$1); print $1}'); do echo git checkout $brname ; git checkout $brname ; echo git pull ; git pull ; done ; echo git checkout $current ;git checkout $current
# remote=origin ; for brname in `git branch -r | grep $remote | grep -v master | grep -v HEAD | awk '{gsub(/^[^\/]+\//,"",$1); print $1}'`; do git branch --track $brname $remote/$brname || true; done 2>/dev/null
