AC_INIT(teos, 1.0, Simon.Urbanek@r-project.org)
AC_CONFIG_SRCDIR(src/teos.c)

# find R home and set correct compiler + flags
: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
  AC_MSG_ERROR([cannot determine R_HOME. Make sure you use R CMD INSTALL!])
fi
RBIN="${R_HOME}/bin/R"

# pick all flags for testing from R
: ${CC=`"${RBIN}" CMD config CC`}
: ${CPP=`"${RBIN}" CMD config CPP`}
: ${CFLAGS=`"${RBIN}" CMD config CFLAGS`}
: ${CPPFLAGS=`"${RBIN}" CMD config CPPFLAGS`}
: ${LDFLAGS=`"${RBIN}" CMD config LDFLAGS`}

# honor PKG_xx overrides
LIBS="${LIBS} ${PKG_LIBS}"
# for CPPFLAGS we will superfluously double R's flags
# since we'll set PKG_CPPFLAGS with this, but that shouldn't hurt
CPPFLAGS="${CPPFLAGS} ${PKG_CPPFLAGS}"

teosok=yes
AC_CHECK_HEADERS(teos_api.h,,teosok=no)
AC_CHECK_LIB(teos,gsw2a,,teosok=no)
if test "${teosok}" = no; then
   AC_MSG_ERROR([libteos and/or teos_api.h not found in standard search locations.

*** Install teos and if necessary set PKG_CPPFLAGS/PKG_LIBS accordingly.])
fi

AC_ARG_VAR([PKG_CPPFLAGS],[custom C preprocessor flags for packages compilation])
AC_ARG_VAR([PKG_LIBS],[custom libraries for package compilation])

AC_CONFIG_FILES(src/Makevars)
AC_OUTPUT


