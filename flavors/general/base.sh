GENTOO_MIRRORS="https://mirrors.aliyun.com/gentoo/ https://mirrors.ustc.edu.cn/gentoo/"

LINGUAS="zh_CN zh en_US en"
L10N="en en-US zh zh-CN zh-TW ja"

EMERGE_DEFAULT_OPTS="--ask-enter-invalid"

FEATURES="parallel-install parallel-fetch userfetch userpriv usersandbox"
# sandbox
FEATURES="${FEATURES} cgroup" # ipc-sandbox mount-sandbox pid-sandbox seems enabled by default
# debuginfo
FEATURES="${FEATURES} compressdebug splitdebug"
#FEATURES="${FEATURES} distcc"

# XZ compress docs
PORTAGE_COMPRESS="zstd"
PORTAGE_COMPRESS_FLAGS="-6"

BINPKGS_COMPRESS="zstd"

EGIT_CLONE_TYPE=shallow
