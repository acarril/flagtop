program define marktop, sortpreserve
	version 11

syntax varlist[, top(integer 1)]

tempvar freq

bysort `varlist': gen `freq' = _N
bysort `freq' `varlist': gen tag = (_n == 1)
replace tag = sum(tag)
sum tag , meanonly
gen top10ties = (tag>=(`r(max)'-9))
sum `freq' if tag==(`r(max)'-9), meanonly
replace top10ties = 1 if `freq'==`r(max)'

end
