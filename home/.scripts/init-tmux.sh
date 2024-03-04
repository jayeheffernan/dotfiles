tmux start-server
smug start logs --detach
smug start proxy --detach
smug start ludwig --detach
smug start website --detach --detach
smug start chrome-extension --detach
tmuxlogs split
set_wallpaper
