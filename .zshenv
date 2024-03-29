export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export CARGO_HOME=${CARGO_HOME:-$XDG_DATA_HOME/cargo}
export CUDA_CACHE_PATH=${CUDA_CACHE_PATH:-$XDG_CACHE_HOME/nv}
export GOPATH=${GOPATH:-$XDG_DATA_HOME/go}
export GTK2_RC_FILES=${GTK2_RC_FILES:-$XDG_CONFIG_HOME/gtk-2.0/gtkrc}
export IPYTHONDIR=${IPYTHONDIR:-$XDG_CONFIG_HOME/ipython}
export JUPYTER_CONFIG_DIR=${JUPYTER_CONFIG_DIR:-$XDG_CONFIG_HOME/jupyter}
export KERAS_HOME=${KERAS_HOME:-$XDG_STATE_HOME/keras}
export RUSTUP_HOME=${RUSTUP_HOME:-$XDG_DATA_HOME/rustup}
export HISTFILE=${HISTFILE:-$XDG_DATA_HOME/zsh/history}
export SSH_AUTH_SOCK=${SSH_AUTH_SOCK:-$XDG_RUNTIME_DIR/ssh-agent.socket}
export DOCKER_CONFIG=${DOCKER_CONFIG:-$XDG_CONFIG_HOME/docker}
export MYSQL_HISTFILE=${MYSQL_HISTFILE:-$XDG_DATA_HOME/mysql_history}
export PATH="$HOME/.local/bin:$PATH"
. "$CARGO_HOME/env"
