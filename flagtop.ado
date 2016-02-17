*! 1.0 Alvaro Carril 16feb2016
program define flagtop, sortpreserve
version 13

syntax varlist [if] [in] [, top(integer 1)]
marksample touse

quietly count if `touse'
if `r(N)' == 0 {
	error 2000
}

tempvar freq tag

quietly {
	bysort `touse' `varlist': gen `freq' = _N
	bysort `touse' `freq' `varlist': gen `tag' = (_n == 1)
	replace `tag' = sum(`tag')
	sum `tag', meanonly
	gen flagtop = (`tag'>=(`r(max)'-`top'+1)) if `touse'
	sum `freq' if `tag'==(`r(max)'-`top'+1), meanonly
	replace flagtop = 1 if `freq'==`r(max)' & `touse'
}
end
