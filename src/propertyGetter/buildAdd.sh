gcc -c -fPIC add.c -o add.o
gcc add.o -shared -o ../../software/julia-0.4.0-dev/lib/libadd.so

rm add.o
