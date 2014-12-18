#' Convert from temperature to conservative temperature
#' 
#' @param SA Absolute salinity
#' @param t In-situ temperature in degrees C.
#' @param p Pressure in decibars. FIXME: check unit
#' @examples 
#' gsw_CT_from_t(34.7118, 28.7856, 10) # 28.809919826700281
#' @references
#' \url{http://www.teos-10.org/pubs/gsw/html/gsw_CT_from_t.html}
gsw_CT_from_t <- function(SA, t, p)
{
    .C("wrap_gsw_ct_from_t", SA=as.double(SA), t=as.double(t), p=as.double(p),
       n=length(SA), rval=double(length(SA)))$rval
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
    ## old ## FIXME: probably should do all but second two lines in some general
    ## old ## way, either with a function call or a closure.
    ## old if (missing(SP)) stop("must supply SP")
    ## old if (missing(p)) stop("must supply p")
    ## old if (missing(longitude)) stop("must supply longitude")
    ## old if (missing(latitude)) stop("must supply latitude")
    ## old SP <- as.matrix(SP)
    ## old p <- as.matrix(p)
    ## old SPdim <- dim(SP)
    ## old if (!all.equal(SPdim, dim(p))) stop("dim(SP) and dim(p) must match")
    ## old n <- prod(SPdim)
    ## old if (is.vector(longitude)) longitude <- matrix(longitude, nrow=SPdim[1], ncol=SPdim[2])
    ## old else if (SPdim != dim(longitude)) stop("dim(sp) and dim(longitude) must match")
    ## old if (is.vector(latitude)) latitude <- matrix(latitude, nrow=SPdim[1], ncol=SPdim[2])
    ## old else if (SPdim != dim(latitude)) stop("dim(sp) and dim(latitude) must match")
    ## old if (is.vector(latitude)) latitude <- matrix(latitude, nrow=SPdim[1], ncol=SPdim[2])
    ## old .C("wrap_gsw_sa_from_sp", SP=as.double(SP), p=as.double(p), 
    ## old    longitude=as.double(longitude), latitude=as.double(latitude),
    ## old    n=as.integer(n), rval=double(n))$rval
    .C("wrap_gsw_sa_from_sp", SA=as.double(SP), p=as.double(p),
       longitude=as.double(longitude), latitude=as.double(latitude),
       n=length(SP), rval=double(length(SP)))$rval
}

#' Convert from conductivity to practical salinity
#' 
#' @param C Conductivity ratio. FIXME: check unit
#' @param t In-situ temperature in degrees C.
#' @param p Pressure in decibars. FIXME: check unit
#' @return Practical salinity.
#' @examples 
#' gsw_SP_from_C(34.5487, 28.7856, 10) # 20.009869599086951
#' @references
#' \url{http://www.teos-10.org/pubs/gsw/html/gsw_SP_from_C.html}
gsw_SP_from_C <- function(C, t, p)
{
    .C("wrap_gsw_sp_from_c", C=as.double(C), t=as.double(t), p=as.double(p),
       n=length(C), rval=double(length(C)))$rval
}


