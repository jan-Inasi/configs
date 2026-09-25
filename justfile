set dotenv-load

source-tmux := "tmux/.tmux.conf"
source-env := ".env.example"
source-zed-keymap := "zed/keymap.json"

target-tmux := env("CONFIG_TARGET_TMUX", "$HOME/.tmux.conf")
target-zed-keymap := env("CONFIG_TARGET_ZED_KEYMAP", "$HOME/.config/zed/keymap.json")

setup-script := "./scripts/setup.sh"
diff-script := "./scripts/gitdiff.sh"

_default:
    @just --list

# install tmux config file
tmux:
    {{setup-script}} {{source-tmux}} {{target-tmux}}

# install zed keymap
zed:
    {{setup-script}} {{source-zed-keymap}} {{target-zed-keymap}}

# install env file
env:
    {{setup-script}} {{source-env}} .env

# installed vs uninstalled tmux config file
diff-tmux:
    {{diff-script}} {{source-tmux}} {{target-tmux}}

# installed vs uninstalled env file
diff-env:
    {{diff-script}} {{source-env}} .env

# installed vs uninstalled zed keymap
diff-zed:
    {{diff-script}} {{source-zed-keymap}} {{target-zed-keymap}}
