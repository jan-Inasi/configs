source-tmux := "tmux/.tmux.conf"
source-zed-keymap := "zed/keymap.json"

setup-script := "./scripts/setup.sh"
diff-script := "./scripts/gitdiff.sh"

_default:
    @just --list

# install tmux config file
tmux:
    {{setup-script}} {{source-tmux}} "$HOME/.tmux.conf"

# installed vs uninstalled tmux config file
diff-tmux:
    {{diff-script}} {{source-tmux}} "$HOME/.tmux.conf"
