# Workshop 01 EDA: SAT Scores dataset

Dataset from [SAT_original.csv](https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/SAT_original.csv)

**Created by Thiraphat Itamonchai (ID: 63130500060)**

### My Step
1. Define a question
2. Loading Library and dataset
3. Do It By Step

## Define a question

1. How many observation of this dataset (before cleaning) ?
2. Are there duplicate data sets ? (If have duplicate data, list the data that duplicate)
3. How many distinct school in this dataset ? (Know after drop duplicate data)
4. What is min, max, average, quartile of each part in SAT ?
5. What is min, max, average, quartile of total score in SAT ?
6. Which school is get highest SAT score ?

Can add more question ....

## Step 0: Loading library and dataset

เป็นการ load library ให้สามารถใช้งานได้ และเป็นการ import dataset
```
Library
library(dplyr)
library(assertive)
library(stringr)

Dataset
satscore <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/SAT_original.csv")

```
จากนั้น library เราก็พร้อมใช้งานแล้ว

## Step 1: ดูว่าหลังจากเราเพิ่มข้อมูลจาก csv มาแล้ว มีข้อมูลเท่าไหร่

เราจะใช้คำสั่ง glimpse เพื่อให้สรุป Row และ Column ให้เราดู

```
satscore %>% glimpse()
```

Result:
```
Rows: 485
Columns: 5
$ DBN           <chr> "01M292", "01M448", "01M450", "01M458", "01M509", "01M515", "01M539", "01M65…
$ school_name   <chr> "HENRY STREET SCHOOL FOR INTERNATIONAL STUDIES", "UNIVERSITY NEIGHBORHOOD HI…
$ math_score    <chr> "404", "423", "402", "401", "433", "557", "574", "418", "604", "400", "393",…
$ reading_score <chr> "355", "383", "377", "414", "390", "332", "522", "417", "624", "395", "409",…
$ writing_score <chr> "363", "366", "370", "359", "384", "316", "525", "411", "628", "387", "392",…
```
ก็จะได้คำตอบครับ

## Step 2: ลบข้อมูลที่ซ้ำ
ใช้คำสั่ง distinct เพื่อลบข้อมูลที่ซ้ำกัน
```
satscore <- satscore %>% distinct()

satscore <- satscore %>% distinct()
```
จากนั้นข้อมูลที่ซ้ำก็จะถูกนำออกจาก dataset ของเรา

## Step 3: ดูว่าหลังจากเราลบข้อมูลซ้ำแล้วยังมีข้อมูลอยู่เท่าไหร่

ใช้ glimpse เพื่อดู row กับ column ที่ยังมีอยู่

```
satscore %>% glimpse()
```

Result:

```
Rows: 478
Columns: 5
$ DBN           <chr> "01M292", "01M448", "01M450", "01M458", "01M509", "01M515", "01M539", "01M65…
$ school_name   <chr> "HENRY STREET SCHOOL FOR INTERNATIONAL STUDIES", "UNIVERSITY NEIGHBORHOOD HI…
$ math_score    <chr> "404", "423", "402", "401", "433", "557", "574", "418", "604", "400", "393",…
$ reading_score <chr> "355", "383", "377", "414", "390", "332", "522", "417", "624", "395", "409",…
$ writing_score <chr> "363", "366", "370", "359", "384", "316", "525", "411", "628", "387", "392",…
```
ตอนนี้ขอมูลเราเหลือ 478 row

## Step 4: ล้างข้อมูลคะแนนที่มี s เป็นตัวเลขแทน จากนั้นแปลงข้อมูลให้เป็นตัวเลข
ใช้ str_remove เพื่อที่จะลบข้อมูลที่เป็น s จากนั้นแปลงข้อมูลคะแนนให้เป็นตัวเลขเพื่อที่จะเอาไปใช้ต่อได้ง่าย
```
satscore$math_score <- satscore$math_score %>% str_remove("s") %>% str_trim() 
satscore$reading_score <- satscore$reading_score %>% str_remove("s") %>% str_trim() 
satscore$writing_score <- satscore$writing_score %>% str_remove("s") %>% str_trim()

#แปลงข้อมูลให้เป็น numeric

satscore$math_score <- as.numeric(satscore$math_score)
satscore$reading_score <- as.numeric(satscore$reading_score)
satscore$writing_score <- as.numeric(satscore$writing_score)
```
จากนั้นข้อมูลเราก็จะเป็น numeric แล้ว


## Step 5: ดูว่าหลังจากเราเพิ่มข้อมูลจาก csv มาแล้ว มีข้อมูลเท่าไหร่

เราจะใช้ filter เพื่อกรองให้เหลือข้อมูลที่เราต้องการและเป็นคะแนนที่ถูกต้อง จากนั้นเอาคะแนนไปบวกรวมกันแล้วเก็บไว้ในตัวแปร score_all

```
satscore <- satscore %>% filter(satscore$math_score <= 800 & satscore$math_score >= 200)
satscore <- satscore %>% filter(satscore$reading_score <= 800 & satscore$reading_score >= 200)
satscore <- satscore %>% filter(satscore$writing_score <= 800 & satscore$writing_score >= 200)

score_all <- satscore$math_score + satscore$reading_score + satscore$writing_score
```

ตอนนี้ข้อมูลเราผ่านการกรองมาเรียบร้อยแล้ว และยังได้ตัวแปรอีกตัวแปรนึงมาเตรียมไว้ในการสรุปด้วย

## Step 6: หาข้อมูลเฉลี่ยนในแต่ละวิชาและคะแนน โดยมี max, min, mean

```
min(satscore$math_score , na.rm = TRUE)
min(satscore$reading_score, na.rm = TRUE)
min(satscore$writing_score, na.rm = TRUE)

max(satscore$math_score, na.rm = TRUE)
max(satscore$reading_score, na.rm = TRUE)
max(satscore$writing_score, na.rm = TRUE)

mean(satscore$math_score, na.rm = TRUE)
mean(satscore$reading_score, na.rm = TRUE)
mean(satscore$writing_score, na.rm = TRUE)
```

Result:
```
312
279
286
--------- 
688
636
649
---------
412.9832
400.3942
393.5048
```
โดยเราจะได้ผลลัพธ์เป็นข้อมูลต่างๆแยกตามวิชาออกมาครับ โดยเรียงจาก min, max และ mean
## Step 7: สรุปข้อมูล

โดยนำทุกวิชาของทุกโรงเรียนมารวมกัน จากนั้นมาหาค่าเฉลี่ยและค่าต่างๆตามที่โจทย์ต้องการครับ

```
summary(score_all)
```

Result:

```
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    887    1102    1170    1207    1257    1969 
```

ซึ่งข้อมูลที่ได้ทำมามีผลลัพธ์ที่ค่อนข้างสมเหตุสมผลครับ
