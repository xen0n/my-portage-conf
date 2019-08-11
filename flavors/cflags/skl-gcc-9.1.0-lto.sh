source ./amd64-base.sh


#CFLAGS="-march=broadwell -mmmx -mno-3dnow -msse -msse2 -msse3 -mssse3 -mno-sse4a -mcx16 -msahf -mmovbe -maes -mno-sha -mpclmul -mpopcnt -mabm -mno-lwp -mfma -mno-fma4 -mno-xop -mbmi -mno-sgx -mbmi2 -mno-pconfig -mno-wbnoinvd -mno-tbm -mavx -mavx2 -msse4.2 -msse4.1 -mlzcnt -mrtm -mhle -mrdrnd -mf16c -mfsgsbase -mrdseed -mprfchw -madx -mfxsr -mxsave -mxsaveopt -mno-avx512f -mno-avx512er -mno-avx512cd -mno-avx512pf -mno-prefetchwt1 -mno-clflushopt -mno-xsavec -mno-xsaves -mno-avx512dq -mno-avx512bw -mno-avx512vl -mno-avx512ifma -mno-avx512vbmi -mno-avx5124fmaps -mno-avx5124vnniw -mno-clwb -mno-mwaitx -mno-clzero -mno-pku -mno-rdpid -mno-gfni -mno-shstk -mno-avx512vbmi2 -mno-avx512vnni -mno-vaes -mno-vpclmulqdq -mno-avx512bitalg -mno-movdiri -mno-movdir64b --param l1-cache-size=32 --param l1-cache-line-size=64 --param l2-cache-size=20480 -mtune=broadwell -falign-functions=32 ${CFLAGS} -pipe"
CFLAGS="-march=skylake -mtune=skylake -falign-functions=32 ${CFLAGS} -pipe -g"
CXXFLAGS="${CFLAGS}"
LDFLAGS="${LDFLAGS} -Wl,--hash-style=gnu"
