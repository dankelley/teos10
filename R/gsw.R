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
    rval <- .C("wrap_gsw_ct_from_t",
               SA=as.double(l$SA), t=as.double(l$t), p=as.double(l$p),
               n=n, rval=double(n))$rval
    if (is.matrix(SA))
        dim(rval) <- dim(SA)
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
    rval <- .C("wrap_gsw_sa_from_sp",
               SA=as.double(l$SP), p=as.double(l$p), longitude=as.double(l$longitude), latitude=as.double(l$latitude),
               n=n, rval=double(n))$rval
    if (is.matrix(SP))
        dim(rval) <- dim(SA)
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
    rval <- .C("wrap_gsw_sp_from_c",
               C=as.double(l$C), t=as.double(l$t), p=as.double(l$p),
               n=n, rval=double(n))$rval
    if (is.matrix(C))
        dim(rval) <- dim(C)
    rval
}


