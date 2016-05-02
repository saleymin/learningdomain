cd /disk2/home/suleyman/works/Library/SuiteSparse/CSparse
gcc -c -IInclude -fPIC Source/*.c
gcc *.o -shared -o ../../../../software/julia-0.4.0-dev/lib/libcsparse.so
rm *.o

