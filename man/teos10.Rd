\name{teos10}

\alias{teos10}

\title{Interface to TEOS-10 library}

\description{Interface to TEOS-10 library}

\usage{teos10(name, a1, a2, a3, a4,
    lib=paste(.libPaths(), "/teos10/libs/libgswteos10.so", sep=""))}

\arguments{

  \item{name}{the name of a TEOS-10 function.  Note that the function names in
      the TEOS-10 documentation are in mixed case, but those in the actual
      TEOS-10 library are \emph{lower case}.  Thus, for example, the function
      to compute absolute salinity must be referred to as
      \code{"gsw_sa_from_sp"} and not \code{"gsw_SA_from_SP"} as the TEOS-10
      documentation specifies.}

  \item{a1}{the first argument to the named TEOS-10 function.  This may be a
      vector or matrix, and its shape will be used for the return value.}
  \item{a2}{the second argument to the named TEOS-10 function.}
  \item{a3}{the third argument to the named TEOS-10 function.}
  \item{a4}{the fourth argument to the named TEOS-10 function.}
  \item{lib}{the file name of the shared library that provides TEOS-10.}
}

\details{This is a simple interface to the TEOS-10 library, which demands some
    understanding of that library.  For example, if the function should be
    called with two arguments and only one is specified, unexpected results may
    occur.  Users should consult the TEOS-10 documentation (which covers many
    hundreds of pages) for details, and a growing list of peer-reviewed
    publications that discuss the scientific basis and historical context;
    see \dQuote{References}.}

\value{This is the TEOS-10 function returns, with dimensions matching those of
    \code{a1}.  TEOS-10 functions use the value 9e15 to indicate invalid
    conditions (e.g. latitude exceeding 90 degrees), and these are converted by
    \code{teos()} to \code{NA}.}

\examples{
library(teos10)

# Absolute salinity is SA=35.671 g/kg, for practical salinity 35.5 PSU, pressure
# 300 dbar, long 300 degE, and lat 16 degN.
teos10("gsw_sa_from_sp", 35.5, 300, 260, 16)

# Conservative temperature is CT=14.930, for an absolute salinity 
# of 35.7 g/kg, in-situ temp 15 degC, and pressure 300 dbar.
teos10("gsw_ct_from_t", 35.7, 15, 300)

# Density is 1026.456 kg/m^3 for sa=35.7 g/kg, ct = 20 degC and p=300
teos10("gsw_rho", 35.7, 20, 300)
}

\references{
    [1] McDougall, T.J. and P.M. Barker, 2011: Getting started with TEOS-10 and
    the Gibbs Seawater (GSW) Oceanographic Toolbox, 28pp., SCOR/IAPSO WG127,
    ISBN 978-0-646-55621-5.

    [2] The TEOS-10 library is provided at \url{www.teos-10.org}.
    
    [3] A programming interface to the matlab version of the TEOS library is
    provided at \url{http://www.teos-10.org/pubs/gsw/html/gsw_contents.html}.

    [4] R. Pawlowicz, T. McDougall, R. Feistel and R. Tailleux, 2012.  An
    historical perspective on the development of the Thermodynamic Equation of
    Seawater - 2010. Ocean Science, 8, 161-174.

}

\author{Dan Kelley}

\keyword{misc}
