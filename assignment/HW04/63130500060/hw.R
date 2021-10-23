library(dplyr)
library(readr)
library(ggplot2)
programming_book <- read.csv('https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv')

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

#6
many_review_book <- programming_book %>% select(Reviews, Book_title) %>% filter(Reviews > 200 )

ggplot(data = reviewer_book, aes(x = Reviews, y = Price)) + geom_point()
View(reviewer_book)
ggplot(data = page_good_rate_book, aes(x = Number_Of_Pages, y = Rating)) + geom_point()
View(page_good_rate_book)
write.csv(programming_book, file="Top_Programming_Book")