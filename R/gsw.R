# AUTHOR NOTES: HOW TO ADD A NEW FUNCTION.
#
# 1. One must to write wrappers (in ../src/wrappers.c) for any GSW function that
#    returns a value. This is because .C() can only handle functions that return void. 
#    The name of the wrapper function should be case matching the R function, which
#    in turn should match that of the TEOS-10 Matlab names as listed at
#        http://www.teos-10.org/pubs/gsw/html/gsw_contents.html
# 2. Once a wrapper exists, create an R function by mimicking e.g. gsw_CT_from_t(). Be sure
#    to document the function as is done here. And be sure to use the capitalization 
#    used on the TEOS-10 website for matlab code, because that is what users will
#    probably expect. Place the function in its correct alphabetical position.
# 3. Add an entry for the function in ../NAMESPACE.
# 4. Enter the .. directory and type
#        Rscript -e "roxygen2::roxygenise()
#    to create new manpages.
# 5. Add a test to ../tests/teso10.R, using a test value from the TEOS-10 website.
# 6. Build the package to see that code matches docs, etc.


## PART 1: utility functions

#' Reshape list elements to match the shape of the first element.
#'
#' @param l A list of elements, typically arguments that will be used in GSW functions.
#' @return A list with all elements of same shape (length or dimension).
argfix <- function(l)
{
    n <- length(l)
    if (n > 0) {
        length1 <- length(l[[1]])
        for (i in 2:n) {
            if (length(l[[i]]) != length1) {
                l[[i]] <- rep(l[[i]], length.out=length1)
            }
        }
        if (is.matrix(l[[1]])) {
            for (i in 2:n) {
                dim(l[[i]]) <- dim(l[[1]])
            }
        }
    }
    l
}


## PART 2: gsw (Gibbs SeaWater) functions, in alphabetical order (ignoring case)

#' Convert from temperature to conservative temperature
#' 
#' @param SA Absolute salinity
#' @param t In-situ temperature (ITS-90) in degrees C.
#' @param p Sea pressure in decibars.
#' @examples 
#' gsw_CT_from_t(34.7118, 28.7856, 10) # 28.809919826700281
#' @references
#' \url{http://www.teos-10.org/pubs/gsw/html/gsw_CT_from_t.html}
gsw_CT_from_t <- function(SA, t, p)
{
    l <- argfix(list(SA=SA, t=t, p=p))
    n <- length(l[[1]])
    rval <- .C("wrap_gsw_CT_from_t",
               SA=as.double(l$SA), t=as.double(l$t), p=as.double(l$p),
               n=n, rval=double(n))$rval
    if (is.matrix(SA))
        dim(rval) <- dim(SA)
    rval
}

#' Calculate square of buoyancy frequency
#'
#' BUG: the values seem to be off by about 1 part in 1e6, which
#' is too high to be explained by numerical precision (I think).
#' 
#' @param SA Absolute salinity.
#' @param CT Conservative temperature.
#' @param p Sea pressure in decibars.
#' @param latitude The latitude in deg North.
#' @return Square of buoyancy frequency in 1/s^2, a vector of length 1 less than SA.
#' @examples 
#' SA <- c(34.7118, 34.8915)
#' CT <- c(28.8099, 28.4392)
#' p <- c(      10,      50)
#' latitude <- 4
#' gsw_Nsquared(SA, CT, p, latitude) # 6.0846990523477e-5
#' @references
#' \url{http://www.teos-10.org/pubs/gsw/html/gsw_Nsquared.html}
gsw_Nsquared <- function(SA, CT, p, latitude=0)
{
    l <- argfix(list(SA=SA, CT=CT, p=p, latitude=latitude))
    n <- length(l[[1]])
    rval <- .C("wrap_gsw_Nsquared",
               SA=as.double(l$SA), CT=as.double(l$CT), p=as.double(l$p), latitude=as.double(l$latitude),
               n=n, n2=double(n), p_mid=double(n))$n2
    ## How to handle the reduction in length for a matrix??
    if (is.matrix(SA))
        dim(rval) <- dim(SA)
    else
        rval <- head(rval, -1)
    rval
}

#' Convert from practical salinity to absolute salinity
#' 
#' @param SP Practical salinity
#' @param p Pressure in decibars. FIXME: check press unit
#' @param longitude Longitude in degrees east. FIXME: check on whether cut point matters
#' @param latitude Latitude in degrees north. FIXME: check on whether cut point matters.
#' @return Absolute salinity.
#' @examples
#' gsw_SA_from_SP(34.5487, 10, 188, 4) # 34.711778344814114 
#' @references
#' \url{http://www.teos-10.org/pubs/gsw/html/gsw_SA_from_SP.html}
gsw_SA_from_SP <- function(SP, p, longitude, latitude)
{
    l <- argfix(list(SP=SP, p=p, longitude=longitude, latitude=latitude))
    n <- length(l[[1]])
    rval <- .C("wrap_gsw_SA_from_SP",
               SA=as.double(l$SP), p=as.double(l$p), longitude=as.double(l$longitude), latitude=as.double(l$latitude),
               n=n, rval=double(n))$rval
    if (is.matrix(SP))
        dim(rval) <- dim(SP)
    rval
}

#' Convert from conductivity to practical salinity
#' 
#' @param C Conductivity in mS/cm.
#' @param t In-situ temperature (ITS-90) in degrees C.
#' @param p Sea pressure in decibars.
#' @return Practical salinity.
#' @examples 
#' gsw_SP_from_C(34.5487, 28.7856, 10) # 20.009869599086951
#' @references
#' \url{http://www.teos-10.org/pubs/gsw/html/gsw_SP_from_C.html}
gsw_SP_from_C <- function(C, t, p)
{
    l <- argfix(list(C=C, t=t, p=p))
    n <- length(l[[1]])
    rval <- .C("wrap_gsw_SP_from_C",
               C=as.double(l$C), t=as.double(l$t), p=as.double(l$p),
               n=n, rval=double(n))$rval
    if (is.matrix(C))
        dim(rval) <- dim(C)
    rval
}


