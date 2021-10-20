library(dplyr)
library(readr)
library(ggplot2)
library()
programming_book <- read.csv('https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv')

glimpse(programming_book)

#1
top_rating_book <- programming_book %>% select(Rating , Book_title, Description ) %>% filter(Rating == max(Rating))

#2
price_good_rate_book <- programming_book %>% select(Rating , Book_title,Description) %>% filter(Rating > mean(Rating))

#3
page_good_rate_book <- programming_book %>% select(Number_Of_Pages , Rating) %>% filter(Rating > mean(Rating))

#4
review_rating <- programming_book %>% select(Reviews, Rating) %>% filter(Rating > mean(Rating))

#5
reviewer_book <- programming_book %>% select(Reviews, Price) %>% filter(Price > mean(Price))

ggplot(data = review_rating) + geom_point()

