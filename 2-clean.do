****clear data****


clear all

use "C:\Users\jsemprini\OneDrive - University of Iowa\4-Misc Projects\c-Redline\statadata\nhgis\nhgis_2009-2019_rl_toclean.dta"



rename statea statefips
destring(statefips), force replace

****create medicaid expansion (2014) status -- exclude AK, IN, LA, MT, PA ---- KFF Source****
gen medicaid=.
replace medicaid=	0	if statefip==	1
replace medicaid=	1	if statefip==	4
replace medicaid=	1	if statefip==	5
replace medicaid=	1	if statefip==	6
replace medicaid=	1	if statefip==	8
replace medicaid=	1	if statefip==	9
replace medicaid=	0	if statefip==	10
replace medicaid=	0	if statefip==	11
replace medicaid=	0	if statefip==	12
replace medicaid=	0	if statefip==	13
replace medicaid=	1	if statefip==	15
replace medicaid=	0	if statefip==	16
replace medicaid=	1	if statefip==	17
replace medicaid=	1	if statefip==	19
replace medicaid=	0	if statefip==	20
replace medicaid=	1	if statefip==	21
replace medicaid=	0	if statefip==	23
replace medicaid=	1	if statefip==	24
replace medicaid=	0	if statefip==	25
replace medicaid=	1	if statefip==	26
replace medicaid=	1	if statefip==	27
replace medicaid=	0	if statefip==	28
replace medicaid=	0	if statefip==	29
replace medicaid=	0	if statefip==	31
replace medicaid=	1	if statefip==	32
replace medicaid=	1	if statefip==	34
replace medicaid=	1	if statefip==	33
replace medicaid=	1	if statefip==	35
replace medicaid=	0	if statefip==	36
replace medicaid=	0	if statefip==	37
replace medicaid=	1	if statefip==	38
replace medicaid=	1	if statefip==	39
replace medicaid=	0	if statefip==	40
replace medicaid=	1	if statefip==	41
replace medicaid=	1	if statefip==	44
replace medicaid=	0	if statefip==	45
replace medicaid=	0	if statefip==	46
replace medicaid=	0	if statefip==	47
replace medicaid=	0	if statefip==	48
replace medicaid=	0	if statefip==	49
replace medicaid=	0	if statefip==	50
replace medicaid=	0	if statefip==	51
replace medicaid=	1	if statefip==	53
replace medicaid=	1	if statefip==	54
replace medicaid=	0	if statefip==	55
replace medicaid=	0	if statefip==	56

****drop PR****

drop if state=="Puerto Rico"

***create time variable***

gen post=0
replace post=1 if year=="2015-2019"

tab year post, missing

tab state if year==""

drop if year==""

drop if geoid==""



order geoid year state HRS2010 INTERVAL2010 in_rl medicaid post

*****create/code variables****

gen x_fpl100=.
replace x_fpl100=(uxke002+uxke003+uxke004)/uxke001

gen x_ue=.
replace x_ue=(ux2e006/ux2e001)

gen x_snap=.
replace x_snap=u0de002/u0de001

gen xb_snap=.
replace xb_snap=u0fe002/u0fe001

gen xw_snap=.
replace xw_snap=u0le002/u0le001

gen xh_snap=.
replace xh_snap=u0me002/u0me001

gen x_bachdegree=.
replace x_bachdegree=u00e023/u00e001


****alt health inusrance variables***

gen z_privatehi=.
replace z_privatehi=(u3te004+u3te007+u3te010+u3te013+u3te016+u3te019+u3te022+u3te025+u3te028+u3te032+u3te035+u3te038+u3te041+u3te044+u3te047+u3te050+u3te053+u3te056)/u3te001

gen z_publichi=.
replace z_publichi=(u3ue004+u3ue007+u3ue010+u3ue013+u3ue016+u3ue019+u3ue022+u3ue025+u3ue028+u3ue032+u3ue035+u3ue038+u3ue041+u3ue044+u3ue047+u3ue050+u3ue053+u3ue056)/u3ue001

gen z65_medicarehi=.
replace z65_medicarehi=(u3xe010+u3xe020)/(u3xe009+u3xe019)

gen z1864_medicaid=.
replace z1864_medicaid=(u3ye007+u3ye017)/(u3ye006+u3ye016)

gen z0018_medicaid=.
replace z0018_medicaid=(u3ye004+u3ye014)/(u3ye003+u3ye013)

gen zli_uninsured=.
replace zli_uninsured=(u33e006)/u33e002

gen zledu_uninsured=.
replace zledu_uninsured=(u35e007+u35e011)/(u35e003+u35e008)

gen zfbnc_uninsured=.
replace zfbnc_uninsured=u36e017/u36e013

gen z_uninsured=.
replace z_uninsured=(u36e006+u36e011+u36e017)/u36e001

****y-outcomes, total and by race and age****

foreach x in l r s{

gen t`x'_hi=u3`x'e001

gen t`x'0017_hi=u3`x'e002
gen t`x'1864_hi=u3`x'e005
gen t`x'65_hi=u3`x'e008

gen y`x'0017_uninsured=u3`x'e004/u3`x'e002
gen y`x'1864_uninsured=u3`x'e007/u3`x'e005
gen y`x'65_uninsured=u3`x'e010/u3`x'e008

}

gen ya1864_uninsured=(u3le007+u3re007+u3se007)/(u3le005+u3re005+u3se005)

sum tl0017_hi tl1864_hi tl65_hi yl0017_uninsured yl1864_uninsured yl65_uninsured tr_hi tr0017_hi tr1864_hi tr65_hi yr0017_uninsured yr1864_uninsured yr65_uninsured ts_hi ts0017_hi ts1864_hi ts65_hi ys0017_uninsured ys1864_uninsured ys65_uninsured ya1864_uninsured


order geoid year state HRS2010 INTERVAL2010 in_rl medicaid post y* t* x*


drop HRS2010 INTERVAL2010


merge m:1 geoid using "C:\Users\jsemprini\OneDrive - University of Iowa\4-Misc Projects\c-Redline\statadata\nhgis\rl_censustract.dta"
tab HRS2010
tab INTERVAL2010

rename HRS2010 rl_cont
rename INTERVAL2010 rl_cat

order rl* geoid year state in_rl medicaid post y* t* x*

save "C:\Users\jsemprini\OneDrive - University of Iowa\4-Misc Projects\c-Redline\analyticaldata\RL_5acs_ME_toanalyze.dta", replace
