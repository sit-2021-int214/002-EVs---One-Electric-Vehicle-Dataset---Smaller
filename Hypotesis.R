library(dplyr)
library(readr)
library(stringr)
library(assertive)
ElectricCar<- read_csv("https://raw.githubusercontent.com/sit-2021-int214/002-EVs---One-Electric-Vehicle-Dataset---Smaller/main/ElectricCarData_Norm.csv")


#Remove "sec" and change data type of Accel to number.
ElectricCar$Accel <- ElectricCar$Accel %>% str_remove("sec") %>% str_trim() %>% as.numeric()

#Remove "km/h" and change data type of TopSpeed to number.
ElectricCar$TopSpeed <- ElectricCar$TopSpeed %>% str_remove("km/h") %>% str_trim() %>% as.numeric()

#Remove "km" and change data type of Range to number.
ElectricCar$Range <- ElectricCar$Range %>% str_remove("km") %>% str_trim() %>% as.numeric()

#Remove "Wh/km" and change data type of Efficiency to number.
ElectricCar$Efficiency <- ElectricCar$Efficiency %>% str_remove("Wh/km") %>% str_trim() %>% as.numeric()

#Remove "km/h" and change data type of FastCharge to number.
ElectricCar$FastCharge <- ElectricCar$FastCharge %>% str_remove("km/h")%>% str_trim() %>% as.numeric()
#Some data are "NA", Change data that to 0.
ElectricCar$FastCharge[is.na(ElectricCar$FastCharge)] = 0

#Change data type of Segment to factor.
ElectricCar$Segment <- ElectricCar$Segment %>% as.factor()

#Change data type of RapidCharge to factor.
ElectricCar$RapidCharge <- ElectricCar$RapidCharge %>% as.factor()

#Change data type of PlugType to factor.
ElectricCar$PlugType <- ElectricCar$PlugType %>% as.factor()

#Change data type of BodyStyle to factor.
ElectricCar$BodyStyle <- ElectricCar$BodyStyle %>% as.factor()

#Change data type of PowerTrain to factor.
ElectricCar$PowerTrain <- ElectricCar$PowerTrain %>% as.factor()

#Change data type of Brand to factor.
ElectricCar$Brand <- ElectricCar$Brand %>% as.factor()

ElectricCar %>% glimpse()

ElectricCar$Model %>% table()

# Analyst

#1
meanTopSpeed <- ElectricCar$TopSpeed %>% mean(.)
fast_car <- ElectricCar %>% distinct() %>% select(Brand,Model,TopSpeed) %>% filter(TopSpeed > meanTopSpeed)
fast_car

#2
meanTopSpeed <- ElectricCar$TopSpeed %>% mean(.)
fast_car_cheap <- ElectricCar %>% distinct() %>% select(Brand,Model,TopSpeed,PriceEuro) %>% filter(TopSpeed > meanTopSpeed & PriceEuro < 60000)
fast_car_cheap

#3
family_car <- ElectricCar %>% distinct() %>% select(Brand,Model, Seats,PriceEuro) %>% filter(Seats > 4 & PriceEuro < 50000)
family_car %>% View()

#4
meanTopRage <- ElectricCar$Range %>% mean(.)
meanPrice <- ElectricCar$PriceEuro %>% mean(.)
good_value_car <- ElectricCar %>% distinct() %>% select(Brand,Model,Range,PriceEuro) %>% filter(Range > meanTopRage & PriceEuro < meanPrice)
good_value_car

#5
meanEnnergy <- ElectricCar$Efficiency %>% mean(.)
energy_saving_car <- ElectricCar %>% distinct() %>% select(Brand,Model,Efficiency, Seats,PriceEuro) %>% filter(Seats > 4 & Efficiency > meanEnnergy)
energy_saving_car

#Hypothesis Testing
# 1
# Ho : P = 31
# Ha : P != 31

numCar_of_suv <- 45
n<-103
alpha <- 0.1
p0<- 0.4

se_of_p<- sqrt(p0*(1-p0)/n)
p_bar<- numCar_of_suv/n

p_bar #0.44

z<- (p_bar-p0)/se_of_p

z # 0.76

p_value<- pnorm(z)

p_value #0.78

critical_value<- qnorm(0.1/2)

critical_value # -1.64

#P value
if(p_value*2<0.1){
  print("Reject H0")
}else{
  print("Accept H0")
}

#Critical value
if(critical_value>p_value){
  print("Reject H0")
}else{
  print("Accept H0")
}


