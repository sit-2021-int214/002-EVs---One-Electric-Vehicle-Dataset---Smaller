#Exercise 1
varX <- c(10.4, 5.6, 3.1, 6.4, 21.7) #เป็นการประกาศค่าลงในตัวแปร varX
summary(varX) #เป็นการหาค่าต่างๆทางสถิติในภาพรวมจากตัวแปร varX

#Exercise 2
# List of Marvel movies (Order by Marvel Phase released)
names <- c("Iron Man","The Incredible Hulk","Iron Man 2","Thor","Captain America: The First Avenger",
           "The Avengers","Iron Man 3","Thor: The Dark World","Captain America: The Winter Soldier",
           "Guardians of the Galaxy","Avengers: Age of Ultron","Ant-Man","Captain America: Civil War",
           "Doctor Strange","Guardians of the Galaxy 2","Spider-Man: Homecoming","Thor: Ragnarok","Black Panther",
           "Avengers: Infinity War","Ant-Man and the Wasp","Captain Marvel","Avengers: Endgame",
           "Spider-Man: Far From Home","WandaVision","Falcon and the Winter Soldier","Loki","Black Widow")
years <- c(2008,2008,2010,2011,2011,2012,2013,2013,2014,2014,2015,2015,2016,2016,
           2017,2017,2017,2017,2018,2018,2019,2019,2019,2021,2021,2021,2021)


#2.2.1
length(names) #ใช้หาจำนวนของหนังทั้งหมด จึงเลือกใชเ length เพราะจะหาว่าใน names มีทั้งหมดกี่ชื่อ

#2.2.2
names[19] #ใช้เพราะจะไปหาหนังเรื่องที่ 19  โดยการเขียนแบบนี้จะไปดูรายชื่อ names ตำแหน่งที่ 19

#2.2.3
# ใช้หาปีของหนังที่มีเรื่องมากที่สุด
sort(table(years)) # ปี 2017 และ 2021 มีหนังปล่อยมามากที่สุด ที่เลือกใช้ table เพราะต้องการเทียบจำนวนในแต่ละปี
#จากนั้นจะ sort เพื่อให้ทำการเรียงจากน้อยไปมาก เราก็จะได้ปีที่มากที่สุกดอย่างทางด้านขวา
