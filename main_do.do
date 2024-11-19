cd D:\ou_na_修改\1104\outage-main\outage-main\data_natural\
use "data_natural.dta",clear
foreach var of varlist  Outage_frequency Outage_frequency_unplanned  Outage_frequency_planned Outage_frequency_0_6h Outage_frequency_6h {
gen ln`var'=ln((`var'+1)/pop)
}
foreach var of varlist  Outage_duration Outage_duration_6h  Outage_duration_unplanned  Outage_duration_planned  Outage_duration_0_6h  {
gen ln`var'=ln(`var'+1)
}
*****************table 1
reghdfe lnOutage_frequency Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
est store m1
reghdfe lnOutage_duration Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
est store m2
reghdfe lnOutage_frequency Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend, absorb(County#YM) vce(cluster County)
est store m3
reghdfe lnOutage_duration Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend, absorb(County#YM) vce(cluster County)
est store m4
esttab m1 m2 m3 m4 using table1.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
*****************figure2 a b
reghdfe lnOutage_frequency Natural_disaster festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m1
reghdfe lnOutage_frequency Natural_disaster festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m2
reghdfe lnOutage_duration Natural_disaster festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m3
reghdfe lnOutage_duration Natural_disaster festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m4
************
reghdfe lnOutage_frequency Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m5
reghdfe lnOutage_frequency Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m6
reghdfe lnOutage_duration Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m7
reghdfe lnOutage_duration Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m8
esttab m1 m2 m3 m4 m5 m6 m7 m8 using figure_a_b.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
*****************figure2 a b
coefplot (m1, keep(Natural_disaster) mc("255 136 132") lc("255 136 132")  ms(circle) ciopt(recast(rcap) lcolor("255 136 132") lw(0.7) )) (m2,keep(Natural_disaster) mc("49 130 189") lc("49 130 189")  ms(circle) ciopt(recast(rcap) lcolor("49 130 189") lw(0.7) )) (m5, keep(Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave) mc("255 136 132") lc("255 136 132")  ms(circle) ciopt(recast(rcap) lcolor("255 136 132") lw(0.7) )) (m6,keep(Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave) mc("49 130 189") lc("49 130 189")  ms(circle) ciopt(recast(rcap) lcolor("49 130 189") lw(0.7) )), vertical nolabel xline(1.4, lp(dash) lcolor(gs10)) graphregion(color(white)) ylabel(,labsize(*1.3))  xlabel(0.8 "ND" 2.0 "Strong wind" 3.1 "Rainstorm" 4.1 "Cold wave" 5.2 "Geo hazard" 6.2 "Wildfire" 7.2 "Heatwave",labsize(*1.2) ) mcolor(black) legend(order(2  4) label(2 "poverty") label(4 "Non-poverty")  size(3.4)  color(gs3) col(3) row(3) ring(0) pos(11) rowgap(0.4) colgap(0.4) keygap(0.4) region(lcolor(white)) ) scheme(plotplain) title("Outage frequency", size(5)) graphregion(fcolor(white)) ytitle("Estimation",size(4))
graph export "figure2a.png",  as(png) replace
**************************
coefplot (m3, keep(Natural_disaster) mc("255 136 132") lc("255 136 132")  ms(circle) ciopt(recast(rcap) lcolor("255 136 132") lw(0.7) )) (m4,keep(Natural_disaster) mc("49 130 189") lc("49 130 189")  ms(circle) ciopt(recast(rcap) lcolor("49 130 189") lw(0.7) )) (m7, keep(Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave) mc("255 136 132") lc("255 136 132")  ms(circle) ciopt(recast(rcap) lcolor("255 136 132") lw(0.7) )) (m8,keep(Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave) mc("49 130 189") lc("49 130 189")  ms(circle) ciopt(recast(rcap) lcolor("49 130 189") lw(0.7) )), vertical nolabel xline(1.4, lp(dash) lcolor(gs10)) graphregion(color(white)) ylabel(,labsize(*1.3))  xlabel(0.8 "ND" 2.0 "Strong wind" 3.1 "Rainstorm" 4.1 "Cold wave" 5.2 "Geo hazard" 6.2 "Wildfire" 7.2 "Heatwave",labsize(*1.2) ) mcolor(black) legend(order(2  4) label(2 "poverty") label(4 "Non-poverty")  size(3.4)  color(gs3) col(3) row(3) ring(0) pos(11) rowgap(0.4) colgap(0.4) keygap(0.4) region(lcolor(white)) ) scheme(plotplain) title("Outage duration", size(5)) graphregion(fcolor(white)) ytitle("Estimation",size(4))
graph export "figure2b.png",  as(png) replace


****************************************figure2 c d
reghdfe lnOutage_frequency_unplanned Natural_disaster festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m1
parmest , saving(1.dta, replace) idstr("g1") idnum(1) 
reghdfe lnOutage_frequency_unplanned Natural_disaster festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m2
parmest , saving(2.dta, replace) idstr("g0") idnum(1) 
reghdfe lnOutage_frequency_planned Natural_disaster festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m3
parmest , saving(3.dta, replace) idstr("f1") idnum(1) 
reghdfe lnOutage_frequency_planned Natural_disaster festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m4
parmest , saving(4.dta, replace) idstr("f0") idnum(1) 
reghdfe lnOutage_frequency_0_6h Natural_disaster festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m5
parmest , saving(5.dta, replace) idstr("11") idnum(1) 
reghdfe lnOutage_frequency_0_6h Natural_disaster festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m6
parmest , saving(6.dta, replace) idstr("10") idnum(1) 
reghdfe lnOutage_frequency_6h Natural_disaster festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m7
parmest , saving(7.dta, replace) idstr("61") idnum(1) 
reghdfe lnOutage_frequency_6h Natural_disaster festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m8
parmest , saving(8.dta, replace) idstr("60") idnum(1) 
reghdfe lnOutage_frequency Natural_disaster festival weekend if poverty==1 & north==1, absorb(County#YM) vce(cluster County)
est store m9
parmest , saving(9.dta, replace) idstr("n1") idnum(1)
reghdfe lnOutage_frequency Natural_disaster festival weekend if poverty==0 & north==1,  absorb(County#YM) vce(cluster County)
est store m10
parmest , saving(10.dta, replace) idstr("n0") idnum(1)
reghdfe lnOutage_frequency Natural_disaster festival weekend if poverty==1 & north==0,  absorb(County#YM) vce(cluster County)
est store m11
parmest , saving(11.dta, replace) idstr("s1") idnum(1)
reghdfe lnOutage_frequency Natural_disaster festival weekend if poverty==0 & north==0,  absorb(County#YM) vce(cluster County)
est store m12
parmest , saving(12.dta, replace) idstr("s0") idnum(1)
reghdfe lnOutage_frequency Natural_disaster festival weekend if poverty==1 & summer==1,  absorb(County#YM) vce(cluster County)
est store m13
parmest , saving(13.dta, replace) idstr("x1") idnum(1)
reghdfe lnOutage_frequency Natural_disaster festival weekend if poverty==0 & summer==1,  absorb(County#YM) vce(cluster County)
est store m14
parmest , saving(14.dta, replace) idstr("x0") idnum(1)
reghdfe lnOutage_frequency Natural_disaster festival weekend if poverty==1 & summer==0,  absorb(County#YM) vce(cluster County)
est store m15
parmest , saving(15.dta, replace) idstr("d1") idnum(1)
reghdfe lnOutage_frequency Natural_disaster festival weekend if poverty==0 & summer==0,  absorb(County#YM) vce(cluster County)
est store m16
parmest , saving(16.dta, replace) idstr("d0") idnum(1)
esttab m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 m13 m14 m15 m16 using figure_c.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
preserve
use 1.dta,clear
forvalues i=2/16{
append using `i'.dta
}
save "Outage_frequency_heter.dta",replace
restore

reghdfe lnOutage_duration_unplanned Natural_disaster festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m1
parmest , saving(1.dta, replace) idstr("g1") idnum(1) 
reghdfe lnOutage_duration_unplanned Natural_disaster festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m2
parmest , saving(2.dta, replace) idstr("g0") idnum(1) 
reghdfe lnOutage_duration_planned Natural_disaster festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m3
parmest , saving(3.dta, replace) idstr("f1") idnum(1) 
reghdfe lnOutage_duration_planned Natural_disaster festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m4
parmest , saving(4.dta, replace) idstr("f0") idnum(1) 
reghdfe lnOutage_duration_0_6h Natural_disaster festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m5
parmest , saving(5.dta, replace) idstr("11") idnum(1) 
reghdfe lnOutage_duration_0_6h Natural_disaster festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m6
parmest , saving(6.dta, replace) idstr("10") idnum(1) 
reghdfe lnOutage_duration_6h Natural_disaster festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m7
parmest , saving(7.dta, replace) idstr("61") idnum(1) 
reghdfe lnOutage_duration_6h Natural_disaster festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m8
parmest , saving(8.dta, replace) idstr("60") idnum(1) 
reghdfe lnOutage_duration Natural_disaster festival weekend if poverty==1 & north==1, absorb(County#YM) vce(cluster County)
est store m9
parmest , saving(9.dta, replace) idstr("n1") idnum(1)
reghdfe lnOutage_duration Natural_disaster festival weekend if poverty==0 & north==1,  absorb(County#YM) vce(cluster County)
est store m10
parmest , saving(10.dta, replace) idstr("n0") idnum(1)
reghdfe lnOutage_duration Natural_disaster festival weekend if poverty==1 & north==0,  absorb(County#YM) vce(cluster County)
est store m11
parmest , saving(11.dta, replace) idstr("s1") idnum(1)
reghdfe lnOutage_duration Natural_disaster festival weekend if poverty==0 & north==0,  absorb(County#YM) vce(cluster County)
est store m12
parmest , saving(12.dta, replace) idstr("s0") idnum(1)
reghdfe lnOutage_duration Natural_disaster festival weekend if poverty==1 & summer==1,  absorb(County#YM) vce(cluster County)
est store m13
parmest , saving(13.dta, replace) idstr("x1") idnum(1)
reghdfe lnOutage_duration Natural_disaster festival weekend if poverty==0 & summer==1,  absorb(County#YM) vce(cluster County)
est store m14
parmest , saving(14.dta, replace) idstr("x0") idnum(1)
reghdfe lnOutage_duration Natural_disaster festival weekend if poverty==1 & summer==0,  absorb(County#YM) vce(cluster County)
est store m15
parmest , saving(15.dta, replace) idstr("d1") idnum(1)
reghdfe lnOutage_duration Natural_disaster festival weekend if poverty==0 & summer==0,  absorb(County#YM) vce(cluster County)
est store m16
parmest , saving(16.dta, replace) idstr("d0") idnum(1)
esttab m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 m13 m14 m15 m16 using figure_d.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
preserve
use 1.dta,clear
forvalues i=2/16{
append using `i'.dta
}
save "Outage_duration_heter.dta",replace
restore
reghdfe lnOutage_frequency_unplanned Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m1 
reghdfe lnOutage_frequency_planned Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m2
reghdfe lnOutage_duration_unplanned Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m3 
reghdfe lnOutage_duration_planned Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m4
reghdfe lnOutage_frequency_0_6h Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m5
reghdfe lnOutage_frequency_6h Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m6
reghdfe lnOutage_duration_0_6h Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m7 
reghdfe lnOutage_duration_6h Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m8
reghdfe lnOutage_frequency Natural_disaster festival weekend if north==1, absorb(County#YM) vce(cluster County)
est store m9
reghdfe lnOutage_frequency Natural_disaster festival weekend if north==0, absorb(County#YM) vce(cluster County)
est store m10
reghdfe lnOutage_duration Natural_disaster festival weekend if north==1, absorb(County#YM) vce(cluster County)
est store m11
reghdfe lnOutage_duration Natural_disaster festival weekend if north==0, absorb(County#YM) vce(cluster County)
est store m12
esttab m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 using figure_c_sup.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)

***************************figure c d
use "Outage_frequency_heter.dta",clear
keep if parm == "Natural_disaster"
gen poor=substr(idstr,2,1)
destring poor,replace
gen n=1 if idstr=="g1"
replace n=2 if idstr=="g0"
replace n=4 if idstr=="f1"
replace n=5 if idstr=="f0"
replace n=7 if idstr=="11"
replace n=8 if idstr=="10"
replace n=10 if idstr=="61"
replace n=11 if idstr=="60"
replace n=13 if idstr=="n1"
replace n=14 if idstr=="n0"
replace n=16 if idstr=="s1"
replace n=17 if idstr=="s0"
replace n=19 if idstr=="x1"
replace n=20 if idstr=="x0"
replace n=22 if idstr=="d1"
replace n=23 if idstr=="d0"
twoway scatter estimate n if poor==1, color("255 136 132") ms(circle)|| scatter estimate n if poor==0, color("49 130 189") ms(circle)|| rcap max95 min95 n if poor==1 , lcolor("255 136 132") lw(thick) || rcap max95 min95 n if poor==0, xline(6 12 18)  lcolor("49 130 189") lw(thick) scheme(plotplain) xlab(1.5 "Unplanned"  4.5 "Planned" 7.5 "6h-"  10.5 "6h+" 13.5 "North"  16.5 "South" 19.5 "Summer"  22.5 "Winter"  , labsize(*1.3) labcolor(black) axis(1) nogrid) legend(order( 1 2) label(1 "poverty") label(2 "Non_poverty")  size(3.4)  color(gs3) col(3) row(3) ring(0) pos(11) rowgap(0.4) colgap(0.4) keygap(0.4) region(lcolor(white)) ) xtitle("") xsize(3) ysize(2) ytitle("Estimation",size(4)) title("Outage frequency(Heterogeneity)",size(5)) 
graph export "figure_c.png",  as(png) replace
*************
use "Outage_duration_heter.dta",clear
keep if parm == "Natural_disaster"
gen poor=substr(idstr,2,1)
destring poor,replace
gen n=1 if idstr=="g1"
replace n=2 if idstr=="g0"
replace n=4 if idstr=="f1"
replace n=5 if idstr=="f0"
replace n=7 if idstr=="11"
replace n=8 if idstr=="10"
replace n=10 if idstr=="61"
replace n=11 if idstr=="60"
replace n=13 if idstr=="n1"
replace n=14 if idstr=="n0"
replace n=16 if idstr=="s1"
replace n=17 if idstr=="s0"
replace n=19 if idstr=="x1"
replace n=20 if idstr=="x0"
replace n=22 if idstr=="d1"
replace n=23 if idstr=="d0"
twoway scatter estimate n if poor==1, color("255 136 132") ms(circle)|| scatter estimate n if poor==0, color("49 130 189") ms(circle)|| rcap max95 min95 n if poor==1 , lcolor("255 136 132") lw(thick) || rcap max95 min95 n if poor==0, xline(6 12 18)  lcolor("49 130 189") lw(thick) scheme(plotplain) xlab(1.5 "Unplanned"  4.5 "Planned" 7.5 "6h-"  10.5 "6h+" 13.5 "North"  16.5 "South" 19.5 "Summer"  22.5 "Winter"  , labsize(*1.3) labcolor(black) axis(1) nogrid) legend(order( 1 2) label(1 "poverty") label(2 "Non_poverty")  size(3.4)  color(gs3) col(3) row(3) ring(0) pos(11) rowgap(0.4) colgap(0.4) keygap(0.4) region(lcolor(white)) ) xtitle("") xsize(3) ysize(2) ytitle("Estimation",size(4)) title("Outage duration(Heterogeneity)",size(5)) 
graph export "figure_d.png",  as(png) replace

*****Decomposition of natural disaster impacts
use "data_natural.dta",clear
foreach var of varlist  Outage_frequency Outage_frequency_unplanned  Outage_frequency_planned Outage_frequency_0_6h Outage_frequency_6h {
gen ln`var'=ln((`var'+1)/pop)
}
foreach var of varlist  Outage_duration Outage_duration_6h  Outage_duration_unplanned  Outage_duration_planned  Outage_duration_0_6h  {
gen ln`var'=ln(`var'+1)
}
cls
qui reghdfe lnOutage_frequency  festival weekend, absorb(County#YM) vce(cluster County) resid
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe lnOutage_frequency  festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe lnOutage_frequency  festival weekend  if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
********
qui reghdfe lnOutage_duration  festival weekend, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe lnOutage_duration  festival weekend  if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe lnOutage_duration  festival weekend  if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
************************
qui reghdfe lnOutage_frequency_unplanned festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency_unplanned festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency_planned festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency_planned festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency_0_6h festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency_0_6h festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency_6h festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency_6h festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==1 & north==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==0 & north==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==1 & north==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==0 & north==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==1 & summer==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==0 & summer==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==1 & summer==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==0 & summer==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
************************
qui reghdfe lnOutage_duration_unplanned festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration_unplanned festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration_planned festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration_planned festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration_0_6h festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration_0_6h festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration_6h festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration_6h festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==1 & north==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==0 & north==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==1 & north==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==0 & north==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==1 & summer==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==0 & summer==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==1 & summer==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==0 & summer==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
*************************figure e f
use decomposition.dta,clear
keep Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave graph sort poverty  variable group
graph bar Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave       if graph ==1, stack over(poverty, gap(*0.2) )  over(group, gap(*0.9) sort(sort)) bar(1, fcolor(rgb(49 130 189)) lcolor(rgb(49 130 189) )) ///
bar(2, fcolor(rgb(158 202 225)) lcolor(rgb(158 202 225)) ) ///
bar(3, fcolor(rgb(222 235 247)) lcolor(rgb(222 235 247) )) ///
bar(4, fcolor(rgb(248 172 140)) lcolor(rgb(248 172 140) )) ///
bar(5, fcolor(rgb(255 136 132)) lcolor(rgb(255 136 132))) ///
bar(6, fcolor(rgb(230 67 67)) lcolor(rgb(230 67 67))) ///
ytitle(Variable importance, size(5)) legend(order(6 "Heatwave" 5 "Wildfire" 4 "Geo hazard" 3 "Cold wave" 2 "Rainstorm" 1 "Strong wind") pos(3) rows(12) size(4)  symxsize(8) region(lcolor(white)) stack) bargap(0.3)  title("Outage frequency(Shapely values)",size(5)) scheme(plotplain) ylabel(,labsize(*1.3))
graph export "figure_e.png",  as(png) replace
graph bar Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave if graph ==2, stack over(poverty, gap(*0.2))  over(group, gap(*0.9) sort(sort)) bar(1, fcolor(rgb(49 130 189)) lcolor(rgb(49 130 189) )) ///
bar(2, fcolor(rgb(158 202 225)) lcolor(rgb(158 202 225)) ) ///
bar(3, fcolor(rgb(222 235 247)) lcolor(rgb(222 235 247) )) ///
bar(4, fcolor(rgb(248 172 140)) lcolor(rgb(248 172 140) )) ///
bar(5, fcolor(rgb(255 136 132)) lcolor(rgb(255 136 132))) ///
bar(6, fcolor(rgb(230 67 67)) lcolor(rgb(230 67 67)) ) ///
ytitle(Variable importance, size(5)) legend(order(6 "Heatwave" 5 "Wildfire" 4 "Geo hazard" 3 "Cold wave" 2 "Rainstorm" 1 "Strong wind") pos(3) rows(12) size(4)  symxsize(8) region(lcolor(white)) stack) bargap(0.3)  title("Outage duration(Shapely values)",size(5)) scheme(plotplain) ylabel(,labsize(*1.3))
graph export "figure_f.png",  as(png) replace
