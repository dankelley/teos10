gsw_SA_from_SP <- function(SP, p, longitude, latitude)
{
    ## FIXME: probably should do all but second two lines in some general
    ## way, either with a function call or a closure.
    if (missing(SP)) stop("must supply SP")
    wantVector <- is.vector(SP)
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
    rval <- teos10("gsw_sa_from_sp", SP, p, longitude, latitude)
    if (wantVector) as.vector(rval) else rval
}
