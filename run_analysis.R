# Source of data for the project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Read the text files into my environment

subTest <- read.table("~/UCI HAR Dataset/test/subject_test.txt", quote="\"")
xTest <- read.table("~/UCI HAR Dataset/test/X_test.txt", quote="\"")
yTest <- read.table("~/UCI HAR Dataset/test/y_test.txt", quote="\"")

subTrain <- read.table("~/UCI HAR Dataset/train/subject_train.txt", quote="\"")
xTrain <- read.table("~/UCI HAR Dataset/train/X_train.txt", quote="\"")
yTrain <- read.table("~/UCI HAR Dataset/train/y_train.txt", quote="\"")

actLabels <- read.table("~/UCI HAR Dataset/activity_labels.txt", quote="\"")
features <- read.table("~/UCI HAR Dataset/features.txt", quote="\"")

## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.

subjects <- rbind(subTest, subTrain)
X <- rbind(xTest, xTrain)
Y <- rbind(yTest, yTrain)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

meanCols <- grep("mean", colnames(X), value=TRUE)
stdCols <- grep("std", colnames(X), value=TRUE)
meanColNum <- grep("mean", colnames(X))
stdColNum <- grep("std", colnames(X))
subX <- X[, c(meanColNum, stdColNum)]

myData <- cbind(subjects,Y,subX)

## 3. Uses descriptive activity names to name the activities in the data set

yTest$V1[which(yTest$V1==1)] <- "WALKING"
yTest$V1[which(yTest$V1==2)] <- "WALKING_UPSTAIRS"
yTest$V1[which(yTest$V1==3)] <- "WALKING_DOWNSTAIRS"
yTest$V1[which(yTest$V1==4)] <- "SITTING"
yTest$V1[which(yTest$V1==5)] <- "STANDING"
yTest$V1[which(yTest$V1==6)] <- "LAYING"

yTrain$V1[which(yTrain$V1==1)] <- "WALKING"
yTrain$V1[which(yTrain$V1==2)] <- "WALKING_UPSTAIRS"
yTrain$V1[which(yTrain$V1==3)] <- "WALKING_DOWNSTAIRS"
yTrain$V1[which(yTrain$V1==4)] <- "SITTING"
yTrain$V1[which(yTrain$V1==5)] <- "STANDING"
yTrain$V1[which(yTrain$V1==6)] <- "LAYING"

## 4. Appropriately labels the data set with descriptive activity names. 

colnames(subjects) <- "Subjects"
colnames(Y) <- "Activity"
colnames(X) <- features[,2]

## 5. Creates a second, independent tidy data set with the average of 
##  each variable for each activity and each subject.
library(data.table)
dt <- data.table(myData)
avgData <- dt[ ,lapply(.SD,mean), by=c("Subjects", "Activity")]
avgData <- avgData[order(avgData$Subject), ]

## Write table to a text file 

write.table(avgData, "avgData.txt", sep="\t")
