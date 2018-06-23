# X11 things
INPUT_DEVICES="evdev synaptics libinput"
VIDEO_CARDS="radeon intel i965 r600"

# Sound cards
ALSA_CARDS="hda-intel usb-audio"

# QEMU targets
QEMU_SOFTMMU_TARGETS="alpha arm aarch64 cris i386 lm32 m68k microblaze microblazeel mips mips64 mips64el mipsel or32 ppc ppc64 ppcemb s390x sh4 sh4eb sparc sparc64 unicore32 x86_64"
QEMU_USER_TARGETS="arm aarch64 mips64el"

# steam-overlay suggests this
USE_EXPAND="${USE_EXPAND} STEAMGAMES"
