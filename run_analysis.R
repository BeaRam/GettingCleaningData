# Getting & Cleaning Data Project Assignment


##The purpose of this project is to demonstrate your ability to collect, 
## work with, and clean a data set. The goal is to prepare tidy data that can 
## be used for later analysis.


library(dplyr)

filename <- "Coursera_Final.zip"

## Check to see if files exists
## If it does not exists, download and save the file at the URL

if (!file.exists(filename)){
        URL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(URL1, filename, method = "curl")   
}



## Checking for the Download Folder Existence
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}


## Extract the Data Frames from the UCI HAR Dataset Folder
Features <- read.table("UCI HAR Dataset/features.txt", col.names = 
                               c("n","functions"))
head(Features, 5)
dim(Features) ## 561 x 2

Activities <- read.table("UCI HAR Dataset/activity_labels.txt", 
                         col.names = c("code", "activity"))

head(Activities, 5)
dim(Activities) ## 6 x 2

## Extract the dataframes from UCI HAR Dataset/test Folder
Subject_Test <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                           col.names = "subject")

head(Subject_Test, 5)
dim(Subject_Test) ## 2947 x 1

X_test <- read.table("UCI HAR Dataset/test/X_test.txt", 
                     col.names = Features$functions) ## assign the function 
## names from the Features Dataframe

head(X_test, 5)
dim(X_test) ## 2947 x 561


Y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")


head(Y_test, 5)
dim(Y_test) ## 2947 x 1

## Extract the dataframes from UCI HAR Dataset/train Folder
Subject_Train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "subject")


head(Subject_Train, 5)
tail(Subject_Train, 5)
dim(Subject_Train) ## 7352 x 1


X_Train <- read.table("UCI HAR Dataset/train/X_train.txt", 
                      col.names = Features$functions) ## assign the function 
## names from the Features Dataframe

head(X_Train, 5)
tail(X_Train, 5)
dim(X_Train) ## 7352 x 1

Y_Train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


head(Y_Train, 5)
tail(Y_Train, 5)
dim(Y_Train) ## 7352 x 1



# 1. Merge the training and the test sets to create one data set.

## Row binding the X Train & Test Datasets
X <- rbind(X_Train, X_test)


head(X, 5)
colnames(X)
dim(X) ## 10299 x 561


## Row binding the Y Train & Test Datasets
Y <- rbind(Y_Train, Y_test)


head(Y, 5)
tail(Y, 5)
colnames(Y)
dim(Y) ## 10299 x 1

## Row binding the Subject Train & Test Datasets
Subs <- rbind(Subject_Train, Subject_Test)


head(Subs, 5)
tail(Subs, 5)
colnames(Subs)
dim(Subs) ## 10299 x 1


## Column Bind ALL the row-bound merged datasets
Merge_All <- cbind(Subs, Y, X)

head(Merge_All, 5)
tail(Merge_All, 5)
colnames(Merge_All)
dim(Merge_All) ## 10299 x 563


# Extract only the measurements on the mean & 
# standard deviation for each measurement.

TidyDat <- Merge_All %>% select(subject, code, contains("mean"), contains("std"))

head(TidyDat, 5)
tail(TidyDat, 5)
colnames(TidyDat)
dim(TidyDat) ## 10299 x 88

# Use descriptive activity names to name the activities in the Tidy data set
TidyDat$code <- Activities[TidyDat$code, 2]



# Appropriately label the data set with descriptive variable names.


names(TidyDat)[2] = "activity"
names(TidyDat)<-gsub("Acc", "Accelerometer", names(TidyDat))
names(TidyDat)<-gsub("Gyro", "Gyroscope", names(TidyDat))
names(TidyDat)<-gsub("BodyBody", "Body", names(TidyDat))
names(TidyDat)<-gsub("Mag", "Magnitude", names(TidyDat))
names(TidyDat)<-gsub("^t", "Time", names(TidyDat))
names(TidyDat)<-gsub("^f", "Frequency", names(TidyDat))
names(TidyDat)<-gsub("tBody", "TimeBody", names(TidyDat))
names(TidyDat)<-gsub("-mean()", "Mean", names(TidyDat), ignore.case = TRUE)
names(TidyDat)<-gsub("-std()", "STD", names(TidyDat), ignore.case = TRUE)
names(TidyDat)<-gsub("-freq()", "Frequency", names(TidyDat), ignore.case = TRUE)
names(TidyDat)<-gsub("angle", "Angle", names(TidyDat))
names(TidyDat)<-gsub("gravity", "Gravity", names(TidyDat))


head(TidyDat, 5)
tail(TidyDat, 5)
colnames(TidyDat)


# From the data set in step 4, create a 2nd, independent tidy data set 
# with the average of each variable for each activity and each subject.

FinalStep_Data <- TidyDat %>%
        group_by(subject, activity) %>%
        summarise_all(list(mean))
write.table(FinalStep_Data, "FinalStep_Data.txt", row.name=FALSE)


# Checking the final dataset from step 5

str(FinalStep_Data)
View(FinalStep_Data)