***Table S1
cd  D:\ou_na_修改\0101\代码整理\
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
************************Table S6
use "data_natural.dta",clear
foreach var of varlist  Outage_frequency Outage_frequency_unplanned  Outage_frequency_planned Outage_frequency_0_6h Outage_frequency_6h {
gen ln`var'=ln((`var'+1)/pop)
}
foreach var of varlist  Outage_duration Outage_duration_6h  Outage_duration_unplanned  Outage_duration_planned  Outage_duration_0_6h  {
gen ln`var'=ln(`var'+1)
}
foreach var of varlist  Natural_disaster{
bys County :egen sum`var'=sum(`var')
}
gen group=0 if sumNatural_disaster>0 & sumNatural_disaster<=10
replace group=1 if sumNatural_disaster>10 
reghdfe lnOutage_frequency_unplanned Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m1
reghdfe lnOutage_frequency_planned Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m2
reghdfe lnOutage_frequency_0_6h Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m3
reghdfe lnOutage_frequency_6h Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m4
reghdfe lnOutage_frequency Natural_disaster festival weekend  if north==1, absorb(County#YM) vce(cluster County)
est store m5
reghdfe lnOutage_frequency Natural_disaster festival weekend  if north==0,  absorb(County#YM) vce(cluster County)
est store m6
reghdfe lnOutage_frequency Natural_disaster festival weekend  if summer==1,  absorb(County#YM) vce(cluster County)
est store m7
reghdfe lnOutage_frequency Natural_disaster festival weekend  if summer==0,  absorb(County#YM) vce(cluster County)
est store m8
reghdfe lnOutage_frequency Natural_disaster festival weekend  if group==0,  absorb(County#YM) vce(cluster County)
est store m9
reghdfe lnOutage_frequency Natural_disaster festival weekend  if group==1,  absorb(County#YM) vce(cluster County)
est store m10
esttab  m1 m2 m3 m4 m5 m6 m7 m8 m9 m10  using tables6.csv, scalars(r2 r2_w r2_o r2_b)  pr2  se replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
***************table s7
reghdfe lnOutage_duration_unplanned Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m1
reghdfe lnOutage_duration_planned Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m2
reghdfe lnOutage_duration_0_6h Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m3
reghdfe lnOutage_duration_6h Natural_disaster festival weekend , absorb(County#YM) vce(cluster County)
est store m4
reghdfe lnOutage_duration Natural_disaster festival weekend  if north==1, absorb(County#YM) vce(cluster County)
est store m5
reghdfe lnOutage_duration Natural_disaster festival weekend  if north==0,  absorb(County#YM) vce(cluster County)
est store m6
reghdfe lnOutage_duration Natural_disaster festival weekend  if summer==1,  absorb(County#YM) vce(cluster County)
est store m7
reghdfe lnOutage_duration Natural_disaster festival weekend  if summer==0,  absorb(County#YM) vce(cluster County)
est store m8
reghdfe lnOutage_duration Natural_disaster festival weekend  if group==0,  absorb(County#YM) vce(cluster County)
est store m9
reghdfe lnOutage_duration Natural_disaster festival weekend  if group==1,  absorb(County#YM) vce(cluster County)
est store m10
esttab m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 using tables7.csv, scalars(r2 r2_w r2_o r2_b)  pr2  se replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
*******table s8

reghdfe lnOutage_frequency_unplanned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef1 = _b[Natural_disaster]
scalar se1 = _se[Natural_disaster]
reghdfe lnOutage_frequency_planned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef2 = _b[Natural_disaster]
scalar se2 = _se[Natural_disaster]
scalar diff = coef1 - coef2
scalar se_diff = sqrt(se1^2 + se2^2)
scalar t = diff / se_diff
scalar df = e(df_r)
display "t = " t ", diff = " diff ", p-value = " 2 * ttail(df, abs(t))
*****************
reghdfe lnOutage_frequency_planned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef1 = _b[Natural_disaster]
scalar se1 = _se[Natural_disaster]
reghdfe lnOutage_duration_planned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef2 = _b[Natural_disaster]
scalar se2 = _se[Natural_disaster]
scalar diff = coef1 - coef2
scalar se_diff = sqrt(se1^2 + se2^2)
scalar t = diff / se_diff
scalar df = e(df_r)
display "t = " t ", diff = " diff ", p-value = " 2 * ttail(df, abs(t))
****************
reghdfe lnOutage_duration_unplanned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef1 = _b[Natural_disaster]
scalar se1 = _se[Natural_disaster]
reghdfe lnOutage_frequency_planned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef2 = _b[Natural_disaster]
scalar se2 = _se[Natural_disaster]
scalar diff = coef1 - coef2
scalar se_diff = sqrt(se1^2 + se2^2)
scalar t = diff / se_diff
scalar df = e(df_r)
display "t = " t ", diff = " diff ", p-value = " 2 * ttail(df, abs(t))
*****************
reghdfe lnOutage_duration_planned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef1 = _b[Natural_disaster]
scalar se1 = _se[Natural_disaster]
reghdfe lnOutage_duration_planned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef2 = _b[Natural_disaster]
scalar se2 = _se[Natural_disaster]
scalar diff = coef1 - coef2
scalar se_diff = sqrt(se1^2 + se2^2)
scalar t = diff / se_diff
scalar df = e(df_r)
display "t = " t ", diff = " diff ", p-value = " 2 * ttail(df, abs(t))



reghdfe lnOutage_frequency_6h Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef1 = _b[Natural_disaster]
scalar se1 = _se[Natural_disaster]
reghdfe lnOutage_frequency_planned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef2 = _b[Natural_disaster]
scalar se2 = _se[Natural_disaster]
scalar diff = coef1 - coef2
scalar se_diff = sqrt(se1^2 + se2^2)
scalar t = diff / se_diff
scalar df = e(df_r)
display "t = " t ", diff = " diff ", p-value = " 2 * ttail(df, abs(t))
*****************
reghdfe lnOutage_frequency_0_6h Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef1 = _b[Natural_disaster]
scalar se1 = _se[Natural_disaster]
reghdfe lnOutage_duration_planned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef2 = _b[Natural_disaster]
scalar se2 = _se[Natural_disaster]
scalar diff = coef1 - coef2
scalar se_diff = sqrt(se1^2 + se2^2)
scalar t = diff / se_diff
scalar df = e(df_r)
display "t = " t ", diff = " diff ", p-value = " 2 * ttail(df, abs(t))
****************
reghdfe lnOutage_duration_6h Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef1 = _b[Natural_disaster]
scalar se1 = _se[Natural_disaster]
reghdfe lnOutage_frequency_planned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef2 = _b[Natural_disaster]
scalar se2 = _se[Natural_disaster]
scalar diff = coef1 - coef2
scalar se_diff = sqrt(se1^2 + se2^2)
scalar t = diff / se_diff
scalar df = e(df_r)
display "t = " t ", diff = " diff ", p-value = " 2 * ttail(df, abs(t))
*****************
reghdfe lnOutage_duration_0_6h Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef1 = _b[Natural_disaster]
scalar se1 = _se[Natural_disaster]
reghdfe lnOutage_duration_planned Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)
scalar coef2 = _b[Natural_disaster]
scalar se2 = _se[Natural_disaster]
scalar diff = coef1 - coef2
scalar se_diff = sqrt(se1^2 + se2^2)
scalar t = diff / se_diff
scalar df = e(df_r)
display "t = " t ", diff = " diff ", p-value = " 2 * ttail(df, abs(t))
******table s9
use "data_natural.dta",clear
foreach var of varlist  Outage_frequency Outage_frequency_unplanned  Outage_frequency_planned Outage_frequency_0_6h Outage_frequency_6h {
gen ln`var'=ln((`var'+1)/pop)
}
foreach var of varlist  Outage_duration Outage_duration_6h  Outage_duration_unplanned  Outage_duration_planned  Outage_duration_0_6h  {
gen ln`var'=ln(`var'+1)
}
foreach var of varlist  Natural_disaster{
bys County :egen sum`var'=sum(`var')
}
gen group=0 if sumNatural_disaster>0 & sumNatural_disaster<=10
replace group=1 if sumNatural_disaster>10 
cls
bdiff, group(group) model(reghdfe lnOutage_frequency Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
bdiff, group(north) model(reghdfe lnOutage_frequency Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
bdiff, group(summer) model(reghdfe lnOutage_frequency Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
bdiff, group(group) model(reghdfe lnOutage_duration Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
bdiff, group(north) model(reghdfe lnOutage_duration Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
bdiff, group(summer) model(reghdfe lnOutage_duration Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
*****Table s10
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
esttab m1 m2 m3 m4 m5 m6 using tables9.csv,scalars(r2 r2_w r2_o r2_b) pr2  se  replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
*************Table S11 
use "data_natural.dta",clear
foreach var of varlist  Outage_frequency Outage_frequency_unplanned  Outage_frequency_planned Outage_frequency_0_6h Outage_frequency_6h {
gen ln`var'=ln((`var'+1)/pop)
}
foreach var of varlist  Outage_duration Outage_duration_6h  Outage_duration_unplanned  Outage_duration_planned  Outage_duration_0_6h  {
gen ln`var'=ln(`var'+1)
}
reghdfe lnOutage_frequency c.Natural_disaster##c.EGI_new festival weekend , absorb(County#YM) vce(cluster County)
est store m1
reghdfe lnOutage_duration c.Natural_disaster##c.EGI_new festival weekend , absorb(County#YM) vce(cluster County)
est store m2
reghdfe lnOutage_frequency c.Natural_disaster##c.Labor festival weekend , absorb(County#YM) vce(cluster County)
est store m3
reghdfe lnOutage_duration c.Natural_disaster##c.Labor festival weekend , absorb(County#YM) vce(cluster County)
est store m4
esttab m1 m2 m3 m4 using tables11.csv, scalars(r2 r2_w r2_o r2_b)  pr2  se replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
**************************Table S12 Empirical p values
use "data_natural.dta",clear
foreach var of varlist  Outage_frequency Outage_frequency_unplanned  Outage_frequency_planned Outage_frequency_0_6h Outage_frequency_6h {
gen ln`var'=ln((`var'+1)/pop)
}
foreach var of varlist  Outage_duration Outage_duration_6h  Outage_duration_unplanned  Outage_duration_planned  Outage_duration_0_6h  {
gen ln`var'=ln(`var'+1)
}
foreach var of varlist  Natural_disaster{
bys County :egen sum`var'=sum(`var')
}
gen group=0 if sumNatural_disaster>0 & sumNatural_disaster<=10
replace group=1 if sumNatural_disaster>10 
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
preserve
keep if group==0
bdiff, group(poverty) model(reghdfe lnOutage_frequency Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
bdiff, group(poverty) model(reghdfe lnOutage_duration Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
restore
*********************
preserve
keep if group==1
bdiff, group(poverty) model(reghdfe lnOutage_frequency Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
bdiff, group(poverty) model(reghdfe lnOutage_duration Natural_disaster festival weekend, absorb(County#YM) vce(cluster County)) reps(100) detail
restore

**************FIGURE S1
use "data_natural.dta",clear
foreach var of varlist  Outage_frequency Outage_frequency_unplanned  Outage_frequency_planned Outage_frequency_0_6h Outage_frequency_6h {
gen ln`var'=ln((`var'+1)/pop)
}
foreach var of varlist  Outage_duration Outage_duration_6h  Outage_duration_unplanned  Outage_duration_planned  Outage_duration_0_6h  {
gen ln`var'=ln(`var'+1)
}
foreach var of varlist  Natural_disaster{
bys County :egen sum`var'=sum(`var')
}
gen group=0 if sumNatural_disaster>0 & sumNatural_disaster<=10
replace group=1 if sumNatural_disaster>10 
gen windrain=1 if Strong_wind==1 & Rainstorm==1
replace windrain=0 if  windrain==.
gen windalone=1 if Strong_wind ==1 & windrain==0
gen rainalone=1 if Rainstorm==1 & windrain==0
replace windalone=0 if windalone==.
replace rainalone=0 if rainalone==.
rename windalone Strong_wind_n 
rename rainalone Rainstorm_n
rename windrain Strong_wind_Rainstorm
qui reghdfe lnOutage_frequency_unplanned festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency_unplanned festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency_planned festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency_planned festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency_0_6h festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency_0_6h festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency_6h festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency_6h festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==1 & north==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==0 & north==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==1 & north==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==0 & north==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==1 & summer==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==0 & summer==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==1 & summer==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_frequency festival weekend if poverty==0 & summer==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
drop e1
qui reghdfe lnOutage_frequency festival weekend if poverty==1 & group==0,  absorb(County#YM) vce(cluster County)  resid
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind,  Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
drop e1
qui reghdfe lnOutage_frequency festival weekend if poverty==0 & group==0,  absorb(County#YM) vce(cluster County)  resid
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind,  Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
drop e1
qui reghdfe lnOutage_frequency festival weekend if poverty==1 & group==1,  absorb(County#YM) vce(cluster County)  resid
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind,  Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
drop e1
qui reghdfe lnOutage_frequency festival weekend if poverty==0 & group==1,  absorb(County#YM) vce(cluster County)  resid
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind,  Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
drop e1
****************************
qui reghdfe lnOutage_duration_unplanned festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration_unplanned festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration_planned festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration_planned festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration_0_6h festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration_0_6h festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration_6h festival weekend if poverty==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration_6h festival weekend if poverty==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==1 & north==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==0 & north==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==1 & north==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==0 & north==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==1 & summer==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==0 & summer==1, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==1 & summer==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
qui reghdfe  lnOutage_duration festival weekend if poverty==0 & summer==0, absorb(County#YM) vce(cluster County) resid
drop e1
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind, Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)

drop e1
qui reghdfe lnOutage_duration festival weekend if poverty==1 & group==0,  absorb(County#YM) vce(cluster County)  resid
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind,  Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
drop e1
qui reghdfe lnOutage_duration festival weekend if poverty==0 & group==0,  absorb(County#YM) vce(cluster County)  resid
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind,  Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
drop e1
qui reghdfe lnOutage_duration festival weekend if poverty==1 & group==1,  absorb(County#YM) vce(cluster County)  resid
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind,  Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
drop e1
qui reghdfe lnOutage_duration festival weekend if poverty==0 & group==1,  absorb(County#YM) vce(cluster County)  resid
qui predict e1, r
qui reg e1 Strong_wind  Rainstorm Strong_wind_Rainstorm Cold_wave Geo_hazard Wildfire Heatwave,r
shapley2,stat(r2) group( Strong_wind,  Rainstorm, Strong_wind_Rainstorm, Cold_wave, Geo_hazard, Wildfire, Heatwave)
drop e1


use decomposition_wind_and_rain,clear
order Strong_wind_Rainstorm Strong_wind_single  Rainstorm_single  Cold_wave Geo_hazard Wildfire Heatwave
*********
graph bar Strong_wind_Rainstorm Strong_wind_single  Rainstorm_single Cold_wave Geo_hazard Wildfire Heatwave if graph ==1, stack over(Vulnerable, gap(*0.2))  over(group, gap(*0.9) sort(sort)) bar(1, fcolor(20 80 130 %40) lcolor(20 80 130 %40) ) ///
bar(2, fcolor(49 130 189 %40) lcolor(49 130 189 %40)) ///
bar(3, fcolor(158 202 225 %40) lcolor(158 202 225 %40) ) ///
bar(4, fcolor(222 235 247 %40) lcolor(222 235 247 %40 )) ///
bar(5, fcolor(248 172 140 %40) lcolor(248 172 140 %40 )) ///
bar(6, fcolor(255 136 132 %40) lcolor(255 136 132 %40)) ///
bar(7, fcolor(230 67 67 %40) lcolor(230 67 67 %40)) ///
ytitle(Variable importance, size(5)) legend(order(7 "Heatwave" 6 "Wildfire" 5 "Geo hazard" 4 "Cold wave" 3 "Str_wind_Rain" 2 "Rain_alone" 1 "Str_wind_alone") pos(3) rows(12) size(4)  symxsize(8) region(lcolor(white)) stack) bargap(0.3)  title("Outage frequency(Shapely values)",size(5)) scheme(plotplain) ylabel(,labsize(*1.3)) graphregion(fcolor(white)) 
graph export "figures1_a.png",  as(png) replace
*********
graph bar Strong_wind_Rainstorm Strong_wind_single  Rainstorm_single Cold_wave Geo_hazard Wildfire Heatwave if graph ==2, stack over(Vulnerable, gap(*0.2))  over(group, gap(*0.9) sort(sort)) bar(1, fcolor(20 80 130 %40) lcolor(20 80 130 %40) ) ///
bar(2, fcolor(49 130 189 %40) lcolor(49 130 189 %40)) ///
bar(3, fcolor(158 202 225 %40) lcolor(158 202 225 %40) ) ///
bar(4, fcolor(222 235 247 %40) lcolor(222 235 247 %40 )) ///
bar(5, fcolor(248 172 140 %40) lcolor(248 172 140 %40 )) ///
bar(6, fcolor(255 136 132 %40) lcolor(255 136 132 %40)) ///
bar(7, fcolor(230 67 67 %40) lcolor(230 67 67 %40)) ///
ytitle(Variable importance, size(5)) legend(order(7 "Heatwave" 6 "Wildfire" 5 "Geo hazard" 4 "Cold wave" 3 "Str_wind_Rain" 2 "Rain_alone" 1 "Str_wind_alone") pos(3) rows(12) size(4)  symxsize(8) region(lcolor(white)) stack) bargap(0.3)  title("Outage duration(Shapely values)",size(5)) scheme(plotplain) ylabel(,labsize(*1.3)) graphregion(fcolor(white)) 
graph export "figures1_b.png",  as(png) replace


