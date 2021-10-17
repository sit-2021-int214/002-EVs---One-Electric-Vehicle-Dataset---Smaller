# EVs - One Electric Vehicle Dataset - Smaller
Dataset from : https://raw.githubusercontent.com/sit-2021-int214/002-EVs---One-Electric-Vehicle-Dataset---Smaller/main/ElectricCarData_Norm.csv (Not clean)

Dataset from : https://raw.githubusercontent.com/sit-2021-int214/002-EVs---One-Electric-Vehicle-Dataset---Smaller/main/ElectricCarData_Clean.csv (Clean)

## My Step
1. Define a question
2. Search datasets from Kaggle
3. Download Library and dataset
4. Explore the dataset from the original dataset
5. Cleaning Dataset
6. Exploratory Data Analysis

# Defind a question
1. รถยนต์ไฟฟ้ายี่ห้อและโมเดลไหนที่มีความเร็วสูงสุดมากกว่าค่าเฉลี่ยของรถยนต์ไฟฟ้าทั้งหมด
2. รถยนต์ไฟฟ้ายี่ห้อและโมเดลไหนที่มีความเร็วสูงสุดมากกว่าค่าเฉลี่ยของรถยนต์ไฟฟ้าทั้งหมด และมีราคาน้อยกว่า 60000 ยูโร
3. รถยนต์ไฟฟ้ายี่ห้อและโมเดลไหนที่มีที่นั่งมากกว่า 4 ที่นั่งและราคาน้อยกว่า 50000 ยูโร
4. รถยนต์ที่ชาร์จไฟฟ้าหนึ่งครั้งแล้ววิ่งได้มากกว่าค่าเฉลี่ยของรถยนต์ไฟฟ้าทั้งหมดโดยมีราคาต่ำกว่าค่าเฉลี่ยทั้งหมด
5. รถยนต์ไฟฟ้าที่ประหยัดไฟมากกว่าค่าเฉลี่ยของรถยนต์คันอื่นและมีที่นั่งมากกว่า 4

# Step 0 Clean data
ก่อนที่จะเริ่มทำโจทย์ต้องตรวจเช็คข้อมูลที่ได้มาก่อน โดยการเอาข้อมูลที่ได้มา Clean เพื่อตอนทำคำถามจะได้ผิดพลาดน้อยที่สุด
```{R}
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
```

# Step 0 Examining your data prior to further exploration.
```{R}
ElectricCar %>% glimpse()
```

เมื่อ clean ข้อมูลเสร็จแล้ว เราสามารถใช้ glimpse function ในการเรียกดูข้อมูลของเราได้

Result:
```{R}
Rows: 103
Columns: 14
$ Brand       <fct> Tesla, Volkswagen, Polestar, BMW, Honda, Lucid, Volkswagen, Peugeot, Tesl~
$ Model       <chr> "Model 3 Long Range Dual Motor", "ID.3 Pure", "2", "iX3", "e", "Air", "e-~
$ Accel       <dbl> 4.6, 10.0, 4.7, 6.8, 9.5, 2.8, 9.6, 8.1, 5.6, 6.3, 5.1, 7.9, 7.9, 4.0, 9.~
$ TopSpeed    <dbl> 233, 160, 210, 180, 145, 250, 150, 150, 225, 180, 180, 144, 167, 200, 165~
$ Range       <dbl> 450, 270, 400, 360, 170, 610, 190, 275, 310, 400, 370, 220, 400, 450, 250~
$ Efficiency  <dbl> 161, 167, 181, 206, 168, 180, 168, 164, 153, 193, 216, 164, 160, 178, 153~
$ FastCharge  <dbl> 940, 250, 620, 560, 190, 620, 220, 420, 650, 540, 440, 230, 380, 650, 210~
$ RapidCharge <fct> Rapid charging possible, Rapid charging possible, Rapid charging possible~
$ PowerTrain  <fct> All Wheel Drive, Rear Wheel Drive, All Wheel Drive, Rear Wheel Drive, Rea~
$ PlugType    <fct> Type 2 CCS, Type 2 CCS, Type 2 CCS, Type 2 CCS, Type 2 CCS, Type 2 CCS, T~
$ BodyStyle   <fct> Sedan, Hatchback, Liftback, SUV, Hatchback, Sedan, Hatchback, Hatchback, ~
$ Segment     <fct> D, C, D, D, B, F, C, B, D, D, D, C, B, D, C, C, F, A, B, B, B, D, C, F, D~
$ Seats       <dbl> 5, 5, 5, 5, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 4, 4, 5, 4, 5, 7, 5, 4, 5~
$ PriceEuro   <dbl> 55480, 30000, 56440, 68040, 32997, 105000, 31900, 29682, 46380, 55000, 69~****
```


