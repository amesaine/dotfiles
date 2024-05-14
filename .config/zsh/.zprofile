# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$HOME/.config/sway/bin:$PATH"

export GTK_THEME=Dracula
export XCURSOR_THEME=Bibata-Modern-Ice
export EDITOR=nvim
export MOZ_ENABLE_WAYLAND=1
export XDG_CURRENT_TYPE=wayland
export RUST_BACKTRACE=1
export QT_QPA_PLATFORM=wayland
export XDG_CONFIG_HOME=$HOME/.config

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#999999,bg=#282A36"


eval "$(keychain --eval --quiet id_ed25519)"


SOCK="/tmp/ssh-agent-$USER"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f /tmp/ssh-agent-$USER
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi

if [ "$(tty)" = "/dev/tty1" ] ; then
    export XDG_CURRENT_DESKTOP=sway
    exec sway
fi
