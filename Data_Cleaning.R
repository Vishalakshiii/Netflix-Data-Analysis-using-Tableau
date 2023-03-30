setwd("C:/Users/user/OneDrive/Desktop")
file <- read.csv("ABC.csv")
file

movie_details <- file[ , c(1:5,12,14)]
show_details <- file[ , c(6:11,13,14)]

#splitting the dataset
movie_details
show_details
write.csv(movie_details,"movie_details.csv", row.names = TRUE)
write.csv(show_details,"show_details.csv", row.names = TRUE)

colSums(is.na(movie_details))
colSums(is.na(show_details))


# Replacing null age values with mean age values
age = complete.cases(show_details$age)
mean_age = mean(age)
show_details$age[is.na(show_details$age)] <- mean_age

colSums(is.na(show_details))

# Omitting Rows containing NA Values
movie_details <- na.omit(movie_details)
show_details <- na.omit(show_details)

# Removing unnecessary columns
movie_details <- subset(movie_details, select = -director)
movie_details


install.packages('dplyr')
library(dplyr)
file1 <- left_join(movie_details, show_details,by='netflix_no')
file1<- na.omit(file1)

write.csv(file1,"netflix_titles.csv", row.names = TRUE)
