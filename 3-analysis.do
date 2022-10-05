****analysis****

clear all



use "C:\Users\jsemprini\OneDrive - University of Iowa\4-Misc Projects\c-Redline\analyticaldata\RL_5acs_ME_toanalyze.dta"

cd "C:\Users\jsemprini\OneDrive - University of Iowa\4-Misc Projects\c-Redline\results"


set more off
  quietly log
  local logon = r(status)
  if "`logon'" == "on" { 
	log close 
	}
log using RL_ols_log, replace text


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

global y_primary yb1864_uninsured yw1864_uninsured yh1864_uninsured 


**1: Uninsurance Rates by Red Line (mean, and distribution) - 2009-2013
estimates clear
foreach y in ya1864_uninsured $y_primary{
	
	eststo: reg `y' 1.rl_cat#i.medicaid if post==0, nocons
	eststo: reg `y'  (2.rl_cat 3.rl_cat 4.rl_cat)#i.medicaid if post==0, nocons

}
	


esttab using st1.csv, replace nostar b(4) se(3)

estimates clear

by medicaid, sort : tabstat ya1864_uninsured $y_primary  if post==0 & medicaid!=., statistics( p10 p25  p50 p75  p90) by(rl_cat)

***2: Alternative Measures - Mean (se)****
global placebo_outcomes yb0017_uninsured  yw0017_uninsured  yh0017_uninsured yb65_uninsured yw65_uninsured yh65_uninsured

global alt_insurance z_privatehi z_publichi z65_medicarehi z1864_medicaid z0018_medicaid zli_uninsured zledu_uninsured zfbnc_uninsured z_uninsured

global alt_controls x_fpl100 x_ue x_snap xb_snap xw_snap xh_snap x_bachdegree

gen ta1864_hi=tb1864_hi+tw1864_hi+th1864_hi

global alt_tot tb_hi tb0017_hi tb1864_hi tb65_hi tw_hi tw0017_hi tw1864_hi tw65_hi th_hi ts0017_hi th1864_hi th65_hi ta1864_hi

by medicaid, sort : tabstat $placebo_outcomes $alt_insurance $alt_controls $alt_tot  if post==0 & medicaid!=., statistics(mean sd) by(rl_cat)



estimates clear
foreach y in $placebo_outcomes $alt_insurance $alt_controls $alt_tot {
	
	eststo: reg `y' 1.rl_cat#i.medicaid if post==0, nocons
	eststo: reg `y'  (2.rl_cat 3.rl_cat 4.rl_cat)#i.medicaid if post==0, nocons

}
	


esttab using st3.csv, replace nostar b(4) se(3)

estimates clear
****plot mean uninsurance rates*****
gen pre=.
replace pre=0 if post==1
replace pre=1 if post==0

estimates clear 

****graph year by year***
foreach n of numlist 1/4{
	foreach b in a b w h{
		foreach m of numlist 0/1{
		
		reg y`b'1864_uninsured i.pre i.post if medicaid==`m' & rl_cat==`n' , nocons
		estimates store `b'_m`m'_n`n'
	}
}
}

ssc install schemepack, replace

coefplot a_m0_n1 a_m0_n2 a_m0_n3 a_m0_n4 , vertical xtitle("ACA")  subtitle("NHB, NHW, & Hispanic Adults (18-64)") recast(bar) barwidth(0.15) fcolor(*.5) ciopts(recast(rcap)) rename(1.pre = "2009-2013" 1.post = "2015-2019")  scheme(swift_red)
graph save all_non.gph, replace

coefplot a_m1_n1 a_m1_n2 a_m1_n3 a_m1_n4 , vertical xtitle("ACA")  subtitle("NHB, NHW, & Hispanic Adults (18-64)") recast(bar) barwidth(0.15) fcolor(*.5) ciopts(recast(rcap)) rename(1.pre = "2009-2013" 1.post = "2015-2019")  scheme(swift_red)
graph save all_yes.gph, replace

graph combine all_non.gph all_yes.gph, ycommon 


coefplot w_m0_n1 w_m0_n2 w_m0_n3 w_m0_n4 , vertical xtitle("ACA")  subtitle("non-Hispanic White, Did Not Expand") recast(bar) barwidth(0.15) fcolor(*.5) ciopts(recast(rcap)) rename(1.pre = "2009-2013" 1.post = "2015-2019")  scheme(swift_red)
graph save white_non.gph, replace 

coefplot w_m1_n1 w_m1_n2 w_m1_n3 w_m1_n4 , vertical  subtitle("non-Hispanic White, Did Expand Medicaid") recast(bar) barwidth(0.15) fcolor(*.5) ciopts(recast(rcap)) xtitle("ACA") rename(1.pre = "2009-2013" 1.post = "2015-2019") scheme(swift_red)
graph save white_yes.gph, replace

