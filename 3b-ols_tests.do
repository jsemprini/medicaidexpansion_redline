****analysis****
*****needs tweak****
clear all

use "C:\Users\jsemprini\OneDrive - University of Iowa\4-Misc Projects\c-Redline\analyticaldata\RL_5acs_ME_toanalyze.dta"

cd "C:\Users\jsemprini\OneDrive - University of Iowa\4-Misc Projects\c-Redline\results"

***change names for racial groups****
order rl_cont rl_cat geoid year state in_rl medicaid post tracta y* t* z* x*


***l: nhb
rename  (yl0017_uninsured yl1864_uninsured yl65_uninsured tl_hi tl0017_hi tl1864_hi tl65_hi) (yb0017_uninsured yb1864_uninsured yb65_uninsured tb_hi tb0017_hi tb1864_hi tb65_hi)
***r: nhw
rename (yr0017_uninsured yr1864_uninsured yr65_uninsured  tr_hi tr0017_hi tr1864_hi tr65_hi) (yw0017_uninsured yw1864_uninsured yw65_uninsured  tw_hi tw0017_hi tw1864_hi tw65_hi)
***s: hisp
rename (ys0017_uninsured ys1864_uninsured ys65_uninsured ts_hi ts0017_hi ts1864_hi ts65_hi) (yh0017_uninsured yh1864_uninsured yh65_uninsured th_hi ts0017_hi th1864_hi th65_hi ) 


****summary stats****

***b + w + h = total1864 uninusrance****

global y_primary ya1864_uninsured yb1864_uninsured yw1864_uninsured yh1864_uninsured 




by medicaid, sort : tabstat $y_primary  if post==0 & medicaid!=., statistics( p10 p25  p50 p75  p90) by(rl_cat)

***2: Alternative Measures - Mean (se)****
global placebo_outcomes yb0017_uninsured yb65_uninsured yw0017_uninsured yw65_uninsured yh0017_uninsured yh65_uninsured

global alt_insurance z_privatehi z_publichi z65_medicarehi z1864_medicaid z0018_medicaid zli_uninsured zledu_uninsured zfbnc_uninsured z_uninsured

global alt_controls x_fpl100 x_ue x_snap xb_snap xw_snap xh_snap x_bachdegree

gen ta_hi=tb_hi+tw_hi+th_hi

global alt_tot tb_hi tb0017_hi tb1864_hi tb65_hi tw_hi tw0017_hi tw1864_hi tw65_hi th_hi ts0017_hi th1864_hi th65_hi ta_hi


estimates clear
****plot mean uninsurance rates*****
gen pre=.
replace pre=0 if post==1
replace pre=1 if post==0



****OLS: Linear Regression to Test for Association between Medicaid Expansion and Mean Uninsurance Rates - Test for Differences Across and w/in Redline Categories*****


gen expansion=post*medicaid

global full_controls x_fpl100 x_ue x_bachdegree

estimates clear

keep yb1864_uninsured yw1864_uninsured yh1864_uninsured geoid post medicaid rl_cat statefips

gen id=geoid
destring(id), force replace
drop geoid

egen code=group(id)

rename (yb1864_uninsured yw1864_uninsured yh1864_uninsured) (y1 y2 y3)

reshape long y, i(code post medicaid rl_cat statefips) j(group)



gen expansion=medicaid*post

tab group, gen(race)

egen newid=group(id group)
xtset newid post 

estimates clear
foreach r of numlist 1/4{
eststo: xtreg y i.expansion##i.post##i.group if rl_cat==`r', fe vce(cluster statefips)

test 1.expansion#1.group = 1.expansion#2.group
estadd scalar pbw=r(p)

test 1.expansion#1.group = 1.expansion#3.group
estadd scalar pbh = r(p)

test 1.expansion#2.group = 1.expansion#3.group
estadd scalar pwh = r(p)

test 1.expansion#1.group = 1.expansion#2.group = 1.expansion#3.group 
estadd scalar pj = r(p)

test 1.expansion#1.group = 1.expansion#2.group = 1.expansion#3.group , mtest(b)
estadd scalar pjm = r(p)



}



esttab using racetest.csv, b(3) se(3) replace keep(*expansion*) sca(pbw pbh pwh pj pjm)

estimates clear
