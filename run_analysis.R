#Firstly we download our dataset through given link

  if(!file.exists("./data")){dir.create("./data")}
  
  #Here are the data for the project:
  
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./data/Dataset.zip")
  
  #We now unzip dataSet to data directory
  
  unzip(zipfile="./data/Dataset.zip",exdir="./data")

#Now we read data from different the files
  
  #Read tables from train folder
  x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
  y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
  subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
  
  #Read tables from test folder
  x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
  y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
  subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
  
  #Reading feature vector
  features <- read.table('./data/UCI HAR Dataset/features.txt')
  
  #Reading activity labels
  activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

#Assigning column names:
  
  colnames(activityLabels) <- c('activityId','activityType')
  colnames(features) <-c('no','functions')
  
  colnames(x_train) <- features$functions
  colnames(y_train) <-"activityId"
  colnames(subject_train) <- "subjectId"
  
  colnames(x_test) <- features$functions
  colnames(y_test) <- "activityId"
  colnames(subject_test) <- "subjectId"

#Merges the training and the test sets to create one data set.
  
  #merged train dataset
  mrgd_train<-cbind(x_train,y_train,subject_train)
  
  #merged test dataset
  mrgd_test<-cbind(x_test,y_test,subject_test)
  
  #Final merged dataset
  Merged_data<-rbind(mrgd_train,mrgd_test)

#Extracts only the measurements on the mean and standard deviation for each measurement.
  
  TidyData <- Merged_data %>% select(subjectId, activityId, contains("mean"), contains("std"))

#Uses descriptive activity names to name the activities in the data set
  
  TidyData$activityId <- activityLabels[TidyData$activityId,2]

#Appropriately labels the data set with descriptive variable names
  
  names(TidyData)[2] <- "activity"
  names(TidyData) <- ""  