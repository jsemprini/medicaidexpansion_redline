****quantiles***8


set seed 1619


clear all

use "RL_5acs_ME_toanalyze.dta"



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

foreach y in a b w h{
foreach r of numlist 1/4{


eststo: bootstrap, reps(1000): rqr y`y'1864_uninsured expansion if rl_cat==`r', quantile(.5) absorb(geoid post)



eststo: bootstrap, reps(1000): rqr y`y'1864_uninsured expansion if rl_cat==`r' , quantile(.5) absorb(geoid post) controls(x_fpl100 x_ue x_bachdegree)

eststo: bootstrap, cluster(statefips) reps(1000): rqr y`y'1864_uninsured expansion if rl_cat==`r', quantile(.5) absorb(geoid post)


eststo: bootstrap, cluster(geoid) reps(1000): rqr y`y'1864_uninsured expansion if rl_cat==`r', quantile(.5) absorb(geoid post)

}


}
esttab using q3_sens.csv, b(3) se(3) replace keep(*expansion*) 

estimates clear



global placebo_outcomes yb0017_uninsured yb65_uninsured yw0017_uninsured yw65_uninsured yh0017_uninsured yh65_uninsured

global alt_insurance z_privatehi z_publichi z65_medicarehi z1864_medicaid z0018_medicaid zli_uninsured zledu_uninsured zfbnc_uninsured z_uninsured

estimates clear 

foreach y in $alt_insurance{
foreach r of numlist 1/4{


eststo: bootstrap, reps(1000): rqr `y' expansion if rl_cat==`r', quantile(.5) absorb(geoid post)


}


}
esttab using q4_altout.csv, b(3) se(3) replace keep(*expansion*) 

estimates clear