coefplot b_m0_n1 b_m0_n2 b_m0_n3 b_m0_n4 , vertical  subtitle("non-Hispanic Black, Did Not Expand") recast(bar) barwidth(0.15) fcolor(*.5) ciopts(recast(rcap)) xtitle("ACA") rename(1.pre = "2009-2013" 1.post = "2015-2019") scheme(swift_red )
graph save black_non.gph, replace

coefplot b_m1_n1 b_m1_n2 b_m1_n3 b_m1_n4 , vertical  subtitle("non-Hispanic Black, Did Expand Medicaid") recast(bar) barwidth(0.15) fcolor(*.5) ciopts(recast(rcap)) xtitle("ACA") rename(1.pre = "2009-2013" 1.post = "2015-2019") scheme(swift_red )
graph save black_yes.gph, replace

coefplot h_m0_n1 b_m0_n2 h_m0_n3 h_m0_n4 , vertical  subtitle("Hispanic, Did Not Expand") recast(bar) barwidth(0.15) fcolor(*.5) ciopts(recast(rcap)) xtitle("ACA") rename(1.pre = "2009-2013" 1.post = "2015-2019") scheme(swift_red )
graph save hispanic_non.gph, replace

coefplot h_m1_n1 h_m1_n2 h_m1_n3 h_m1_n4 , vertical  subtitle("Hispanic, Did Expand Medicaid") recast(bar) barwidth(0.15) fcolor(*.5) ciopts(recast(rcap)) xtitle("ACA") rename(1.pre = "2009-2013" 1.post = "2015-2019") scheme(swift_red )
graph save hispanic_yes.gph, replace

graph combine black_non.gph white_non.gph hispanic_non.gph black_yes.gph  white_yes.gph hispanic_yes.gph, ycommon title("Uninsurance Rates Before and After the ACA") subtitle("By Race and Medicaid Expansion Status") scheme(swift_red )

graph save f2_race.gph, replace



****OLS: Linear Regression to Test for Association between Medicaid Expansion and Mean Uninsurance Rates - Test for Differences Across and w/in Redline Categories*****


gen expansion=post*medicaid

global full_controls x_fpl100 x_ue x_bachdegree

estimates clear

gen code=geoid
destring(code), force replace 
egen id=group(code)
***primary results****

foreach y in a b w h{
	foreach n of numlist 1/4{
eststo: areg y`y'1864_uninsured 1.post 1.expansion  if rl_cat==`n', vce(cluster statefips) absorb(id)



}


}
esttab using t1ols.csv, b(3) se(3) replace keep(*expansion*) 
esttab using t1ols.csv, b(3) ci(3) replace keep(*expansion*) 

estimates clear


***sensitivity****

foreach y in b w h{
	foreach n of numlist 1/4{
eststo: areg y`y'1864_uninsured 1.post 1.expansion  if rl_cat==`n', vce(cluster statefips) absorb(id)

eststo: areg y`y'1864_uninsured 1.post 1.expansion if rl_cat==`n' [fw=t`y'1864_hi], vce(cluster statefips) absorb(id)

eststo: areg y`y'1864_uninsured 1.post 1.expansion x`y'_snap  if rl_cat==`n', vce(cluster statefips) absorb(id)

eststo: areg y`y'1864_uninsured 1.post 1.expansion x`y'_snap if rl_cat==`n' [fw=t`y'1864_hi], vce(cluster statefips) absorb(id)

eststo: areg y`y'1864_uninsured 1.post 1.expansion $full_controls if rl_cat==`n' , vce(cluster statefips) absorb(id)

eststo: areg y`y'1864_uninsured 1.post 1.expansion $full_controls if rl_cat==`n' [fw=t`y'1864_hi], vce(cluster statefips) absorb(id)

eststo: areg y`y'1864_uninsured 1.post 1.expansion $full_controls x`y'_snap  if rl_cat==`n' , vce(cluster statefips) absorb(id)

eststo: areg y`y'1864_uninsured 1.post 1.expansion $full_controls x`y'_snap if rl_cat==`n' [fw=t`y'1864_hi], vce(cluster statefips) absorb(id)

eststo: areg y`y'1864_uninsured 1.post 1.expansion  if rl_cat==`n', vce(cluster id) absorb(id)

eststo: areg y`y'1864_uninsured 1.post 1.expansion  if rl_cat==`n', vce(robust) absorb(id)



}


}

esttab using t2ols.csv, b(3) se(3) replace keep(*expansion*)

estimates clear

***alt outcomes****

foreach y in  $alt_insurance{
	foreach n of numlist 1/4{
eststo: areg `y' 1.post 1.expansion  if rl_cat==`n', vce(cluster statefips) absorb(id)


}


}



****placebo****


esttab using t3ols.csv, b(3) se(3) replace keep(*expansion*)

estimates clear

foreach y in $placebo_outcomes{
	foreach n of numlist 1/4{
eststo: areg `y' 1.post 1.expansion  if rl_cat==`n', vce(cluster statefips) absorb(id)


}


}

esttab using t4ols.csv, b(3) se(3) replace keep(*expansion*)

estimates clear