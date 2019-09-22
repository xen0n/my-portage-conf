source ./mips64el-base.sh


CFLAGS="-march=loongson3a -mtune=loongson3a -falign-functions=32 ${CFLAGS} -pipe -ggdb"
CXXFLAGS="${CFLAGS}"
#LDFLAGS="${LDFLAGS} -Wl,--hash-style=gnu"
