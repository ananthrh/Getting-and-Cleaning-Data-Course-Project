# Fourth Quiz

setwd("C:/data/DataScientist/3.GettingAndCleaningData/Project/FinalProject")

#0 -- LOAD LIBRARIES
#0.a. Load tidyr library
library(tidyr)
#0.b. Load tidyr library
library(dplyr)

#1 -- DOWNLOAD AND UNZIP DATASET FILES
#1.a. Download the data in binary format
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "UCI_AR_Dataset.zip",mode="wb")
#1.b. Unzip the file
unzip(zipfile="UCI_AR_Dataset.zip",overwrite=TRUE)

#2 -- READ THE COMMON FILES
#2.a. Read the common files - features.txt
featuresDS <- read.delim("./UCI HAR Dataset/features.txt",header=FALSE,sep=" ")
#2.b. Read the common files - activity_labels.txt
activityLabelDS <- read.delim("./UCI HAR Dataset/activity_labels.txt",header=FALSE,sep=" ")

#3 -- READ THE TRAINING DATASET FILES
#3.a. Read the training dataset - data - fixed width fields - field widths 16 - number of fields 561
trainDataDS <- read.fwf("./UCI HAR Dataset/train/X_train.txt",header=FALSE,widths = rep(16,561),buffersize = 1)
#system.time(trainDataDS <- read.fwf("./UCI HAR Dataset/train/X_train.txt",header=FALSE,widths = rep(16,561),buffersize = 1))
names(trainDataDS) <- as.vector(featuresDS$V2)
#3.b. Read the training dataset - subjects - field seperator is a space
trainSubjectDS <- read.delim("./UCI HAR Dataset/train/subject_train.txt",header=FALSE,sep=" ")
names(trainSubjectDS) <- c("subjectid")
#3.c. Read the training dataset - activities - field seperator is a space
trainActivityDS <- read.delim("./UCI HAR Dataset/train/y_train.txt",header=FALSE,sep=" ")
trainActivityLabeledDS <- merge(trainActivityDS,activityLabelDS, x.by = "v1", y.by = "V1")
names(trainActivityLabeledDS) <- c("activityid", "activityname")

#4 -- MERGE THE TRAINING DATASET FILES
#4.a. Add id field to trainDataDS
trainDataDS$ID<-seq.int(nrow(trainDataDS))
#4.b. Add id field to trainSubjectDS
trainSubjectDS$ID<-seq.int(nrow(trainSubjectDS))
#4.c. Add id field to trainActivityDS
trainActivityLabeledDS$ID<-seq.int(nrow(trainActivityLabeledDS))
#4.d Merge trainDataDS and trainSubjectDS on ID
trainMergedDS <- merge(trainDataDS,trainSubjectDS,by.x = "ID", by.y = "ID")
#4.e Merge new dataset with trainActivityLabeledDS on ID
trainMergedDS <- merge(trainMergedDS,trainActivityLabeledDS,by.x = "ID", by.y = "ID")

#5 -- READ THE TEST DATASET FILES
#5.a. Read the test dataset - data - fixed width fields - field widths 16 - number of fields 561
testDataDS <- read.fwf("./UCI HAR Dataset/test/X_test.txt",header=FALSE,widths = rep(16,561),buffersize = 1)
#system.time(testDataDS <- read.fwf("./UCI HAR Dataset/test/X_test.txt",header=FALSE,widths = rep(16,561),buffersize = 1))
names(testDataDS) <- as.vector(featuresDS$V2)
#5.b. Read the test dataset - subjects - field seperator is a space
testSubjectDS <- read.delim("./UCI HAR Dataset/test/subject_test.txt",header=FALSE,sep=" ")
names(testSubjectDS) <- c("subjectid")
#5.c. Read the test dataset - activities - field seperator is a space
testActivityDS <- read.delim("./UCI HAR Dataset/test/y_test.txt",header=FALSE,sep=" ")
testActivityLabeledDS <- merge(testActivityDS,activityLabelDS, x.by = "v1", y.by = "V1")
names(testActivityLabeledDS) <- c("activityid", "activityname")

#6 -- MERGE THE TEST DATASET FILES
#6.a. Add id field to testDataDS
testDataDS$ID<-seq.int(nrow(testDataDS))
#6.b. Add id field to testSubjectDS
testSubjectDS$ID<-seq.int(nrow(testSubjectDS))
#6.c. Add id field to testActivityLabeledDS
testActivityLabeledDS$ID<-seq.int(nrow(testActivityLabeledDS))
#6.d Merge trainDataDS and trainSubjectDS on ID
testMergedDS <- merge(testDataDS,testSubjectDS,by.x = "ID", by.y = "ID")
#6.e Merge new dataset with trainActivityLabeledDS on ID
testMergedDS <- merge(testMergedDS,testActivityLabeledDS,by.x = "ID", by.y = "ID")

