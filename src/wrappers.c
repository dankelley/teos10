#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include "gswteos-10.h"

void wrap_gsw_ct_from_t(double *sa, double *t, double *p, int *n, double *rval)
{
    extern double gsw_ct_from_t(double sa, double t, double p);
    for (int i=0; i < *n; i++)
        rval[i] = gsw_ct_from_t(sa[i], t[i], p[i]);
}

void wrap_gsw_sa_from_sp(double *sa, double *p, double *longitude, double *latitude,
        int *n, double *rval)
{
    extern double gsw_sa_from_sp(double sa, double p, double longitude, double latitude);
    for (int i=0; i < *n; i++)
        rval[i] = gsw_sa_from_sp(sa[i], p[i], longitude[i], latitude[i]);
}

void wrap_gsw_sp_from_c(double *c, double *t, double *p, int *n, double *rval)
{
    extern double gsw_sp_from_c(double c, double t, double p);
    for (int i=0; i < *n; i++)
        rval[i] = gsw_sp_from_c(c[i], t[i], p[i]);
}

