#' Convert from practical salinity to absolute salinity
#' 
#' @param SP Practical salinity
#' @param p Pressure in decibars. FIXME: check press unit
#' @param longitude Longitude in degrees east. FIXME: check on whether cut point matters
#' @param latitude Latitude in degrees north. FIXME: check on whether cut point matters.
#' @return Absolute salinity.

gsw_SA_from_SP <- function(SP, p, longitude, latitude)
{
    ## FIXME: probably should do all but second two lines in some general
    ## way, either with a function call or a closure.
    if (missing(SP)) stop("must supply SP")
    if (missing(p)) stop("must supply p")
    if (missing(longitude)) stop("must supply longitude")
    if (missing(latitude)) stop("must supply latitude")
    SP <- as.matrix(SP)
    p <- as.matrix(p)
    SPdim <- dim(SP)
    if (!all.equal(SPdim, dim(p))) stop("dim(SP) and dim(p) must match")
    n <- prod(SPdim)
    if (is.vector(longitude)) longitude <- matrix(longitude, nrow=SPdim[1], ncol=SPdim[2])
    else if (SPdim != dim(longitude)) stop("dim(sp) and dim(longitude) must match")
    if (is.vector(latitude)) latitude <- matrix(latitude, nrow=SPdim[1], ncol=SPdim[2])
    else if (SPdim != dim(latitude)) stop("dim(sp) and dim(latitude) must match")
    if (is.vector(latitude)) latitude <- matrix(latitude, nrow=SPdim[1], ncol=SPdim[2])
    .C("gsw_sa_from_sp", as.double(SP), as.double(p), as.double(longitude), as.double(latitude),
               as.integer(n), rval=double(n)) $rval
}

#' Convert from conductivity to practical salinity
#' 
#' @param C Conductivity ratio. FIXME: check unit
#' @param t In-situ temperature in degrees C.
#' @param p Pressure in decibars. FIXME: check unit
#' @return Practical salinity.
#' @examples 
#' 
#' C <- c(34.5487, 34.7275, 34.8605, 34.6810, 34.5680, 34.5600)
#' t <- c(28.7856, 28.4329, 22.8103, 10.2600,  6.8863,  4.4036)
#' p <- c(     10,      50,     125,     250,     600,    1000)
#' SP <- gsw_SP_from_C(C, t, p)
#' stopifnot(all.equal(SP,c(20.009869599086951,20.265511864874270,22.981513062527689,31.204503263727982,34.032315787432829,36.400308494388170)))

gsw_SP_from_C <- function(C, t, p)
{
    .C("wrap_gsw_sp_from_c", as.double(C), as.double(t), as.double(p), length(C), rval=double(length(C)))$rval
}

