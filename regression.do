//OLS code
disp "OLS regression"
reg numord sc1 hhsize female employed homea weight urban coll univ incomeD2 incomeD3 incomeD4 incomeD5 ageD2 ageD3 ageD4 ageD5 ageD6 hourD2 hourD3 hourD4 hourD5 hourD6 yearD2 yearD3 yearD4 yearD5 [pweight=weight], robust

//functional form code
gen sageD2 = sc1 * ageD2
gen sageD3 = sc1 * ageD3
gen sageD4 = sc1 * ageD4
gen sageD5 = sc1 * ageD5
gen sageD6 = sc1 * ageD6
gen syearD2 = sc1 * yearD2
gen syearD3 = sc1 * yearD3
gen syearD4 = sc1 * yearD4
gen syearD5 = sc1 * yearD5
gen sincomeD2 = sc1*incomeD2
gen sincomeD3 = sc1*incomeD3
gen sincomeD4 = sc1*incomeD4
gen sincomeD5 = sc1*incomeD5
gen scoll = sc1*coll
gen suniv = sc1*univ
gen shourD2 = sc1*hourD2
gen shourD3 = sc1*hourD3
gen shourD4 = sc1*hourD4
gen shourD5 = sc1*hourD5
gen shourD6 = sc1*hourD6
regress numord sc1 female employed hhsize homea urban coll univ scoll suniv incomeD2 incomeD3 incomeD4 incomeD5 sincomeD2 sincomeD3 sincomeD4 sincomeD5 ageD2 ageD3 ageD4 ageD5 ageD6 sageD2 sageD3 sageD4 sageD5 sageD6 hourD2 hourD3 hourD4 hourD5 hourD6 shourD2 shourD3 shourD4 shourD5 shourD6 yearD2 yearD3 yearD4 yearD5 syearD2 syearD3 syearD4 syearD5 [pweight=weight], robust

//2SLS code
disp "2SLS regression"
reg sc1 cbanking bsoft hhsize female employed homea weight urban coll univ incomeD2 incomeD3 incomeD4 incomeD5 ageD2 ageD3 ageD4 ageD5 ageD6 hourD2 hourD3 hourD4 hourD5 hourD6 yearD2 yearD3 yearD4 yearD5 [pweight=weight]
predict sc1hat
reg numord sc1 hhsize female employed homea weight urban coll univ incomeD2 incomeD3 incomeD4 incomeD5 ageD2 ageD3 ageD4 ageD5 ageD6 hourD2 hourD3 hourD4 hourD5 hourD6 yearD2 yearD3 yearD4 yearD5 [pweight=weight], robust

//heteroskedasticity code
reg numord sc1hat female employed hhsize homea urban coll univ incomeD2 incomeD3 incomeD4 incomeD5 ageD2 ageD3 ageD4 ageD5 ageD6 hourD2 hourD3 hourD4 hourD5 hourD6 yearD2 yearD3 yearD4 yearD5 [pweight=weight]
predict uhat, res
gen uhatsq = uhat^2
regress uhatsq sc1hat female employed hhsize homea urban coll univ incomeD2 incomeD3 incomeD4 incomeD5 ageD2 ageD3 ageD4 ageD5 ageD6 hourD2 hourD3 hourD4 hourD5 hourD6 yearD2 yearD3 yearD4 yearD5 [pweight=weight]
scalar LM = e(r2)*e(N)
scalar pvalue = chi2tail(e(df_m),LM)
disp "Breusch-Pagan test: LM = " LM ", p-value = " pvalue
