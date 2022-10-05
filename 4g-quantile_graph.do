****quantiles***8


set seed 1619



set more off
  quietly log
  local logon = r(status)
  if "`logon'" == "on" { 
	log close 
	}
log using RL_quantile_log, replace text

set rmsg on

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

****test distributional effects****


estimates clear

foreach y in b w h{
	foreach r of numlist 1/4{

eststo: bootstrap, reps(1000): rqr y`y'1864_uninsured expansion if rl_cat==`r', quantile(.1(.1).9) absorb(geoid post)
estimates store `y'_r`r'

rqrplot

matrix m`y'`r'=r(plotmat)

graph save g`t'_r`r'.gph, replace



}


}



 foreach y in  b w h{

frame create b
frame b{
	
	svmat m`y'1
	svmat m`y'2 
	svmat m`y'3 
	svmat m`y'4



tw (rarea m`y'34 m`y'35 m`y'11, color(%40)) ///
(rarea m`y'44 m`y'45 m`y'11, color(%50)) ///
(line m`y'12 m`y'11, lcolor(black) lpattern(dot)) ///
(line m`y'22 m`y'11,  lcolor(black) lpattern(dash_dot)) ///
(line m`y'32 m`y'11,  lcolor(black) lpattern(longdash)) ///
(line m`y'42 m`y'11,  lcolor(black) lpattern(solid)) ///
	(rarea m`y'14 m`y'15 m`y'11, color(%20)) ///
(rarea m`y'24 m`y'25 m`y'11, color(%30)) ///
, legend(order(7 "1" 8 "2" 1 "3" 2 "4"))  xtitle(Uninsurance Quantile) legend(title("Census Redline Score")) legend(cols(4)) scheme(swift_red) subtitle("`y' Adults (18-64)") xlabel(.1(.1).9) 

graph save q`y'.gph, replace
}
frame drop b

graph save q`y'.gph, replace


 }

graph combine qa.gph qb.gph qw.gph qh.gph , ycommon title("Effect of Medicaid Expansion on Uninsurance Rates") scheme(swift_red)



graph save q4.gph, replace 




set rmsg off

clear all

exit

 
