program define marktop, sortpreserve
	version 11

syntax varlist[, top(integer 1)]

*preserve

tempvar freq

****

egen `freq' = count(1), by(`varlist')
gen freq = `freq'
****

*generate byte `freq'=1
*sort `varlist'
*collapse (count) `freq', by(`varlist')

gsort -`freq' `varlist'

tempvar rank

gen byte top = (_

	gen byte top = (_n<=`top')
*	generate rank=_n
*	keep if rank<=`top'

sort `varlist'
*tempfile top
*quietly save `"`top'"'

*restore
*sort `varlist'
*quietly merge `varlist' using `"`top'"'
*quietly drop _merge

*generate top=!missing(rank)

end
