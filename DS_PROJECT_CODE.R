data<-read.csv("C:/Users/user/OneDrive/Desktop/netflix_titles.csv")

summary(data)

library(dplyr)
library(tibble)


Ratings<-data %>% 
  group_by(rating) %>%
  summarise(count = n())

Ratings <- Ratings[order(-Ratings$count),]
barplot(Ratings$count[1:10],
        main = "Top 10 Genre according to Rating",
        xlab = "Ratings",
        ylab = "Total number of shows",
        names.arg=Ratings$rating[1:10])



types<-data %>%
  group_by(type) %>%
  summarise(count = n())

types

getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))] }
  
AGE<-data %>%
  group_by(age) %>%
  summarise_if(is.numeric,getmode)
AGE<-AGE[,c(1,5)]



#Q   counting no of Indian Movies released On Netflix in the year 2019 
Y<-data %>%
  select(show_id,title,country,release_year) %>%
  filter(release_year == 2019,country ==  "India") %>%
summarise(title,release_year)
count=nrow(Y)  

#Q top 10 Genre  
t<-select(data,netflix_no,listed_in)
t1<-count(data,listed_in)
S<-arrange(t1[1:10,],desc(n),listed_in)


#total movies and shows for kids(less than 18 years)
data %>% 
  group_by(type) %>% 
  filter( age > 18) %>% 
  summarise(across(c(title, listed_in), n_distinct))
