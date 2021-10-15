#load library
install.packages('dplyr')
install.packages('readr')
install.packages('stringr')
install.packages('assertive')
library(ggplot2)
library(dplyr)
library(readr)
library(stringr)
library(assertive)
#read csv
ElectricCar<- read_csv("ElectricCarData_Norm.csv")

glimpse(ElectricCar)
ElectricCar %>% View()
#clean dataset
ElectricCar$Accel <- ElectricCar$Accel %>% str_remove("sec") %>% str_trim() %>% as.numeric()

ElectricCar$TopSpeed <- ElectricCar$TopSpeed %>% str_remove("km/h") %>% str_trim() %>% as.numeric()

ElectricCar$Range <- ElectricCar$TopSpeed %>% str_remove("km") %>% str_trim() %>% as.numeric()

ElectricCar$Efficiency <- ElectricCar$Efficiency %>% str_remove("Wh/km") %>% str_trim() %>% as.numeric()

ElectricCar$FastCharge <- ElectricCar$FastCharge %>% str_remove("km/h")%>% str_trim() %>% as.numeric()
ElectricCar$FastCharge[is.na(ElectricCar$FastCharge)] = 0

ElectricCar$Segment <- ElectricCar$Segment %>% as.factor()

ElectricCar$RapidCharge <- ElectricCar$RapidCharge %>% as.factor()

ElectricCar$PlugType <- ElectricCar$PlugType %>% as.factor()

ElectricCar$BodyStyle <- ElectricCar$BodyStyle %>% as.factor()

ElectricCar$PowerTrain <- ElectricCar$PowerTrain %>% as.factor()

ElectricCar$Brand <- ElectricCar$Brand %>% as.factor()
#export dataset
write.csv(ElectricCar,"ElectricCar_Clean.csv")
# read clean dataset
ElectricCar<- read_csv("ElectricCarData_Clean.csv")

# Analyst

#1
fast_car <- ElectricCar %>% distinct() %>% select(Brand,Model,TopSpeed_KmH) %>% filter(TopSpeed_KmH > mean(TopSpeed_KmH))

#2
fast_car_cheap <- ElectricCar %>% distinct() %>% select(Brand,Model,TopSpeed_KmH,PriceEuro) %>% filter(TopSpeed_KmH > mean(TopSpeed_KmH) & PriceEuro < 60000)

#3
family_car <- ElectricCar %>% distinct() %>% select(Brand,Model, Seats,PriceEuro) %>% filter(Seats > 4 & PriceEuro < 50000)

#4
good_value_car <- ElectricCar %>% distinct() %>% select(Brand,Model,Range_Km,PriceEuro) %>% filter(Range_Km > mean(Range_Km) & PriceEuro < mean(PriceEuro))

#5
energy_saving_car <- ElectricCar %>% distinct() %>% select(Brand,Model,Efficiency_WhKm, Seats,PriceEuro) %>% filter(Seats > 4 & Efficiency_WhKm > mean(Efficiency_WhKm) )
