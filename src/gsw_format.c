/*
**  $Id: gsw_format.c,v 7c235f8731c0 2013/09/17 15:56:24 fdelahoyde $
**
**  gsw_format -- format the TEOS-10 V3.0  global absolute salinity anomaly
**  and absolute salinity anomaly ratio data into C for subsequent compilation.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <R.h>
#include <Rdefines.h>
#include <Rinternals.h>

int
main(int argc, char **argv)
{
	int	nx=91, ny=45, nz=45;
#define MAX_CHARS 110
	int	i;
	double	*longs_ref, *lats_ref, *p_ref, *ndepth_ref, *saar_ref,
		*delta_sa_ref;
	FILE	*fin;
	char	buf[256], b[64], *pC;

	longs_ref	= malloc(nx*sizeof (double));
	lats_ref	= malloc(ny*sizeof (double));
	p_ref		= malloc(nz*sizeof (double));
	ndepth_ref	= malloc(nx*ny*sizeof (double));
	saar_ref	= malloc(nx*ny*nz*sizeof (double));
	delta_sa_ref	= malloc(nx*ny*nz*sizeof (double));

	if ((fin=fopen("gsw_data_v3_0.dat", "r"))==NULL) {
	    //perror("gsw_data_v3_0.dat");
	    error("cannot find file gsw_data_v3_0.dat");
	}
	for (i=0; i<nx; i++) {
	    if (fgets(buf, sizeof (buf), fin)==NULL)
		break;
	    longs_ref[i]	= strtod(buf, NULL);
	}
	for (i=0; i<ny; i++) {
	    if (fgets(buf, sizeof (buf), fin)==NULL)
		break;
	    lats_ref[i]		= strtod(buf, NULL);
	}
	for (i=0; i<nz; i++) {
	    if (fgets(buf, sizeof (buf), fin)==NULL)
		break;
	    p_ref[i]		= strtod(buf, NULL);
	}
	for (i=0; i<nx*ny; i++) {
	    if (fgets(buf, sizeof (buf), fin)==NULL)
		break;
	    ndepth_ref[i]	= strtod(buf, NULL);
	}
	for (i=0; i<nx*ny*nz; i++) {
	    if (fgets(buf, sizeof (buf), fin)==NULL)
		break;
	    saar_ref[i]		= strtod(buf, NULL);
	}
	for (i=0; i<nx*ny*nz; i++) {
	    if (fgets(buf, sizeof (buf), fin)==NULL)
		break;
	    delta_sa_ref[i]	= strtod(buf, NULL);
	}
	fclose(fin);
	Rprintf("static int\tgsw_nx=%d, gsw_ny=%d, gsw_nz=%d;\n",
		nx, ny, nz);
	Rprintf("static double\tlongs_ref[%d] = {\n",nx);
	buf[0]	= '\0';
	for (i=0; i<nx; i++) {
	    sprintf(b,"%.17g", longs_ref[i]);
	    if (i<(nx-1))
		strcat(b,",");
	    if (strlen(buf)+strlen(b) > MAX_CHARS) {
		Rprintf("\t%s\n",buf);
		buf[0]	= '\0';
	    }
	    strcat(buf,b);
	}
	if (strlen(buf) != 0)
	    Rprintf("\t%s\n",buf);
	Rprintf("\t};\n");
	Rprintf("static double\tlats_ref[%d] = {\n",ny);
	buf[0]	= '\0';
	for (i=0; i<ny; i++) {
	    sprintf(b,"%.17g", lats_ref[i]);
	    if (i<(ny-1))
		strcat(b,",");
	    if (strlen(buf)+strlen(b) > MAX_CHARS) {
		Rprintf("\t%s\n",buf);
		buf[0]	= '\0';
	    }
	    strcat(buf,b);
	}
	if (strlen(buf) != 0)
	    Rprintf("\t%s\n",buf);
	Rprintf("\t};\n");
	Rprintf("static double\tp_ref[%d] = {\n",nz);
	buf[0]	= '\0';
	for (i=0; i<nz; i++) {
	    sprintf(b,"%.17g", p_ref[i]);
	    if (i<(nz-1))
		strcat(b,",");
	    if (strlen(buf)+strlen(b) > MAX_CHARS) {
		Rprintf("\t%s\n",buf);
		buf[0]	= '\0';
	    }
	    strcat(buf,b);
	}
	if (strlen(buf) != 0)
	    Rprintf("\t%s\n",buf);
	Rprintf("\t};\n");
	Rprintf("static double\tndepth_ref[%d] = {\n",nx*ny);
	buf[0]	= '\0';
	for (i=0; i<nx*ny; i++) {
	    sprintf(b,"%.17g", ndepth_ref[i]);
	    if (i<(nx*ny-1))
		strcat(b,",");
	    if (strlen(buf)+strlen(b) > MAX_CHARS) {
		Rprintf("\t%s\n",buf);
		buf[0]	= '\0';
	    }
	    strcat(buf,b);
	}
	if (strlen(buf) != 0)
	    Rprintf("\t%s\n",buf);
	Rprintf("\t};\n");
	Rprintf("static double\tsaar_ref[%d] = {\n",nx*ny*nz);
	buf[0]	= '\0';
	for (i=0; i<nx*ny*nz; i++) {
	    sprintf(b,"%.17g", saar_ref[i]);
	    if (i<(nx*ny*nz-1))
		strcat(b,",");
	    if (strlen(buf)+strlen(b) > MAX_CHARS) {
		Rprintf("\t%s\n",buf);
		buf[0]	= '\0';
	    }
	    strcat(buf,b);
	}
	if (strlen(buf) != 0)
	    Rprintf("\t%s\n",buf);
	Rprintf("\t};\n");
	Rprintf("static double\tdelta_sa_ref[%d] = {\n",nx*ny*nz);
	buf[0]	= '\0';
	for (i=0; i<nx*ny*nz; i++) {
	    sprintf(b,"%.17g", delta_sa_ref[i]);
	    if (i<(nx*ny*nz-1))
		strcat(b,",");
	    if (strlen(buf)+strlen(b) > MAX_CHARS) {
		Rprintf("\t%s\n",buf);
		buf[0]	= '\0';
	    }
	    strcat(buf,b);
	}
	if (strlen(buf) != 0)
	    Rprintf("\t%s\n",buf);
	Rprintf("\t};\n");
	return (0);
}
