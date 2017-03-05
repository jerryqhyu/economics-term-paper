//import entire survey dataset
//and drop variables not relevant to our study
import delimited ./data/data.csv
drop caseid pumfid_p province region g_cstud g_clfsst gfamtype g_hhsize g_heduc g_hstud cu_q03 cu_q05 cu_q06 cu_g07 cu_q08 cu_q09 cu_q10 cu_q11a cu_q11b cu_q11c cu_q11d cu_q11f cu_11g cu_q12a cu_q12b cu_q12c cu_q12d cu_q12h cu_12g ec_q02a ec_q02b ec_q02c ec_q02d ec_q02e ec_q02f ec_q02g ec_q02h ec_q03 ec_q04a ec_q04b ec_q04c ec_q04d ec_q04e ec_q04f ec_q04g ec_q04h ec_q04i ec_q04j ec_q04k ec_q04l ec_q04m ec_q04n ec_q04o ec_q04p ec_q05a ec_q05b ec_q05c ec_q08 ec_q10a ec_q10b ec_q10c ec_q10d ec_q10e ec_q10f ec_q11 ha_q02a ha_q02b ha_q02c ha_q02d ha_q02g ha_q02h ha_02g ha_q03a ha_q03b ha_q03c ha_q03d ha_q03e ha_q04a ha_q04b ha_q04c ha_q04d ha_q04e ha_q05a ha_q05b ha_q05c ha_q05d ha_q06 ha_q09 su* ps_q01 ps_q03 ps_q04 ps_q05 ps_q06 ps_q07 ps_q09

//rename to appropriate name
rename wtpp weight
rename csex gender
rename g_urbrur urbanstatus
rename cu_q01 isuser
rename cu_q02 year
rename cu_q04 hours
rename ec_q01 isshopper
rename ec_q06 numord
rename ha_q01 homea
rename gcagegr6 age
rename g_ceduc educ
rename g_hquint income
rename ps_q02 sc1
rename ps_q08 sc2
rename ps_q10 sc3

//generate dummy variables
//if the respondant is of urban origin
generate urban = 1 if urbanstatus < 5
replace urban = 0 if urbanstatus > 4
//highest achievement is trade college
generate coll = 1 if educ == 2
replace coll = 0 if educ != 2
//highest achievement is university
generate univ = 1 if educ == 3
replace univ = 0 if educ != 3
//drop observations not concerned with the study
drop if isuser != 1
replace numord = 0 if isshopper == 2

//no longer useful variables
drop isuser
drop isshopper
drop urbanstatus
drop educ

//drop nonrespondants
drop if (sc1==9 | sc2==9 | sc3==9)
drop if (sc1 == 8 | sc2 == 8 | sc3 == 8)

//if no credit card, set to not concerned
replace sc1 = 1 if sc1 == 4 | sc1 == 7
replace sc1 = sc1 - 1
//not concerned if no opinion
replace sc2 = 0 if sc2 == 7 | sc2 == 9 | sc2 == 2
//not concerned if experienced no virus
replace sc3 = 0 if sc3 == 6 | sc3 == 7 | sc3 == 9 | sc3 == 2
//no access if respondant does not know
replace homea = 0 if homea == 8 | homea == 9 | homea == 2

tabulate income, generate(incomeD)
tabulate age, generate(ageD)
tabulate hour, generate(hourD)
tabulate year, generate(yearD)
drop hourD7 hourD8 yearD6 yearD7 year hours age income
drop if numord > 365

drop if (incomeD1 == 0 & incomeD2 == 0 & incomeD3 == 0 & incomeD4 == 0 & incomeD5 == 0)
drop if (hourD1 == 0 & hourD2 == 0 & hourD3 == 0 & hourD4 == 0 & hourD5 == 0 & hourD6 == 0)
drop if (yearD1 == 0 & yearD2 == 0 & yearD3 == 0 & yearD4 == 0 & yearD5 == 0)
drop if (ageD1 == 0 & ageD2 == 0 & ageD3 == 0 & ageD4 == 0 & ageD5 == 0 & ageD6 == 0)

//set to binary, 0 is male
replace gender = gender - 1
