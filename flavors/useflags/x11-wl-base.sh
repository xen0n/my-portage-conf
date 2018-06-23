source ./base.sh


# X11
USE="${USE} X xcb xcomposite xft xinerama xorg xv xvmc gallium g3dvl openvg"
# Wayland
USE="${USE} wayland libinput"
# Security
USE="${USE} policykit"  # after hardened profile switch
