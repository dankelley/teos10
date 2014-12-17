//#define DEBUG 1
// vim: set noexpandtab shiftwidth=2 softtabstop=2 tw=70:
//
// This code uses "WIN32" and similar as the compiler symbol to detect Windows.
//
// FIXME: dlclose(), or the MSWindows equivalent, is never called,
// because the idea here is to cache the library 'handle'.
//
// RESOURCES on the Windows/Unix handling of libraries:
// 1. http://www.codeproject.com/Articles/13501/Platform-Independent-Coding-DLLs-and-SOs
// 2. http://www.ibm.com/developerworks/aix/library/au-porting/

//*lib = "/usr/local/lib/libgswteos-10.so"; // FIXME: testing, since getting an error otherwise
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <R.h>
#include <Rdefines.h>
#include <Rinternals.h>

#if defined(WIN32) || defined(WIN64) || defined(_WIN32) || defined(_WIN64)
#include <windows.h>
#else
#include <dlfcn.h>
#endif

static void *teos_handle = NULL;

//#define DEBUG

static int first_teos_call = 1;

char *libteosp;
// system("R CMD SHLIB sw.c")
// .C("set_libteos", "dan")
void set_libteos(char **lib)
{
#ifdef DEBUG
  Rprintf("set_libteos(\"%s\")\n", *lib);
#endif
  libteosp = (char *)malloc(sizeof(char)*(1+strlen(*lib)));
  strcpy(libteosp, *lib);
}

char *get_libteos()
{
  return(libteosp);
}

void gsw2a(char **lib, char **name, int *n, double *a1, double *a2, double *rval)
{
#ifdef DEBUG
  Rprintf("gsw2a(\"%s\", \"%s\", %d...)\n", *lib, *name, *n);
#endif
  if (first_teos_call) {
#if defined(WIN32) || defined(WIN64) || defined(_WIN32) || defined(_WIN64)
    teos_handle = LoadLibrary(*lib);
#else
    teos_handle = dlopen(*lib, RTLD_LOCAL|RTLD_LAZY);
#endif
    if (!teos_handle) {
#if !defined(WIN32) && !defined(WIN64) && !defined(_WIN32) && !defined(_WIN64)
      Rprintf(dlerror());
#endif
      error("cannot open TEOS library %s", *lib);
    }
    first_teos_call = 0;
  }
#if defined(WIN32) || defined(WIN64) || defined(_WIN32) || defined(_WIN64)
  double (*f2)(double, double) = (void*)GetProcAddress(teos_handle, *name);
#else
  // OLD double (*f2)(double, double) = dlsym(teos_handle, *name);
  // REF http://linux.die.net/man/3/dlsym
  double (*f2)(double, double);
  *(void **)(&f2) = dlsym(teos_handle, *name);
#endif
  if (!f2) {
#if !defined(WIN32) && !defined(WIN64) && !defined(_WIN32) && !defined(_WIN64)
    Rprintf(dlerror());
#endif
    error("cannot find \"%s\" in TEOS library %s", *name, *lib);
  }
  for (int i = 0; i < *n; i++) {
    rval[i] = (*f2)(a1[i], a2[i]);
  }
}

void gsw3a(char **lib, char **name, int *n, double *a1, double *a2, double *a3, double *rval)
{
#ifdef DEBUG
  Rprintf("gsw3a(\"%s\", \"%s\", %d...)\n", *lib, *name, *n);
#endif
  if (first_teos_call) {
#if defined(WIN32) || defined(WIN64) || defined(_WIN32) || defined(_WIN64)
    teos_handle = LoadLibrary(*lib);
#else
    teos_handle = dlopen(*lib, RTLD_LOCAL|RTLD_LAZY);
#endif
    if (!teos_handle) {
#if !defined(WIN32) && !defined(WIN64) && !defined(_WIN32) && !defined(_WIN64)
      Rprintf(dlerror());
#endif
      error("cannot open TEOS library %s", *lib);
    }
    first_teos_call = 0;
  }
#if defined(WIN32) || defined(WIN64) || defined(_WIN32) || defined(_WIN64)
  double (*f3)(double, double, double) = (void*)GetProcAddress(teos_handle, *name);
#else
  // OLD double (*f3)(double, double, double) = dlsym(teos_handle, *name);
  // REF http://linux.die.net/man/3/dlsym
  double (*f3)(double, double, double);
  *(void **)(&f3) = dlsym(teos_handle, *name);
#endif
  if (!f3) {
#if !defined(WIN32) && !defined(WIN64) && !defined(_WIN32) && !defined(_WIN64)
    Rprintf(dlerror());
#endif
    error("cannot find \"%s\" in TEOS library %s", *name, *lib);
  }
  for (int i = 0; i < *n; i++) {
    rval[i] = (*f3)(a1[i], a2[i], a3[i]);
  }
}

void gsw4a(char **lib, char **name, int *n, double *a1, double *a2, double *a3, double *a4, double *rval)
{
#ifdef DEBUG
  Rprintf("gsw4a(lib=\"%s\", name=\"%s\", n=%d, a1=%f, a2=%f, a3=%f, a4=%f)\n", *lib, *name, *n, *a1, *a2, *a3, *a4);
#endif
  if (first_teos_call) {
#if defined(WIN32) || defined(WIN64) || defined(_WIN32) || defined(_WIN64)
    teos_handle = LoadLibrary(*lib);
#else
    teos_handle = dlopen(*lib, RTLD_LOCAL|RTLD_LAZY);
#endif
    if (!teos_handle) {
#if !defined(WIN32) && !defined(WIN64) && !defined(_WIN32) && !defined(_WIN64)
      Rprintf(dlerror());
#endif
      error("cannot open TEOS library \"%s\"", *lib);
    }
    first_teos_call = 0;
  }
#if defined(WIN32) || defined(WIN64) || defined(_WIN32) || defined(_WIN64)
  double (*f4)(double, double, double, double) = (void*)GetProcAddress(teos_handle, *name);
#else
  // OLD double (*f4)(double, double, double, double) = dlsym(teos_handle, *name);
  // REF http://linux.die.net/man/3/dlsym
  double (*f4)(double, double, double, double);
  *(void **)(&f4) = dlsym(teos_handle, *name);
#endif
  if (!f4) {
#if !defined(WIN32) && !defined(WIN64) && !defined(_WIN32) && !defined(_WIN64)
    Rprintf(dlerror());
#endif
    error("cannot find \"%s\" in TEOS library %s", *name, *lib);
  }
  for (int i = 0; i < *n; i++) {
    rval[i] = (*f4)(a1[i], a2[i], a3[i], a4[i]);
  }
}

