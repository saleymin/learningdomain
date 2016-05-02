#include<stdio.h>



void hello()
{
    printf("Hello World\n");
}


int add(int a, int b)
{
	printf("Hello add");
    return a+b;
}

int getsizeInt()
{
    return sizeof(int);
}

int getsizeLong()
{
    return sizeof(long);
}

int getsizeLong2()
{
    return sizeof(long double);
}

int getsizeDouble()
{
    return sizeof(double);
}
