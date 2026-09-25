source-tmux := "tmux/.tmux.conf"
source-zed-keymap := "zed/keymap.json"

_default:
    @just --list

# install tmux config file
tmux:
    ./tmux/setup.sh

# installed vs uninstalled tmux config file
diff-tmux:
    ./scripts/gitdiff.sh {{source-tmux}} "$HOME/.tmux.conf"