#POINT #1: 1. Merges the training and the test sets to create one data set.
mergedDS <- rbind(testMergedDS,trainMergedDS)
dim(mergedDS)

#POINT #2: 2. Extracts only the measurements on the mean and standard deviation for each measurement.
filterFields <- grep("mean|std|subjectid|activityid|activityname",names(mergedDS), value = TRUE)
mergedMeanStdDS <- mergedDS[filterFields]

#POINT #3: 3. Uses descriptive activity names to name the activities in the data set
#Available in activityname field

#POINT #4: 4. Appropriately labels the data set with descriptive variable names.
#Remove all non alpha characters in names
names(mergedMeanStdDS) <- gsub("[^a-zA-Z0-9]","",names(mergedMeanStdDS))

#POINT #5: 5. From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.
#use the mean field for the calculation
#did not use the following freq fields
#fBodyAccmeanFreqX
#fBodyAccmeanFreqY
#fBodyAccmeanFreqZ
#fBodyAccJerkmeanFreqX
#fBodyAccJerkmeanFreqY
#fBodyAccJerkmeanFreqZ
#fBodyGyromeanFreqX
#fBodyGyromeanFreqY
#fBodyGyromeanFreqZ
#fBodyAccMagmeanFreq
#fBodyBodyAccJerkMagmeanFreq
#fBodyBodyGyroMagmeanFreq
#fBodyBodyGyroJerkMagmeanFreq

meanDS <-
    mergedMeanStdDS %>%
    group_by(subjectid,activityname) %>%
    summarize(tBodyAccmeanX = mean(tBodyAccmeanX, na.rm = TRUE),
              tBodyAccmeanY = mean(tBodyAccmeanY, na.rm = TRUE),
              tBodyAccmeanZ = mean(tBodyAccmeanZ, na.rm = TRUE),
              tGravityAccmeanX = mean(tGravityAccmeanX, na.rm = TRUE),
              tGravityAccmeanY = mean(tGravityAccmeanY, na.rm = TRUE),
              tGravityAccmeanZ = mean(tGravityAccmeanZ, na.rm = TRUE),
              tBodyAccJerkmeanX = mean(tBodyAccJerkmeanX, na.rm = TRUE),
              tBodyAccJerkmeanY = mean(tBodyAccJerkmeanY, na.rm = TRUE),
              tBodyAccJerkmeanZ = mean(tBodyAccJerkmeanZ, na.rm = TRUE),
              tBodyGyromeanX = mean(tBodyGyromeanX, na.rm = TRUE),
              tBodyGyromeanY = mean(tBodyGyromeanY, na.rm = TRUE),
              tBodyGyromeanZ = mean(tBodyGyromeanZ, na.rm = TRUE),
              tBodyGyroJerkmeanX = mean(tBodyGyroJerkmeanX, na.rm = TRUE),
              tBodyGyroJerkmeanY = mean(tBodyGyroJerkmeanY, na.rm = TRUE),
              tBodyGyroJerkmeanZ = mean(tBodyGyroJerkmeanZ, na.rm = TRUE),
              tBodyAccMagmean = mean(tBodyAccMagmean, na.rm = TRUE),
              tGravityAccMagmean = mean(tGravityAccMagmean, na.rm = TRUE),
              tBodyAccJerkMagmean = mean(tBodyAccJerkMagmean, na.rm = TRUE),
              tBodyGyroMagmean = mean(tBodyGyroMagmean, na.rm = TRUE),
              tBodyGyroJerkMagmean = mean(tBodyGyroJerkMagmean, na.rm = TRUE),
              fBodyAccmeanX = mean(fBodyAccmeanX, na.rm = TRUE),
              fBodyAccmeanY = mean(fBodyAccmeanY, na.rm = TRUE),
              fBodyAccmeanZ = mean(fBodyAccmeanZ, na.rm = TRUE),
              fBodyAccJerkmeanX = mean(fBodyAccJerkmeanX, na.rm = TRUE),
              fBodyAccJerkmeanY = mean(fBodyAccJerkmeanY, na.rm = TRUE),
              fBodyAccJerkmeanZ = mean(fBodyAccJerkmeanZ, na.rm = TRUE),
              fBodyGyromeanX = mean(fBodyGyromeanX, na.rm = TRUE),
              fBodyGyromeanY = mean(fBodyGyromeanY, na.rm = TRUE),
              fBodyGyromeanZ = mean(fBodyGyromeanZ, na.rm = TRUE),
              fBodyAccMagmean = mean(fBodyAccMagmean, na.rm = TRUE),
              fBodyBodyAccJerkMagmean = mean(fBodyBodyAccJerkMagmean, na.rm = TRUE),
              fBodyBodyGyroMagmean = mean(fBodyBodyGyroMagmean, na.rm = TRUE),
              fBodyBodyGyroJerkMagmean = mean(fBodyBodyGyroJerkMagmean, na.rm = TRUE))

