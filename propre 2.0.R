## Import and rename the data base, rename MM##

MM <- read.csv("hcud-sample25-edu2.csv")

##View of the Size##
View   (MM)
str    (MM)

###                         1. For All_indiduals                          ###

## Calculation of the unemployment rate for the entire population.Creation of 2 new columns :
## + Poptot          = Total Population
## + TxchôAll        = Unemployement Rate for total population 
## All_individuals   = All_individuals_Employed
## All_indivuduals.1 = All_individuals_Unemployed
## All_individuals.2 = All_individuals_ST_Unemployed
## All_individuals.3 = All_indivuduals_Ratio

attach (MM)
MM$Poptot   = All_individuals+All_individuals.1
MM$TxchôAll = ((MM$All_individuals.1/MM$Poptot)*100)

## Now we want to recreate the serie All_individuals_ST_employed because of the redesign of CPS in january 1994(discotinuty ST)   ##
## To recreate the serie we will find the mean of All_individuals_Ratio starting from february 1994 (218) to the end 2015 (469)   ##
## After that we create a new columns which contains the same data as the columns All_individuals_ST_unemployed until january     ##
## 1994, and after that point the columns contain the multiplication of All_individuals_ST_unemployed and the mean find up        ## 

Ratious                   <- mean(MM$All_individuals.3 [218:469])
print(Ratious)
MM$Unemployed_ST1         <- c(MM$All_individuals.2[-1], NA)
MM$Unemployed_ST1 [1]     <- MM$All_individuals.2 [2]
MM$Unemployed_ST1[217:469]<- MM$Unemployed_ST [217:469]*Ratious     

## Now we can easily use the formule of the monthly outflow probability, Ft = 1-(U(t+1)-Us(t+1))*Ut, us(t+1)=Unemployement_ST1     ##
## We wil create a new columns that will name Ut1, to create an offsett and then multiply with the Ut=All_individuals_Unemployed##

MM$Ut1                    <- c(MM$All_individuals.1[-1],NA)
MM$Ut1[1]                 <- MM$All_individuals.1 [2]
MM$Ft           = 1-(MM$Ut1-MM$Unemployed_ST1)/MM$All_individuals.1

## Now we apply the formula for finding the hazard rate ft= -log(1-Ft)

MM$ft           = -log(1-MM$Ft)

###                          2.Less_than_High_school                       ###

##Calculation of the unemployment rate for people with less than a High school education.Creation of 2 new columns :
## + MM$PoptotLh         = Total of people who have less than high school level
## + MM$TxchôLH          = Unemployement rate for the less than high school
## Less_than_High_School = Less_than_High_School_Employed
## Less_than_High_School.1 = Less_than_High_School_Unemployed
## Less_than_High_School.2 = Less_than_High_School_ST_Unemployed
## Less_than_High_School.3 = Les_than_High_School_Ratio


attach(MM)
MM$PoptotLh     = Less_than_high_school + Less_than_high_school.1
MM$TxchôLH      = (Less_than_high_school.1/MM$PoptotLh)*100


## As we already say before now we will recreate the serie Less_than_Highs_school_ST_Unemployed, so we will find the mean of the    ##
## the serie Less_than_High_school_Ratio from february (1994) to the end 2015.After that we create a new columns which contains the ##
## same data as the columns Less_than_High_School_ST_Unemployed until january 1994, and after that point the columns contain the    ##
## multiplication of Less_than_High_School_ST_Unemployed and the mean find . That the naw columns will be named UST1_LH, that       ##
## correspond to the name of Unemployement_Short_Term_(T+1)_Less_High_school.UST1_LH=Unemployement_Short_Term_(T+1)_Less_High_school##

RatioUS_LH               <-mean(MM$Less_than_high_school.3 [218:469])
print(RatioUS_LH)
MM$UST1_LH               <- c(MM$Less_than_high_school.2[-1],NA)    
MM$UST1_LH [1]           <- MM$Less_than_high_school.2 [2]
MM$UST1_LH [217:469]     <- MM$UST1_LH [217:469]*RatioUS_LH


## Now we can easily use the formule of the monthly outflow probability, Ft_LH = 1-(U_LH.t.1-UST1_LH)*U_LH,Calculation explanation ##
## U_LH=Less_than_High_School_Unemployed, UST1_LH=Unemployement_Short_Term_(T+1)_Less_High_school and U_LH.t1 it's a new columns  ##
## wich includes the same date as Less_than_High_School_Unemployed but with an offset that wich will allow the calculation          ##

