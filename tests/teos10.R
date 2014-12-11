library(teos10)

# URLs indicate the sources for test values (matlab tests).
 
# http://www.teos-10.org/pubs/gsw/html/gsw_SA_from_SP.html
SP <- c(34.5487,34.7275,34.8605,34.6810,34.5680,34.56)
p <- c(10,50,125,250,600,1000)
longitude <- rep(188,6)
latitude <- rep(4,6)
SA <- teos10("gsw_sa_from_sp", SP, p, longitude, latitude)
SAexpected <- c(34.711778344814114, 34.891522618230098, 35.025544862476920,
                34.847229026189588, 34.736628474576051, 34.732363065590846)
stopifnot(all.equal(SAexpected, SA))
SA <- gsw_SA_from_SP(SP, p, longitude, latitude)
stopifnot(all.equal(SAexpected, SA))
SA <- gsw_SA_from_SP(SP, p, longitude[1], latitude[1])
stopifnot(all.equal(SAexpected, SA))

