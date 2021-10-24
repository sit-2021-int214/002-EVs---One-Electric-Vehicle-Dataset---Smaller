#library
library(dplyr)
library(readr)
library(ggplot2)

#Dataset
Prog_book <- read.csv('https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv')

#show data type row and columns
glimpse(Prog_book)

#learn function from tidyverse
#function map() from purrr
install.packages("purrr")

get_list <- list(
  c(3,5,8),
  c(9,12,2),
  c(4,26,7)
)

get_list %>% map(mean)

#1 find lowest book price
lowest_price <- Prog_book %>% select(Price, Book_title, Description) %>% filter(Price == min(Price))
glimpse(lowest_price)

#2 find book that rating more than mean
More_mean <- Prog_book %>% select(Rating, Price, Book_title, Description) %>% filter(Rating > mean(Rating))
glimpse(More_mean)

#3 find book type Hardcover 
find_type <- Prog_book %>% select(Type, Book_title) %>% filter(Type == "Hardcover")
glimpse(find_type)

#4 find Number_Of_Pages that least than 100
find_page <- Prog_book %>% select(Number_Of_Pages, Book_title) %>% filter(Number_Of_Pages < 100)
glimpse(find_page)

#5 find book that rating more than 4 and price least than 10
rating_price <- Prog_book %>% select(Rating, Price, Book_title) %>% filter(Rating > 4 & Price < 10)
glimpse(rating_price)

#6 find number of book that type is Hardcover
count_book <- Prog_book %>% filter(Type == "Hardcover") %>% count()

#ggplot
Prog_book %>% ggplot(aes(x = Rating, y = Price)) + geom_point()
Prog_book %>% ggplot(aes(Type)) + geom_bar()
