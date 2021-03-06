source ./mips64el-base.sh


#CFLAGS="-march=gs464v -mtune=gs464v -falign-functions=32 ${CFLAGS} -pipe -ggdb -mno-unaligned-accesses"
#CFLAGS="-march=gs464e -mtune=gs464e -mmsa -falign-functions=32 ${CFLAGS} -pipe -ggdb"

# gs464e pessimizes things by generating branch likely insns it seems
CFLAGS="-march=mips64r2 -mtune=gs464e -mmsa -falign-functions=32 ${CFLAGS} -pipe -ggdb"
CXXFLAGS="${CFLAGS}"
#LDFLAGS="${LDFLAGS} -Wl,--hash-style=gnu"
