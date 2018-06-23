source ./x11-wl-base.sh


# GUI features
USE="${USE} cairo dga dri fbcon fontconfig gtk gtk3 lcms libnotify opengl qt4 qt5 truetype wxwidgets"
USE="${USE} qt3support"  # after hardened profile switch
# File formats
USE="${USE} djvu"
USE="${USE} pdf ppds"  # after hardened profile switch
# Hardware features
USE="${USE} v4l v4l2"
USE="${USE} udisks upower"  # after hardened profile switch
# Network
USE="${USE} rdesktop rss vnc"
# Media features
# general
USE="${USE} bluray dts dvb encode ffmpeg gstreamer libass matroska mplayer ogg sdl taglib"
USE="${USE} pango"  # after hardened profile switch
USE="${USE} -libav"
# video
USE="${USE} aalib libcaca mp4 mpeg theora x264 xvid vaapi vdpau libv4l libv4l2"
# audio
# 20130524 xenon: add JACK for some really real-time things; also for USB audio switching
# 20151125 xenon: enable pulseaudio, can't tolerate lack of headphone jack detection any more
USE="${USE} a52 aac flac jack ladspa lame libsamplerate mad mp3 vorbis wavpack pulseaudio"
# image formats
USE="${USE} exif gif jpeg jpeg2k mng png raw svg tiff xpm"
# Miscellaneous flags
USE="${USE} branding firefox lock -minimal nsplugin session startup-notification webkit xml"
USE="${USE} steamruntime"


USE="${USE} gnome-keyring"
