# R-Assignment 4

**Created by Thiraphat Itamonchai(ID: 63130500060)**

Choose Dataset:
1. Top 270 Computer Science / Programing Books (Data from Thomas Konstantin, [Kaggle](https://www.kaggle.com/thomaskonstantin/top-270-rated-computer-science-programing-books)) >> [Using CSV](https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv)


### Outlines
1. Explore the dataset
2. Learning function from Tidyverse
3. Transform data with dplyr and finding insight the data
4. Visualization with GGplot2

## Part 1: Explore the dataset

```
# Dataset
programming_book <- read.csv('https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv')

```

In this dataset has
```
#library
library(dplyr)
library(readr)
#show data type each columns
glimpse(programming_book)
```
```
Rows: 271
Columns: 7
$ Rating          <dbl> 4.17, 4.01, 3.33, 3.97, 4.06, 3.84, 4.09, 4.15, 3.87, 4.62, 4.03, 3.78, 3.…
$ Reviews         <chr> "3,829", "1,406", "0", "1,658", "1,325", "117", "5,938", "1,817", "2,093",…
$ Book_title      <chr> "The Elements of Style", "The Information: A History, a Theory, a Flood", …
$ Description     <chr> "This style manual offers practical advice on improving writing skills. Th…
$ Number_Of_Pages <int> 105, 527, 50, 393, 305, 288, 256, 368, 259, 128, 352, 352, 200, 328, 240, …
$ Type            <chr> "Hardcover", "Hardcover", "Kindle Edition", "Hardcover", "Kindle Edition",…
$ Price           <dbl> 9.323529, 11.000000, 11.267647, 12.873529, 13.164706, 14.188235, 14.232353…
```
- Rating : คะแนนหนังสือ
- Reviews : จำนวนความคิดเห็น
- Book_title : ชื่อหนังสือ
- Description : คำอธิบาย
- Number_Of_Pages : จำนวนของหนังสือ
- Type : รูปแบบหนังสือ
- Price : ราคาหนังสือ

1. สรุปข้อมูลเบื้องต้น
```
programming_book %>% select(-Type , -Book_title , -Description , -Reviews) %>% summary()
```
Result :
```
  Rating      Number_Of_Pages      Price        
 Min.   :3.000   Min.   :  50.0   Min.   :  9.324  
 1st Qu.:3.915   1st Qu.: 289.0   1st Qu.: 30.751  
 Median :4.100   Median : 384.0   Median : 46.318  
 Mean   :4.067   Mean   : 475.1   Mean   : 54.542  
 3rd Qu.:4.250   3rd Qu.: 572.5   3rd Qu.: 67.854  
 Max.   :5.000   Max.   :3168.0   Max.   :235.650 
```
## Part 2: Learning function from Tidyverse

- Function `str_remove()` from package stringr It using for select columns

```
#Loading library
library(stringr)
#remove string
starwars$skin_color %>% str_remove(",") %>% str_remove(",")
```
Result : 
```
[1] "fair"              "gold"              "white blue"        "white"            
[5] "light"             "light"             "light"             "white red"        
[9] "light"             "fair"              "fair"              "fair"             
[13] "unknown"           "fair"              "green"             "green-tan brown"  
[17] "fair"              "fair"              "green"             "pale"             
[21] "fair"              "metal"             "green"             "dark"             
[25] "light"             "brown mottle"      "fair"              "fair"             
[29] "brown"             "grey"              "fair"              "mottled green"    
[33] "fair"              "orange"            "grey"              "green"            
[37] "fair"              "blue grey"         "grey red"          "dark"             
[41] "fair"              "red"               "pale"              "blue"             
[45] "blue grey"         "white blue"        "grey green yellow" "dark"             
[49] "pale"              "green"             "brown"             "dark"             
[53] "pale"              "white"             "orange"            "blue"             
[57] "dark"              "light"             "fair"              "green"            
[61] "yellow"            "yellow"            "light"             "fair"             
[65] "tan"               "tan"               "fair green yellow" "brown"            
[69] "grey"              "grey"              "fair"              "grey blue"        
[73] "silver red"        "green grey"        "grey"              "red blue white"   
[77] "brown white"       "brown"             "light"             "pale"             
[81] "grey"              "dark"              "light"             "light"            
[85] "none"              "unknown"           "light"            
```
** ทำให้สามารถลบตัวหนังสือที่ไม่ต้องการออกได้

## Part 3: Transform data with dplyr and finding insight the data

1. The book with the highest ratings
```
top_rating_book <- programming_book %>% select(Rating , Book_title, Description ) %>% filter(Rating == max(Rating))

```
Result:
```
  Rating              Book_title
1      5 Your First App: Node.js
```
อยากรู้ว่าหนังสือเล่มใดมี Rating มากที่สุด

2. Books that are cheap and rated good
```
price_good_rate_book <- programming_book %>% select(Rating , Book_title,Description) %>% filter(Rating > mean(Rating))

```
Result:
```
Rows: 147
Columns: 3
$ Rating      <dbl> 4.17, 4.09, 4.15, 4.62, 4.10, 4.22, 4.21, 4.28, 4.37, 4.25, 4.32, 4.13, 4.15, …
$ Book_title  <chr> "The Elements of Style", "Start with Why: How Great Leaders Inspire Everyone t…
$ Description <chr> "This style manual offers practical advice on improving writing skills. Throug…
```
อยากรู้ว่าหนังสือเล่มไหนที่มีเรทติ้งดีและมีราคาถูก

3. How many pages does a good rated book have?
```
page_good_rate_book <- programming_book %>% select(Number_Of_Pages , Rating) %>% filter(Rating > mean(Rating))
```
Result:
```
.
Rows: 147
Columns: 2
$ Number_Of_Pages <int> 105, 256, 368, 128, 542, 192, 224, 412, 320, 224, 384, 416, 184, 153, 257,…
$ Rating          <dbl> 4.17, 4.09, 4.15, 4.62, 4.10, 4.22, 4.21, 4.28, 4.37, 4.25, 4.32, 4.13, 4.…
```
อยากรู้จำนวนหน้าของหนังสือที่เรทติ้งมากกว่าค่าเฉลี่ย

4. Higher the rating, the more reviews?
```
review_rating <- programming_book %>% select(Reviews, Rating) %>% filter(Rating > mean(Rating))
```
Result:
```
Rows: 147
Columns: 2
$ Reviews <chr> "3,829", "5,938", "1,817", "0", "2,092", "27", "16", "1,268", "1", "16", "39", "86…
$ Rating  <dbl> 4.17, 4.09, 4.15, 4.62, 4.10, 4.22, 4.21, 4.28, 4.37, 4.25, 4.32, 4.13, 4.15, 4.23…
```
อยากรู้ว่ายิ่งเรทติ้งมีมากขึ้นการรีวิวก็จะมากขึ้นหรือเปล่า

5. How are more than average books reviewed?
```
reviewer_book <- programming_book %>% select(Reviews, Price) %>% filter(Price > mean(Price))
```
Result:
```
Rows: 105
Columns: 2
$ Reviews <chr> "57", "302", "8", "1", "2", "275", "116", "26", "164", "164", "1", "0", "0", "11",…
$ Price   <dbl> 54.71765, 54.93529, 56.07941, 56.59118, 56.63235, 57.15294, 57.15294, 58.42941, 58…
```
หนังสือที่มีราคามากกว่าค่าเฉลี่ยมีรีวิวอย่างไร

## Part 4: Visualization with GGplot2
### 1.) Graph show how many each type books
```
ggplot(data = reviewer_book, aes(x = Reviews, y = Price)) + geom_point()
```
Result:

![Graph 1](graph1.png)

จากกราฟจะเห็นได้ว่าราคากับรีวิวมีความสัมพันธ์กัน


### 2.) Graph show point page
```
ggplot(data = page_good_rate_book, aes(x = Number_Of_Pages, y = Rating)) + geom_point()
```
Result:

![Graph 2](graph2.png)

จากกราฟจะแสดงข้อมูลเบื้องต้น (max, min, mean, mean, outlier) เกี่ยวกับจำนวนหนังสือ