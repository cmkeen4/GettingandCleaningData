## This is CodeBook is a brief explanation of the processes and assumptions made by Chris Keen to meet the requirements of Peer Assessment assignment in the Coursera class, Getting and Cleaning Data.

Source of data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The files in the Dataset.zip 
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

Two folders, ‘test’ and ‘train’, with the subjects data sets.
-‘subject_test.txt’: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

-‘subject_train.txt’: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

# Read the text files into my environment

-subTest <- read.table("~/UCI HAR Dataset/test/subject_test.txt", quote="\"")

-xTest <- read.table("~/UCI HAR Dataset/test/X_test.txt", quote="\"")

-yTest <- read.table("~/UCI HAR Dataset/test/y_test.txt", quote="\"")

-subTrain <- read.table("~/UCI HAR Dataset/train/subject_train.txt", quote="\"")

-xTrain <- read.table("~/UCI HAR Dataset/train/X_train.txt", quote="\"")

-yTrain <- read.table("~/UCI HAR Dataset/train/y_train.txt", quote="\"")


-actLabels <- read.table("~/UCI HAR Dataset/activity_labels.txt", quote="\"")

-features <- read.table("~/UCI HAR Dataset/features.txt", quote="\"")

# The tables created had the following data

-subTest:  2,947 objects of 1 variable - int 

-xTest:  2,947 objects of 561 variables - all num

-yTest:  2,947 objects of 1 variable - int

-subTrain:  7,352 objects of 1 variable - int

-xTrain:  7,352 objects of 561 variable – all num

-yTrain:  7,352 objects of 1 variable - int

-actLabels:  6 objects of 2 variables – int, Factor w/ 6 levels

-features:  561 objects of 2 variables -  int, Factor w/ 477 levels

## My assumptions for binding, labeling and merging data tables.

I used rbind to create three (3) data tables from six(6):

-subjects:  10299 objects of 1 variable

-‘subjects’ – holds data from both subTest and subTrain 

-X (uppercase X):  10299 objects of 561 variables

-‘X’ – holds data from both xTest and xTrain

-Y (uppercase Y):  10299 objects of 1 variable

-‘Y’ – holds data from both yTest and yTrain

LABELING 
 I labeled each column of the data tables

-‘subjects’ has one column labeled “Subjects”

-‘X’ has 561 columns which I labeled using the 2nd column of the ‘features’ table.   The second column in the ‘features’ table was 561 rows of measurement names.  I made the assumption they corresponded to the 561 columns of data in X table.

-‘Y’ has one column labeled “Activity”

I converted the data in ‘Y’ from ‘int’ (1-6) to ‘chr’ based on the ‘actLabels’ table.

	1 = WALKING
	2 = WALKING_UPSTAIRS
	3 = WALKING_DOWNSTAIRS
	4 = SITTING
	5 = STANDING
	6 = LAYING

To extract only the measurements on the mean and standard deviation.  I used the ‘grep’ command to find the columns with either  ‘mean’ or ‘std’ (standard deviation) in the column name.  Using those columns to create a subset of ‘X’ data table.

-subX (uppercase X):  10299 objects of 79 variables.

-‘subX’ is the result of subset of ‘X’ using cbind of all columns whose name has the word ‘mean’ or  ‘std’ .

With all three (3) data tables (‘subjects’, ‘Y’, ‘subX’) labeled and trimmed down to the ‘mean’ and ‘std’ columns, I used the ‘cbind’ to create one data set called ‘myData’.

-myData:  10299 objects of 81 variables.

-‘myData’ is the result of column binding the data in this order; ‘subjects’, ‘Y’, ‘subX’, which states the number of 
the subject (1-30), the activity they were doing followed by the measurements.

Created a second data set from ‘myData’ with the average of each variable for each activity and subject.

-avgData:  135 objects of 81 variables.

-The objects were put in order based on the “Subjects” id (1-30).

Final step was to write the table to a text file.  

avgData was written to “avgData.txt” for submission to Coursera class “Getting and Cleaning Data”.
