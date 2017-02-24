//import entire survey dataset
//and drop variables not relevant to our study
import delimited ./data/data.csv
drop caseid pumfid_p province region g_cstud g_clfsst gfamtype g_hhsize g_heduc g_hstud cu_q03 cu_q05 cu_q06 cu_g07 cu_q08 cu_q09 cu_q10 cu_q11a cu_q11b cu_q11c cu_q11d cu_q11f cu_11g cu_q12a cu_q12b cu_q12c cu_q12d cu_q12h cu_12g ec_q02a ec_q02b ec_q02c ec_q02d ec_q02e ec_q02f ec_q02g ec_q02h ec_q03 ec_q04a ec_q04b ec_q04c ec_q04d ec_q04e ec_q04f ec_q04g ec_q04h ec_q04i ec_q04j ec_q04k ec_q04l ec_q04m ec_q04n ec_q04o ec_q04p ec_q05a ec_q05b ec_q05c ec_q08 ec_q10a ec_q10b ec_q10c ec_q10d ec_q10e ec_q10f ec_q11 ha_q02a ha_q02b ha_q02c ha_q02d ha_q02g ha_q02h ha_02g ha_q03a ha_q03b ha_q03c ha_q03d ha_q03e ha_q04a ha_q04b ha_q04c ha_q04d ha_q04e ha_q05a ha_q05b ha_q05c ha_q05d ha_q06 ha_q09 su* ps_q01 ps_q03 ps_q04 ps_q05 ps_q06 ps_q07 ps_q09
drop if cu_q01 != 1

//rename to appropriate name
rename wtpp weight
rename csex gender
rename cu_q02 year
rename cu_q04 hours
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
generate urban = 1 if g_urbrur < 5
replace urban = 0 if g_urbrur > 4
drop g_urbrur
//highest achievement is trade college
generate coll = 1 if educ == 2
replace coll = 0 if educ != 2
//highest achievement is university
generate univ = 1 if educ == 3
replace univ = 0 if educ != 3
drop educ

replace numord = 0 if ec_q01 == 2
drop ec_q01 cu_q01

//drop nonrespondants
drop if (sc1==9 & sc2==9 & sc3==9)
drop if (sc1==4 & sc2==9 & sc3==9)
drop if (sc1 == 8 | sc2 == 8 | sc3 == 8)

//if no credit card, set to not concerned
replace sc1 = 1 if sc1 == 4 | sc1 == 7
replace sc1 = sc1 - 1
//not concerned if no opinion
replace sc2 = 2 if sc2 == 7 | sc2 == 9
replace sc2 = 0 if sc2 == 2
//not concerned if experienced no virus
replace sc3 = 2 if sc3 == 6 | sc3 == 7 | sc3 == 9
replace sc3 = 0 if sc3 == 2
//no access if respondant does not know
replace homea = 2 if homea == 8 | homea == 9
replace homea = 0 if homea == 2

//set categorical variable to the mean of the categories
replace income = 18317.5 if income == 1
replace income = 35000 if income == 2
replace income = 57500 if income == 3
replace income = 85000 if income == 4
replace income = 100000 if income == 5

replace age = 20 if age == 1
replace age = 29.5 if age == 2
replace age = 39.5 if age == 3
replace age = 49.5 if age == 4
replace age = 59.5 if age == 5
replace age = 65 if age == 6

replace hour = 2.5 if hour == 1
replace hour = 7 if hour == 2
replace hour = 14.5 if hour == 3
replace hour = 24.5 if hour == 4
replace hour = 34.5 if hour == 5
replace hour = 40 if hour == 6

replace year = 0.5 if year == 1
replace year = 1.5 if year == 2
replace year = 3.5 if year == 3
replace year = 7.5 if year == 4
replace year = 10 if year == 5

//replace the rest of nonrespondants with the average value
egen missingyear = mean(year),by()
replace year = missingyear if year == 7 | year == 8
egen missinghour = mean(hour), by()
replace hours = missinghour if hours == 97 | hours == 98
drop missinghour
drop missingyear

//set to binary, 0 is male
replace gender = gender - 1
