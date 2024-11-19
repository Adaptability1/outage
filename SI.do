***Table S1
cd D:\ou_na_修改\1104\outage-main\outage-main\data_natural\
use "data_natural.dta",clear
sum2docx Natural_disaster Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend using sum.docx, replace stats(N mean(%9.4f) sd(%9.4f) min max) landscape title("Summary statistics") 
********************Table S2
use "data_natural.dta",clear
foreach var of varlist  Outage_frequency Outage_frequency_unplanned  Outage_frequency_planned Outage_frequency_0_6h Outage_frequency_6h {
gen ln`var'=ln((`var'+1)/pop)
}
foreach var of varlist  Outage_duration Outage_duration_6h  Outage_duration_unplanned  Outage_duration_planned  Outage_duration_0_6h  {
gen ln`var'=ln(`var'+1)
}
******
foreach var of varlist  Outage_frequency Outage_frequency_unplanned  Outage_frequency_planned Outage_frequency_0_6h Outage_frequency_6h {
gen sum`var'=(`var')/pop
}
foreach var of varlist  Outage_duration Outage_duration_6h  Outage_duration_unplanned  Outage_duration_planned  Outage_duration_0_6h  {
gen sum`var'=`var'
}
*****
reghdfe sumOutage_frequency Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
est store m1
reghdfe sumOutage_frequency Natural_disaster festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m2
reghdfe sumOutage_frequency Natural_disaster festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m3
reghdfe sumOutage_frequency c.Natural_disaster##c.poverty festival weekend , absorb(County#YM) vce(cluster County)
est store m4
reghdfe sumOutage_frequency Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m5
reghdfe sumOutage_frequency Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m6
esttab m1 m2 m3 m4 m5 m6 using tables2.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
*************Table S3
reghdfe sumOutage_duration Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
est store m1
reghdfe sumOutage_duration Natural_disaster festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m2
reghdfe sumOutage_duration Natural_disaster festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m3
reghdfe sumOutage_duration c.Natural_disaster##c.poverty festival weekend , absorb(County#YM) vce(cluster County)
est store m4
reghdfe sumOutage_duration Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m5
reghdfe sumOutage_duration Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m6
esttab m1 m2 m3 m4 m5 m6 using tables3.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
****************Table S4
use "data_natural.dta",clear
foreach var of varlist  Outage_frequency Outage_frequency_unplanned  Outage_frequency_planned Outage_frequency_0_6h Outage_frequency_6h {
gen ln`var'=ln((`var'+1)/pop)
}
foreach var of varlist  Outage_duration Outage_duration_6h  Outage_duration_unplanned  Outage_duration_planned  Outage_duration_0_6h  {
gen ln`var'=ln(`var'+1)
}
******
foreach var of varlist  Outage_frequency Outage_frequency_unplanned  Outage_frequency_planned Outage_frequency_0_6h Outage_frequency_6h {
gen sum`var'=(`var')/pop
}
foreach var of varlist  Outage_duration Outage_duration_6h  Outage_duration_unplanned  Outage_duration_planned  Outage_duration_0_6h  {
gen sum`var'=`var'
}
gen outagehour=Outage_frequency*Outage_duration/pop
reghdfe outagehour Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m1
reghdfe outagehour Natural_disaster festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m2
reghdfe outagehour Natural_disaster festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m3
reghdfe outagehour c.Natural_disaster##c.poverty festival weekend , absorb(County#YM) vce(cluster County)
est store m4
reghdfe outagehour Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend if poverty==1, absorb(County#YM) vce(cluster County)
est store m5
reghdfe outagehour Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend if poverty==0, absorb(County#YM) vce(cluster County)
est store m6
esttab m1 m2 m3 m4 m5 m6 using tables4.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
**************Table S5
reghdfe lnOutage_frequency Natural_disaster festival weekend CEPI Coal_price COVID_19, absorb(County#YM) vce(cluster County)
est store m1
reghdfe lnOutage_duration Natural_disaster festival weekend CEPI Coal_price COVID_19, absorb(County#YM) vce(cluster County)
est store m2
reghdfe lnOutage_frequency Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend CEPI Coal_price COVID_19, absorb(County#YM) vce(cluster County)
est store m3
reghdfe lnOutage_duration Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend CEPI Coal_price COVID_19, absorb(County#YM) vce(cluster County)
est store m4
esttab m1 m2 m3 m4 using tables5.csv, scalars(r2 r2_w r2_o r2_b)  pr2  se replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
*****Table s6
reghdfe lnOutage_frequency c.Natural_disaster##i.poverty festival weekend , absorb(County#YM) vce(cluster County)
est store m1
reghdfe lnOutage_duration c.Natural_disaster##i.poverty festival weekend , absorb(County#YM) vce(cluster County)
est store m2
gen Natural_disaster_2=1 if Natural_disaster>0
replace Natural_disaster_2=0 if Natural_disaster_2==.
reghdfe lnOutage_frequency c.Natural_disaster_2##i.poverty festival weekend , absorb(County#YM) vce(cluster County)
est store m3
reghdfe lnOutage_duration c.Natural_disaster_2##i.poverty festival weekend , absorb(County#YM) vce(cluster County)
est store m4
xtile x_income = income, nq(3)
gen poverty_2=1 if x_income==1
replace poverty_2=0 if x_income==2
replace poverty_2=0 if x_income==3
reghdfe lnOutage_frequency c.Natural_disaster##i.poverty_2 festival weekend , absorb(County#YM) vce(cluster County)
est store m5
reghdfe lnOutage_duration c.Natural_disaster##i.poverty_2 festival weekend , absorb(County#YM) vce(cluster County)
est store m6
esttab m1 m2 m3 m4 m5 m6 using tables6.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
*************Table S7
use "data_natural.dta",clear
foreach var of varlist  Outage_frequency Outage_frequency_unplanned  Outage_frequency_planned Outage_frequency_0_6h Outage_frequency_6h {
gen ln`var'=ln((`var'+1)/pop)
}
foreach var of varlist  Outage_duration Outage_duration_6h  Outage_duration_unplanned  Outage_duration_planned  Outage_duration_0_6h  {
gen ln`var'=ln(`var'+1)
}
reghdfe lnOutage_frequency c.Natural_disaster##c.EGI festival weekend , absorb(County#YM) vce(cluster County)
est store m1
reghdfe lnOutage_duration c.Natural_disaster##c.EGI festival weekend , absorb(County#YM) vce(cluster County)
est store m2
reghdfe lnOutage_frequency c.Natural_disaster##c.Labor festival weekend , absorb(County#YM) vce(cluster County)
est store m3
reghdfe lnOutage_duration c.Natural_disaster##c.Labor festival weekend , absorb(County#YM) vce(cluster County)
est store m4
esttab m1 m2 m3 m4 using tables7.csv, scalars(r2 r2_w r2_o r2_b)  pr2  se replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
**************************Table S8 Empirical p values
use "data_natural.dta",clear
foreach var of varlist  Outage_frequency Outage_frequency_unplanned  Outage_frequency_planned Outage_frequency_0_6h Outage_frequency_6h {
gen ln`var'=ln((`var'+1)/pop)
}
foreach var of varlist  Outage_duration Outage_duration_6h  Outage_duration_unplanned  Outage_duration_planned  Outage_duration_0_6h  {
gen ln`var'=ln(`var'+1)
}
set seed 123
******************************************
cls
bdiff, group(poverty) model(reghdfe lnOutage_frequency Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail

bdiff, group(poverty) model(reghdfe lnOutage_duration Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
******************************************
bdiff, group(poverty) model(reghdfe lnOutage_frequency Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail

bdiff, group(poverty) model(reghdfe lnOutage_duration Strong_wind Rainstorm Cold_wave Geo_hazard Wildfire Heatwave festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail

bdiff, group(poverty) model(reghdfe lnOutage_frequency_unplanned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
bdiff, group(poverty) model(reghdfe lnOutage_duration_unplanned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
**************
bdiff, group(poverty) model(reghdfe lnOutage_frequency_planned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
bdiff, group(poverty) model(reghdfe lnOutage_duration_planned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
*************
bdiff, group(poverty) model(reghdfe lnOutage_frequency_0_6h Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
bdiff, group(poverty) model(reghdfe lnOutage_duration_0_6h Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
*************
bdiff, group(poverty) model(reghdfe lnOutage_frequency_6h Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
bdiff, group(poverty) model(reghdfe lnOutage_duration_6h Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
**************
preserve
keep if north==1
bdiff, group(poverty) model(reghdfe lnOutage_frequency Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
bdiff, group(poverty) model(reghdfe lnOutage_duration Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
restore
***********************
preserve
keep if north==0
bdiff, group(poverty) model(reghdfe lnOutage_frequency Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
bdiff, group(poverty) model(reghdfe lnOutage_duration Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
restore
*************************
preserve
keep if summer==1 
bdiff, group(poverty) model(reghdfe lnOutage_frequency Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
bdiff, group(poverty) model(reghdfe lnOutage_duration Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
restore
*********************
preserve
keep if summer==0
bdiff, group(poverty) model(reghdfe lnOutage_frequency Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
bdiff, group(poverty) model(reghdfe lnOutage_duration Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
restore

*****Table S9
use "data_natural.dta",clear
foreach var of varlist  Outage_frequency Outage_frequency_unplanned  Outage_frequency_planned Outage_frequency_0_6h Outage_frequency_6h {
gen ln`var'=ln((`var'+1)/pop)
}
foreach var of varlist  Outage_duration Outage_duration_6h  Outage_duration_unplanned  Outage_duration_planned  Outage_duration_0_6h  {
gen ln`var'=ln(`var'+1)
}
reghdfe lnOutage_frequency_unplanned c.Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
est store m1
reghdfe lnOutage_frequency_planned c.Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
est store m2
reghdfe lnOutage_frequency_0_6h c.Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
est store m3
reghdfe lnOutage_frequency_6h c.Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
est store m4
reghdfe lnOutage_frequency c.Natural_disaster festival weekend if north==1, absorb(County#YM) vce(cluster County)
est store m5
reghdfe lnOutage_frequency c.Natural_disaster festival weekend if north==0, absorb(County#YM) vce(cluster County)
est store m6
reghdfe lnOutage_frequency c.Natural_disaster festival weekend if summer==1, absorb(County#YM) vce(cluster County)
est store m7
reghdfe lnOutage_frequency c.Natural_disaster festival weekend if summer==0, absorb(County#YM) vce(cluster County)
est store m8
esttab m1 m2 m3 m4 m5 m6 m7 m8  using tables9.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)

******Table S10
use "data_natural.dta",clear
foreach var of varlist  Outage_frequency Outage_frequency_unplanned  Outage_frequency_planned Outage_frequency_0_6h Outage_frequency_6h {
gen ln`var'=ln((`var'+1)/pop)
}
foreach var of varlist  Outage_duration Outage_duration_6h  Outage_duration_unplanned  Outage_duration_planned  Outage_duration_0_6h  {
gen ln`var'=ln(`var'+1)
}
reghdfe lnOutage_duration_unplanned c.Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
est store m1
reghdfe lnOutage_duration_planned c.Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
est store m2
reghdfe lnOutage_duration_0_6h c.Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
est store m3
reghdfe lnOutage_duration_6h c.Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
est store m4
reghdfe lnOutage_duration c.Natural_disaster festival weekend if north==1, absorb(County#YM) vce(cluster County)
est store m5
reghdfe lnOutage_duration c.Natural_disaster festival weekend if north==0, absorb(County#YM) vce(cluster County)
est store m6
reghdfe lnOutage_duration c.Natural_disaster festival weekend if summer==1, absorb(County#YM) vce(cluster County)
est store m7
reghdfe lnOutage_duration c.Natural_disaster festival weekend if summer==0, absorb(County#YM) vce(cluster County)
est store m8
esttab m1 m2 m3 m4 m5 m6 m7 m8  using tables10.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)





