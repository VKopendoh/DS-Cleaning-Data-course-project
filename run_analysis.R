# A script for Coursera'a Getting and Cleaning Data course project
# by Vladimir Kopendokh 

# Load libraries
library(dplyr)
library(tidyr)

#setwd("C:/learn/Data Science/Course 3 Getting Data/week 4/prog")

# Download and unzip data
if (!dir.exists('./data/')){dir.create('data')}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip_file <- "./data/UCIDATA.zip"
download.file(url, zip_file, method = 'curl')
unzip(zip_file, exdir = './data', junkpaths = TRUE)

# Read files to the data table, note that column names (variables names) for xtest and xtrain
# are from 'features' data frame.
features <- read.table("./data/features.txt", col.names = c('num', 'features'), stringsAsFactors = FALSE)

xtest <- read.table("./data/X_test.txt")
names(xtest) <- features$features
ytest <- read.table("./data/y_test.txt", col.names = 'numID')
sub_test <- read.table("./data/subject_test.txt",col.names = 'subjectID')

xtrain <- read.table("./data/X_train.txt")
names(xtrain) <- features$features
ytrain <- read.table("./data/y_train.txt", col.names = 'numID')
sub_train <- read.table("./data/subject_train.txt", col.names = "subjectID")

activities <- read.table("./data/activity_labels.txt", col.names = c('numID', 'activity'),stringsAsFactors = FALSE)

# Merge data, first join a ytest and ytrain with activities dataset for associate
# numerical data about observed activities with its descriptive names and mutate
# those names to lower case.
named_ytest <- inner_join(ytest, activities) %>% mutate(activity = tolower(activity))%>% tbl_df
named_ytrain <- inner_join(ytrain, activities) %>% mutate(activity = tolower(activity))%>% tbl_df

# Merge all 'test' data in one dataset there are we have variables: subjects ID's,  
# names of activities and all the time and frequency domain variables
test <- cbind(sub_test, named_ytest, xtest)
# Same process for  all 'train' data
train <- cbind(sub_train, named_ytrain, xtrain)

# Merge 'train' and 'test' datasets in one and remove numID column. 
data <- rbind(train,test)
data <- data[-2]

# Extract only 'mean' and 'std' columns except 'subjectID' and 'activity'
mean_std_pos <- grep(pattern = "mean\\(\\)|std\\(\\)", names(data))
data <- data[c(1,2,mean_std_pos)]

# Make descriptive variables names. Here 'f' and 't' in the beginning of all variables 
# changed to 'frequency' and 'time', respectively, then remove all '-' and replace 'std()' 
# and 'mean()' with capitalized 'Std' and 'Mean'.

names <- names(data)
names <- gsub(pattern = 'std\\(\\)', x = names, replacement = "Std")
names <- gsub(pattern = 'mean\\(\\)', x = names, replacement = "Mean")
names <- gsub(pattern = '-', x = names, replacement = "")
names <- sub(pattern = '^f', x = names, replacement = "frequency")
names <- sub(pattern = '^t', x = names, replacement = "time")
names(data) <- names

# Create a data set with the average of each variable for each activity and each subject
# I also add a prefixes 'AVG', which means average to any column name, where we get an
# average and at the end create and save data set to csv file 'data.csv'.

avg_data <- data %>% tbl_df %>%
    group_by(activity, subjectID) %>%
    summarise_each(funs(mean))
names(avg_data) <- sapply(names(avg_data), function(x){
    if (x[] == 'activity' | x[] == 'subjectID'){
        x[]=x[]
    }
    else{
        x[] = paste0('AVG',x[])
    }
})
write.csv(avg_data, file = "./data/data.csv")

