library(teos10)
# Test against with values provided on the TEOS-10 website.
 
CT <- gsw_CT_from_t(34.7118, 28.7856, 10)
stopifnot(all.equal(CT, 28.809919826700281))

SA <- gsw_SA_from_SP(34.5487, 10, 188, 4)
stopifnot(all.equal(SA, 34.711778344814114))

SP <- gsw_SP_from_C(34.5487, 28.7856, 10)
stopifnot(all.equal(SP, 20.009869599086951))

