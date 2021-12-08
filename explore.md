# EVs - One Electric Vehicle Dataset - Smaller
Dataset from : https://raw.githubusercontent.com/sit-2021-int214/002-EVs---One-Electric-Vehicle-Dataset---Smaller/main/ElectricCarData_Norm.csv (Not clean)

Dataset from : https://raw.githubusercontent.com/sit-2021-int214/002-EVs---One-Electric-Vehicle-Dataset---Smaller/main/ElectricCar_Clean.csv (Clean)

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
#### Answer: ค่าเฉลี่ยของความเร็วสูงสุดของรถยนต์ไฟฟฟ้าอยู่ที่ 179 Km/Hr รายชื่อรถยนต์ไฟฟ้ายี่ห้อและโมเดลที่มีความเร็วสูงสุดมากกว่าค่าเฉลี่ยของรถยนต์ไฟฟ้าทั้งหมด (รถที่เร็วกว่ายี่ห้ออื่นๆทั่วไป)
```{R}
# A tibble: 46 x 3
   Brand    Model                         TopSpeed
   <fct>    <chr>                            <dbl>
 1 Tesla    Model 3 Long Range Dual Motor      233
 2 Polestar 2                                  210
 3 BMW      iX3                                180
 4 Lucid    Air                                250
 5 Tesla    Model 3 Standard Range Plus        225
 6 Audi     Q4 e-tron                          180
 7 Mercedes EQC 400 4MATIC                     180
 8 BMW      i4                                 200
 9 Porsche  Taycan Turbo S                     260
10 Tesla    Model Y Long Range Dual Motor      217
# ... with 36 more rows
```

### 2. รถยนต์ไฟฟ้ายี่ห้อและโมเดลไหนที่มีความเร็วสูงสุดมากกว่าค่าเฉลี่ยของรถยนต์ไฟฟ้าทั้งหมด และมีราคาน้อยกว่า 60000 ยูโร
### Solve:
```{R}
meanTopSpeed <- ElectricCar$TopSpeed %>% mean(.)
fast_car_cheap <- ElectricCar %>% distinct() %>% select(Brand,Model,TopSpeed,PriceEuro) %>% filter(TopSpeed > meanTopSpeed & PriceEuro < 60000)
```
#### Answer: ค่าเฉลี่ยของความเร็วสูงสุดของรถยนต์ไฟฟฟ้าอยู่ที่ 179 Km/Hr รายชื่อรถยนต์ไฟฟ้ายี่ห้อและโมเดลไหนที่มีความเร็วสูงสุดมากกว่าค่าเฉลี่ยของรถยนต์ไฟฟ้าทั้งหมด และมีราคาน้อยกว่า 60000 ยูโร (รถเร็วที่ราคาถูก)
```{R}
# A tibble: 16 x 4
   Brand    Model                         TopSpeed PriceEuro
   <fct>    <chr>                            <dbl>     <dbl>
 1 Tesla    Model 3 Long Range Dual Motor      233     55480
 2 Polestar 2                                  210     56440
 3 Tesla    Model 3 Standard Range Plus        225     46380
 4 Audi     Q4 e-tron                          180     55000
 5 Tesla    Model Y Long Range Dual Motor      217     58620
 6 Mercedes EQA                                200     45000
 7 Ford     Mustang Mach-E ER RWD              180     54475
 8 Tesla    Cybertruck Dual Motor              190     55000
 9 Audi     Q4 Sportback e-tron                180     57500
10 Ford     Mustang Mach-E SR AWD              180     54000
11 Ford     Mustang Mach-E SR RWD              180     46900
12 Tesla    Cybertruck Single Motor            180     45000
13 Skoda    Enyaq iV vRS                       180     47500
14 Nissan   Ariya e-4ORCE 87kWh                200     57500
15 Byton    M-Byte 72 kWh 2WD                  190     53500
16 Nissan   Ariya e-4ORCE 63kWh                200     50000
```

