GENTOO_MIRRORS="https://mirrors.aliyun.com/gentoo/ https://mirrors.ustc.edu.cn/gentoo/"

LINGUAS="zh_CN zh en_US en eo"
L10N="en en-US zh zh-CN zh-TW ja eo"

EMERGE_DEFAULT_OPTS="--ask-enter-invalid"

FEATURES="parallel-install parallel-fetch userfetch userpriv usersandbox"
# sandbox
#FEATURES="${FEATURES} cgroup" # ipc-sandbox mount-sandbox pid-sandbox seems enabled by default
# debuginfo
FEATURES="${FEATURES} compressdebug splitdebug"
#FEATURES="${FEATURES} distcc"

PORTAGE_SCHEDULING_POLICY=idle
PORTAGE_NICENESS=10

PORTAGE_COMPRESS="zstd"
PORTAGE_COMPRESS_FLAGS="-6"
BINPKGS_COMPRESS="zstd"

EGIT_CLONE_TYPE=shallow
