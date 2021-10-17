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

# Analyst

#1
meanTopSpeed <- ElectricCar$TopSpeed %>% mean(.)
fast_car <- ElectricCar %>% distinct() %>% select(Brand,Model,TopSpeed) %>% filter(TopSpeed > meanTopSpeed)

#2
meanTopSpeed <- ElectricCar$TopSpeed %>% mean(.)
fast_car_cheap <- ElectricCar %>% distinct() %>% select(Brand,Model,TopSpeed,PriceEuro) %>% filter(TopSpeed > meanTopSpeed & PriceEuro < 60000)

#3
family_car <- ElectricCar %>% distinct() %>% select(Brand,Model, Seats,PriceEuro) %>% filter(Seats > 4 & PriceEuro < 50000)

#4
meanTopRage <- ElectricCar$Range %>% mean(.)
meanPrice <- ElectricCar$PriceEuro %>% mean(.)
good_value_car <- ElectricCar %>% distinct() %>% select(Brand,Model,Range,PriceEuro) %>% filter(Range > meanTopRage & PriceEuro < meanPrice)

#5
meanEnnergy <- ElectricCar$Efficiency %>% mean(.)
energy_saving_car <- ElectricCar %>% distinct() %>% select(Brand,Model,Efficiency, Seats,PriceEuro) %>% filter(Seats > 4 & Efficiency > meanEnnergy)

