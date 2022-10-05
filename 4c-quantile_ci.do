****quantiles***8


set seed 1619


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

gen ta_hi=tb_hi+tw_hi+th_hi

global y_primary ya1864_uninsured yb1864_uninsured yw1864_uninsured yh1864_uninsured 

gen id=geoid
destring(id), force replace
egen code = group (id) 

gen pre=.
replace pre=0 if post==1
replace pre=1 if post==0


gen expansion=post*medicaid

estimates clear 


estimates clear

foreach y in a b w h{
	foreach r of numlist 1/4{

eststo: bootstrap, reps(1000): rqr y`y'1864_uninsured expansion if rl_cat==`r', quantile(.1(.1).9) absorb(geoid post)
estimates store `y'_r`r'

rqrplot

matrix m`y'`r'=r(plotmat)

graph save g`t'_r`r'.gph, replace



}


}


esttab  a_r1 b_r1 w_r1 h_r1 a_r2 b_r2 w_r2 h_r2 a_r3 b_r3 w_r3 h_r3 a_r4 b_r4 w_r4 h_r4 using q2_full_ci.csv, b(3) ci(3) keep(*expansion*) replace  
