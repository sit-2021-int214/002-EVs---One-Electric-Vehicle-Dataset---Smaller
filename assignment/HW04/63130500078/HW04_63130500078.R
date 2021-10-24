library(dplyr)
library(readr)
library(stringr)
library(ggplot2)

progrimming_book <- read.csv('https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv')

progrimming_book %>% glimpse()

progrimming_book %>% View()

progrimming_book %>% select(-Type,-Book_title,-Description,-Reviews) %>% summary()

progrimming_book$Reviews <- progrimming_book$Reviews %>% str_remove(",") %>% str_trim() %>% as.numeric()

progrimming_book$Type <- progrimming_book$Type %>% as.factor()

# what the book title have a number of Reviews more than average
mean_review <- progrimming_book$Reviews %>% mean(.)
reviewer <- progrimming_book %>% select(Book_title,Reviews) %>% filter(Reviews > mean_review)
reviewer %>% glimpse()

# what the book title book have Type is ebook
ebook <- progrimming_book %>% select(Book_title,Type) %>% filter(Type == "ebook") 

ebook %>% glimpse()

# what the book title have a number of page between 250 to 300
page <- progrimming_book %>% select(Book_title,Number_Of_Pages,Price) %>% filter(between(progrimming_book$Number_Of_Pages,250,300))
page %>% glimpse()

# what book cheap and good rating(compare to average)
mean_price <- progrimming_book$Price %>% mean(.)
mean_rate <- progrimming_book$Rating %>% mean(.) 
book <- progrimming_book %>% select(Book_title,Rating,Price) %>% filter(Price < mean_price & Rating > mean_rate)
book %>% glimpse()

# what the book have number of review less than 100 and have rating less than average
reviewer100 <- progrimming_book %>% select(Book_title,Reviews,Rating) %>% filter(Reviews < 100 & Rating < mean_rate)

reviewer100 %>% glimpse()

# what are the book good rate and have type is ebook (compare with average)
goodrate <- progrimming_book %>% select(Book_title,Rating,Type) %>% filter(Rating > mean_rate & Type =="ebook")
goodrate %>% glimpse()



type_plot <- table(progrimming_book$Type)
type_plot
Rating <- progrimming_book$Rating
Price <- progrimming_book$Price

graph<-data.frame(Rating,Price)

barplot(type_plot,
        main="Type Of Book",
        xlab = "Type",
        ylab = "Number of Book",col=rgb(0.2,0.4,0.6,0.6))


ggplot(graph,aes(x=Price,y=Rating))+geom_point( color="#69b3a2")+ggtitle("Rating and Price")