### 3. รถยนต์ไฟฟ้ายี่ห้อและโมเดลไหนที่มีที่นั่งมากกว่า 4 ที่นั่งและราคาน้อยกว่า 50000 ยูโร
### Solve:
```{R}
family_car <- ElectricCar %>% distinct() %>% select(Brand,Model, Seats,PriceEuro) %>% filter(Seats > 4 & PriceEuro < 50000)
```
#### Answer: รายชื่อรถยนต์ไฟฟ้ายี่ห้อและโมเดลไหนที่มีที่นั่งมากกว่า 4 ที่นั่งและราคาน้อยกว่า 50000 ยูโร (รถสำหรับครอบครัวและราคาคุ้มค่า)
```{R}
# A tibble: 42 x 4
   Brand      Model                       Seats PriceEuro
   <fct>      <chr>                       <dbl>     <dbl>
 1 Volkswagen ID.3 Pure                       5     30000
 2 Volkswagen e-Golf                          5     31900
 3 Peugeot    e-208                           5     29682
 4 Tesla      Model 3 Standard Range Plus     5     46380
 5 Nissan     Leaf                            5     29234
 6 Hyundai    Kona Electric 64 kWh            5     40795
 7 Hyundai    IONIQ Electric                  5     34459
 8 MG         ZS EV                           5     30000
 9 Opel       Corsa-e                         5     29146
10 Skoda      Enyaq iV 50                     5     35000
# ... with 32 more rows
```

### 4. รถยนต์ที่ชาร์จไฟฟ้าหนึ่งครั้งแล้ววิ่งได้มากกว่าค่าเฉลี่ยของรถยนต์ไฟฟ้าทั้งหมดโดยมีราคาต่ำกว่าค่าเฉลี่ยทั้งหมด
### Solve:
```{R}
meanTopRage <- ElectricCar$Range %>% mean(.)
meanPrice <- ElectricCar$PriceEuro %>% mean(.)
good_value_car <- ElectricCar %>% distinct() %>% select(Brand,Model,Range,PriceEuro) %>% filter(Range > meanTopRage & PriceEuro < meanPrice)
```
#### Answer: ค่าเฉลี่ยของการวิ่งได้มากที่สุดของรถยนต์ไฟฟ้าและราคาของรถยนต์ไฟฟฟ้าอยู่ที่ 338 Km และ 55811 ยูโร ตามลำดับ ยี่ห้อและรุ่นที่ชาร์จไฟฟ้าหนึ่งครั้งแล้ววิ่งได้มากกว่าค่าเฉลี่ยของรถยนต์ไฟฟ้าทั้งหมดโดยมีราคาต่ำกว่าค่าเฉลี่ยทั้งหมด (รถที่คุ้มค่าวิ่งได้ไกลและมีราคาไม่แพง) มีดังนี้
```{R}
# A tibble: 22 x 4
   Brand      Model                         Range PriceEuro
   <fct>      <chr>                         <dbl>     <dbl>
 1 Tesla      Model 3 Long Range Dual Motor   450     55480
 2 Audi       Q4 e-tron                       400     55000
 3 Hyundai    Kona Electric 64 kWh            400     40795
 4 Volkswagen ID.3 Pro S                      440     40936
 5 Volkswagen ID.4                            420     45000
 6 Volkswagen ID.3 Pro                        350     33000
 7 Kia        e-Niro 64 kWh                   370     38105
 8 CUPRA      el-Born                         425     45000
 9 Mercedes   EQA                             350     45000
10 Kia        e-Soul 64 kWh                   365     36837
# ... with 12 more rows
```

### 5. รถยนต์ไฟฟ้าที่ประหยัดไฟมากกว่าค่าเฉลี่ยของรถยนต์คันอื่นและมีที่นั่งมากกว่า 4
### Solve:
```{R}
meanEnnergy <- ElectricCar$Efficiency %>% mean(.)
energy_saving_car <- ElectricCar %>% distinct() %>% select(Brand,Model,Efficiency, Seats,PriceEuro) %>% filter(Seats > 4 & Efficiency > meanEnnergy)
```
#### Answer: ค่าเฉลี่ยของรถยนต์ไฟฟ้าที่ประหยัดไฟอยู่ที่ 189 Wh/Km ยี่ห้อและรุ่นที่ประหยัดไฟมากกว่าค่าเฉลี่ยของคันอื่นและมีที่นั่งมากกว่า 4 มีลิสต์ดังนี้ (รถที่ประหยัดไฟและนั่งได้หลายคน)
```{R}
# A tibble: 35 x 5
   Brand    Model                       Efficiency Seats PriceEuro
   <fct>    <chr>                            <dbl> <dbl>     <dbl>
 1 BMW      iX3                                206     5     68040
 2 Audi     Q4 e-tron                          193     5     55000
 3 Mercedes EQC 400 4MATIC                     216     5     69484
 4 MG       ZS EV                              193     5     30000
 5 Volvo    XC40 P8 AWD Recharge               200     5     60437
 6 Audi     e-tron 50 quattro                  231     5     67358
 7 Tesla    Cybertruck Tri Motor               267     6     75000
 8 Lexus    UX 300e                            193     5     50000
 9 Audi     e-tron Sportback 55 quattro        228     5     81639
10 Audi     e-tron 55 quattro                  237     5     79445
# ... with 25 more rows
```

