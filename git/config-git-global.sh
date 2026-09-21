set -euo pipefail

git config --global user.name jan-inasi
git config --global user.email ignacymajkusiak@gmail.com


exists() {
    command -v "$1" >/dev/null 2>&1
}

if exists nvim; then
    git config --global core.editor nvim
elif exists hx; then
    git config --global core.editor hx
elif exists vim; then
    git config --global core.editor vim
elif exists vi; then
    git config --global core.editor vi
fi

git config --global alias.s status
git config --global alias.ss 'status --short'
git config --global alias.b branch
git config --global alias.c commit
git config --global alias.a add
git config --global alias.d diff
git config --global alias.co checkout

git config --global alias.graph 'log --oneline --graph'

git config --global alias.whoami \
    '!git config user.name && git config user.email'