MM$U_LH.t1            <- c(MM$Less_than_high_school.1 [-1],NA)
MM$U_LH.t1 [1]        <- MM$Less_than_high_school.1[2]
MM$Ft_LH        = 1-(MM$U_LH.t1-MM$UST1_LH)/MM$Less_than_high_school.1


## Now we apply the formula to find the hazard rate ft_LH = -log(1-Ft_LH)


MM$ft_LH        = -log(1-MM$Ft_LH)


###                         3. High_School                                ###

##This is the same stape for this level off education 
## + MM$PoptotH = Total of people who have graduated from high school 
## + MM$TxchôHS = Unemployement rate fot the High school 
## High_school  = High_school_Employement
## High-school.1= High_school_Unemployement
## High_school.2= High_school_ST_Unemployement
## High_school.3= High_school_Ratio

MM$PoptotH      = High_school + High_school.1
MM$TxchôHS      = (MM$High_school.1/MM$PoptotH)*100 


## Same recreation of this serie short term Unmeployement for High_school, first calcul of the mean between 1994 to 2015 and  after ## 
## recreation of the serie that we will name MM$UST1_HS (UST1_HS = Unemployement_Short_Term_(T+1)_High_school), we will do an offset## 

RatioUS_HS              <- mean(MM$High_school.3 [218:469])
print(RatioUS_HS)
MM$UST1_HS              <- c(MM$High_school.2 [-1],NA)
MM$UST1_HS[1]           <- MM$High_school.2 [2]
MM$UST1_HS[217:469]     <- MM$UST1_HS [217:469]*RatioUS_HS

## Same as the part for Less_Than_High_school, we create a new serie name U_HS.t1(=Unemployement_Short_Term_(T+1))to create an offset##

MM$U_HS.t1              <- c(MM$High_school.1 [-1],NA)
MM$U_HS.t1 [1]          <- MM$High_school.1[2]
MM$Ft_HS        =1-(MM$U_HS.t1-MM$UST1_HS)/MM$High_school.1

## Now we apply the formula to find the hazard rate ft_HS=-log(1-Ft_HS)


MM$ft_HS        =-log(1-MM$Ft_HS)


###                   3. Some College                                      ###

## The same steps as before 
## + MM$PoptotSC = Total of people who have do some college 
## + MM$TxchôSC  = Unemployed rate for individuals who have do some college 
## Some_college  = Some_College_Employed 
## Some_College.1= Some_College_Unemployed
## Some_College.2= Some_College_ST_Unemployed
## Some_College.3= Some_College_Ratio 



MM$PoptotSC     = MM$Some_college + MM$Some_college.1
MM$TxchôSC      = (MM$Some_college.1/MM$PoptotSC)*100



## Recreation of the serie, same stape as before  


RatioUS_SC           <- mean(MM$Some_college.3[218:469])
print(RatioUS_SC)
MM$UST1_SC           <- c(MM$Some_college.2[-1],NA)
MM$UST1_SC[1]        <- MM$Some_college.2 [2]
MM$UST1_SC [217:469] <- MM$UST1_SC [217:469]*RatioUS_SC



## Same utilization of the formula 


MM$U_SC.t1          <- c(MM$Some_college.1[-1],NA)
MM$U_SC.t1[1]       <- MM$Some_college.1 [2]
MM$Ft_SC        = 1-(MM$U_SC.t1-MM$UST1_SC)/MM$Some_college.1


## Apply the same formula to find the Hazard rate 


MM$ft_SC        = -log(1-MM$Ft_SC)




###                  4.College                                             ###



## The same steps as before 
## + MM$PoptotC = Total of people who habe been gratuated from College 
## + MM$TxchôC  = Unemployed rate for individuals with a college degre 
## College      = College_Employed 
## College.1    = College_Unemployed
## College.2    = College_ST 
## College.3    = College_Ratio 


MM$PoptotC      = MM$College + MM$College.1
MM$TxchôC       = (MM$College.1/MM$PoptotC)*100



## Recreation of the seris, same step as before


RatioUS_C          <- mean(MM$College.3 [218:469])
print(RatioUS_C)
MM$UST1_C          <- c(MM$College.2[-1],NA)
MM$UST1_C[1]       <- MM$College.2 [2]
MM$UST1_C [217:469]<- MM$UST1_C[217:469]*RatioUS_C



## Same utilization of the formula

MM$U_C.t1           <- c(MM$College.1[-1],NA)
MM$U_C.t1[1]        <- MM$College.1 [2]
MM$Ft_C             = 1-(MM$U_C.t1-MM$UST1_C)/MM$College.1



## Apply the same formula to find the hazard rate 

MM$ft_C             =  -log(1-MM$Ft_C)


