library(teos10)
# Test against with values provided on the TEOS-10 website.
 
CT <- gsw_CT_from_t(34.7118, 28.7856, 10)
stopifnot(all.equal(CT, 28.809919826700281))

SA <- c(34.7118, 34.8915, 35.0256, 34.8472, 34.7366, 34.7324)
CT <- c(28.8099, 28.4392, 22.7862, 10.2262,  6.8272,  4.3236)
p <- c(      10,      50,     125,     250,     600,    1000)
latitude <- 4
N2 <- gsw_Nsquared(SA, CT, p, latitude)
## Not sure why we don't get more than 6 digits right.
stopifnot(all.equal(N2, 1e-3*c(0.060846990523477, 0.235607737824943, 0.215533939997650, 0.012924024206854, 0.008425873682231),tolerance=1e-6,scale=1))

SA <- gsw_SA_from_SP(34.5487, 10, 188, 4)
stopifnot(all.equal(SA, 34.711778344814114))

SP <- gsw_SP_from_C(34.5487, 28.7856, 10)
stopifnot(all.equal(SP, 20.009869599086951))

