# DS-Cleaning-Data-course-project
Coursera's Getting and Cleaning Data course project

About this repository.
============================

This repo presented a course project for Coursera's Getting and Cleaning Data course, and consist from files:
- 'Readme.md' this file which describes a cource tasks, R script with solutions of those tasks and its explanation, description of
this repo and description of source data.
- 'CodeBook.md', file that describes the variables, the data, and any transformations or work that you performed to clean up the data.
- 'run_analysis.R', file with R script ready for implementation and described here, its tested in R version 3.2.5 on Windows 7 OS. 
- 'data.csv', file with data set which created according a task.

Task description:
============================================
##### Review criteria.
- The submitted data set is tidy.
- The Github repo contains the required scripts.
- GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
- The README that explains the analysis files is clear and understandable.
- The work submitted for this project is the work of the student who submitted it.

##### Getting and Cleaning Data Course Project.
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

R script and solutions.
=======================================

### Below presented and described a R script that does the following.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### NOTE: Source data described at the end of this Readme file.

### Load libraries.
> library(dplyr) </br>
  library(tidyr)

### Download and unzip data.
> if (!dir.exists('./data/')){dir.create('data')} </br>
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"</br>
zip_file <- "./data/UCIDATA.zip"</br>
download.file(url, zip_file, method = 'curl')</br>
unzip(zip_file, exdir = './data', junkpaths = TRUE)

### Read files to the data table, note that column names (variables names) for xtest and xtrain are from 'features' data frame.
> features <- read.table("./data/features.txt", col.names = c('num', 'features'), stringsAsFactors = FALSE)
xtest <- read.table("./data/X_test.txt")</br>
names(xtest) <- features$features</br>
ytest <- read.table("./data/y_test.txt", col.names = 'numID')</br>
sub_test <- read.table("./data/subject_test.txt",col.names = 'subjectID')</br>
xtrain <- read.table("./data/X_train.txt")</br>
names(xtrain) <- features$features</br>
ytrain <- read.table("./data/y_train.txt", col.names = 'numID')</br>
sub_train <- read.table("./data/subject_train.txt", col.names = "subjectID")</br>
activities <- read.table("./data/activity_labels.txt", col.names = c('numID', 'activity'),stringsAsFactors = FALSE)

### Merge data, first join a ytest and ytrain with activities dataset for associate numerical data about observed activities with its descriptive names and mutate those names to lower case.
> named_ytest <- inner_join(ytest, activities) %>% mutate(activity = tolower(activity))%>% tbl_df</br>
named_ytrain <- inner_join(ytrain, activities) %>% mutate(activity = tolower(activity))%>% tbl_df</br>

### Merge all 'test' data in one dataset there are we have variables: subjects ID's, names of activities and all the time and frequency domain variables.
> test <- cbind(sub_test, named_ytest, xtest)</br>

### Same process for  all 'train' data
> train <- cbind(sub_train, named_ytrain, xtrain)

### Merge 'train' and 'test' datasets in one and remove numID column. 
> data <- rbind(train,test)</br>
data <- data[-2]

### Extract only 'mean' and 'std' columns except 'subjectID' and 'activity'
> mean_std_pos <- grep(pattern = "mean\\(\\)|std\\(\\)", names(data))</br>
data <- data[c(1,2,mean_std_pos)]

### Make descriptive variables names. Here 'f' and 't' in the beginning of all variables  changed to 'frequency' and 'time', respectively, then remove all '-' and replace 'std()' and 'mean()' with capitalized 'Std' and 'Mean'.

> names <- names(data)</br>
names <- gsub(pattern = 'std\\(\\)', x = names, replacement = "Std")</br>
names <- gsub(pattern = 'mean\\(\\)', x = names, replacement = "Mean")</br>
names <- gsub(pattern = '-', x = names, replacement = "")</br>
names <- sub(pattern = '^f', x = names, replacement = "frequency")</br>
names <- sub(pattern = '^t', x = names, replacement = "time")</br>
names(data) <- names

### Create a data set with the average of each variable for each activity and each subject I also add a prefixes 'AVG', which means average to any column name, where we get an average and at the end create and save data set to csv file 'data.csv'.

> avg_data <- data %>% tbl_df %>%</br>
  group_by(activity, subjectID) %>%</br>
  summarise_each(funs(mean))</br>
names(avg_data) <- sapply(names(avg_data), function(x){</br>
   if (x[] == 'activity' | x[] == 'subjectID'){</br>
       x[]=x[]</br>
  }</br>
  else{</br>
      x[] = paste0('AVG',x[])</br>
 }</br>
})</br>
write.csv(avg_data, file = "./data/data.csv")

Source Data description.
======================================
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
