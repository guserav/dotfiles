if test "$(tty)" = "/dev/tty1"
    export MOZ_ENABLE_WAYLAND=1
    export _JAVA_AWT_WM_NONREPARENTING=1
    export SDL_VIDEODRIVER=wayland
    export MOZ_ENABLE_WAYLAND=1
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=sway
    export XDG_CURRENT_DESKTOP=sway
    export GDK_BACKEND='wayland,x11'
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_QPA_PLATFORM='wayland;xcb'
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    exec bash -c "eval \$(ssh-agent); exec /usr/bin/sway"
end
