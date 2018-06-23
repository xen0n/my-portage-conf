GENTOO_MIRRORS="https://mirrors.163.com/gentoo/"

LINGUAS="zh_CN zh en_US en"
L10N="en en-US zh zh-CN zh-TW ja"

EMERGE_DEFAULT_OPTS="--ask-enter-invalid"

FEATURES="nostrip parallel-install parallel-fetch userfetch userpriv usersandbox"
#FEATURES="${FEATURES} distcc"

# XZ compress docs
PORTAGE_COMPRESS="xz"
PORTAGE_COMPRESS_FLAGS="-6"