# Step 1 Loading library and dataset
```{R}
library(dplyr)
library(readr)
library(stringr)
library(assertive)
ElectricCar<- read_csv("https://raw.githubusercontent.com/sit-2021-int214/002-EVs---One-Electric-Vehicle-Dataset---Smaller/main/ElectricCarData_Norm.csv")
```

# Step 2 Answer your question.
## 1. รถยนต์ไฟฟ้ายี่ห้อและโมเดลไหนที่มีความเร็วสูงสุดมากกว่าค่าเฉลี่ยของรถยนต์ไฟฟ้าทั้งหมด
### Solve:
```{R}
meanTopSpeed <- ElectricCar$TopSpeed %>% mean(.)
fast_car <- ElectricCar %>% distinct() %>% select(Brand,Model,TopSpeed) %>% filter(TopSpeed > meanTopSpeed)
```
#### Answer: 
```{R}
```

### 2. รถยนต์ไฟฟ้ายี่ห้อและโมเดลไหนที่มีความเร็วสูงสุดมากกว่าค่าเฉลี่ยของรถยนต์ไฟฟ้าทั้งหมด และมีราคาน้อยกว่า 60000 ยูโร
### Solve:
```{R}
meanTopSpeed <- ElectricCar$TopSpeed %>% mean(.)
fast_car_cheap <- ElectricCar %>% distinct() %>% select(Brand,Model,TopSpeed,PriceEuro) %>% filter(TopSpeed > meanTopSpeed & PriceEuro < 60000)
```
#### Answer: 
```{R}                                                        
```

### 3. รถยนต์ไฟฟ้ายี่ห้อและโมเดลไหนที่มีที่นั่งมากกว่า 4 ที่นั่งและราคาน้อยกว่า 50000 ยูโร
### Solve:
```{R}
family_car <- ElectricCar %>% distinct() %>% select(Brand,Model, Seats,PriceEuro) %>% filter(Seats > 4 & PriceEuro < 50000)
```
#### Answer:
```{R}
```

### 4. รถยนต์ที่ชาร์จไฟฟ้าหนึ่งครั้งแล้ววิ่งได้มากกว่าค่าเฉลี่ยของรถยนต์ไฟฟ้าทั้งหมดโดยมีราคาต่ำกว่าค่าเฉลี่ยทั้งหมด
### Solve:
```{R}
meanTopRage <- ElectricCar$Range %>% mean(.)
meanPrice <- ElectricCar$PriceEuro %>% mean(.)
good_value_car <- ElectricCar %>% distinct() %>% select(Brand,Model,Range,PriceEuro) %>% filter(Range > meanTopRage & PriceEuro < meanPrice)
```
#### Answer:
```{R}
```

### 5. รถยนต์ไฟฟ้าที่ประหยัดไฟมากกว่าค่าเฉลี่ยของรถยนต์คันอื่นและมีที่นั่งมากกว่า 4
### Solve:
```{R}
meanEnnergy <- ElectricCar$Efficiency %>% mean(.)
energy_saving_car <- ElectricCar %>% distinct() %>% select(Brand,Model,Efficiency, Seats,PriceEuro) %>% filter(Seats > 4 & Efficiency > meanEnnergy)
```
#### Answer:
```{R}
```

