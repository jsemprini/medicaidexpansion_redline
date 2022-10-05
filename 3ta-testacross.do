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



gen ta1864_hi=tb1864_hi+tw1864_hi+th1864_hi

global alt_tot tb_hi tb0017_hi tb1864_hi tb65_hi tw_hi tw0017_hi tw1864_hi tw65_hi th_hi ts0017_hi th1864_hi th65_hi ta1864_hi





gen expansion=post*medicaid

global full_controls x_fpl100 x_ue x_bachdegree

estimates clear

gen code=geoid
destring(code), force replace 
egen id=group(code)
***primary results****
estimates clear
foreach y in a {
	foreach n of numlist 1/4 {
eststo: areg y`y'1864_uninsured 1.post 1.expansion  if rl_cat==`n', vce(cluster statefips) absorb(id)

eststo: areg y`y'1864_uninsured  (1.expansion 1.post)#i.rl_cat , vce(cluster statefips) absorb(id)



}


}
esttab using test-across.csv, b(3) se(3) replace keep(*expansion*) 

estimates clear


***test across RL***
estimates clear
foreach y in a b h w {

eststo: areg y`y'1864_uninsured  (1.expansion 1.post)#i.rl_cat , vce(cluster statefips) absorb(id)

test 1.expansion#1.rl_cat = 1.expansion#2.rl_cat
estadd scalar p12=r(p)

test 1.expansion#1.rl_cat = 1.expansion#3.rl_cat
estadd scalar p13=r(p)

test 1.expansion#1.rl_cat = 1.expansion#4.rl_cat
estadd scalar p14=r(p)

test 1.expansion#1.rl_cat = 1.expansion#2.rl_cat = 1.expansion#3.rl_cat = 1.expansion#4.rl_cat
estadd scalar pj=r(p)


test 1.expansion#1.rl_cat = 1.expansion#2.rl_cat = 1.expansion#3.rl_cat = 1.expansion#4.rl_cat , mtest(b)
estadd scalar pjm=r(p)


}



esttab using finaltest-across.csv, b(3) se(3) replace keep(*expansion*) sca(p12 p13 p14 pj pjm)

estimates clear


***test across RL***
estimates clear
foreach y in a b h w {

eststo: areg y`y'1864_uninsured  (1.expansion 1.post)#i.rl_cat , vce(cluster statefips) absorb(id)

margins rl_cat#expansion

marginsplot, scheme(swift_red)

graph save margpred`y'.gph, replace
}

graph combine margpreda.gph margpredb.gph margpredw.gph margpredh.gph, ycommon

graph save combmp.gph, replace
estimates clear



***test across RL***
estimates clear
foreach y in a b h w {

eststo: areg y`y'1864_uninsured  (1.expansion 1.post)#i.rl_cat , vce(cluster statefips) absorb(id)

margins rl_cat, dydx(expansion)

marginsplot, scheme(swift_red)

graph save der`y'.gph, replace
}

graph combine dera.gph derb.gph derw.gph derh.gph, ycommon

graph save combdr.gph, replace

estimates clear



estimates clear
foreach y in b w h {

areg y`y'1864_uninsured  (1.expansion 1.post)#i.rl_cat , vce(cluster statefips) absorb(id)

margins rl_cat, dydx(expansion) post

estimates store `y'm
}
	 
	coefplot bm wm hm, vertical drop(_cons *post*)  scheme(swift_red) xtitle("Redline Category") ytitle("ATE")  recast(connected) lpattern( dot) ciopts(recast(rcap)) rename(1.rl_cat = "1" 2.rl_cat = "2" 3.rl_cat = "3" 4.rl_cat =  "4") yline(0)


graph save f3_coefplot.gph, replace



estimates clear
foreach y in b w h {

areg y`y'1864_uninsured  (1.expansion 1.post)#i.rl_cat , vce(cluster statefips) absorb(id)

margins rl_cat, eydx(expansion) post

estimates store `y'm
}
	 
	coefplot bm wm hm, vertical drop(_cons *post*)  scheme(swift_red) xtitle("Redline Category") ytitle("ATE")  recast(connected) lpattern( dot) ciopts(recast(rcap)) rename(1.rl_cat = "1" 2.rl_cat = "2" 3.rl_cat = "3" 4.rl_cat =  "4") yline(0)


graph save sfey_coefplot.gph, replace

esttab bm wm hm using semielast.csv, b(3) se(3) , replace


