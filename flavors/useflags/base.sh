USE="smp"
# CLI features
USE="${USE} bash-completion ncurses readline zsh-completion"
# Hardware features
USE="${USE} acpi alsa cdda cdr cups dvd dvdr gpm lm_sensors udev usb wifi"
# Programming language and devel things
USE="${USE} multilib -static-libs c++0x cxx fortran graphite java libffi nptl openmp pch perl php gd sharedext python threads vim-syntax"
# {,D}VCS of choice
USE="${USE} git mercurial subversion"
# Libraries
USE="${USE} bzip2 dbus fftw gdbm lzma mime mmap pcre sqlite3 zlib"  # postgres
USE="${USE} udisks upower"  # after hardened profile switch
# Kernel and system
USE="${USE} modules syslog xattr"
# Network
USE="${USE} ftp ipv6 idn -gnutls ssl openssl ldap -dhcpcd dhclient"
# L10N things
USE="${USE} cjk unicode iconv icu nls spell"
# Security
USE="${USE} caps crypt sasl"  # hardened
# Init system
USE="${USE} -consolekit systemd"
