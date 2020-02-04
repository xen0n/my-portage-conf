source ./mips64el-base.sh


CFLAGS="-march=gs464e -mtune=gs464e -mmsa -falign-functions=32 ${CFLAGS} -pipe -ggdb"
CXXFLAGS="${CFLAGS}"
LDFLAGS="${LDFLAGS} -Wl,--hash-style=gnu"
