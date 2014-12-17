#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include "gswteos-10.h"


/*

system("R CMD SHLIB teos.c")
dyn.load("teos.so")
# test from http://www.teos-10.org/pubs/gsw/html/gsw_SP_from_C.html
C <- c(34.5487, 34.7275, 34.8605, 34.6810, 34.5680, 34.5600)
t <- c(28.7856, 28.4329, 22.8103, 10.2600, 6.8863, 4.4036)
p <- c(     10,      50,     125,     250,    600,   1000)
SP <- .C("wrap_gsw_sp_from_c", as.double(C), as.double(t), as.double(p), length(C), rval=double(length(C)))$rval
stopifnot(all.equal(SP,c(20.009869599086951,20.265511864874270,22.981513062527689,31.204503263727982,34.032315787432829,36.400308494388170)))


*/

void wrap_gsw_sp_from_c(double *c, double *t, double *p, int *n, double *rval)
{
    extern double gsw_sp_from_c(double c, double t, double p);
    for (int i=0; i < *n; i++) {
        rval[i] = gsw_sp_from_c(c[i], t[i], p[i]);
    }
}


