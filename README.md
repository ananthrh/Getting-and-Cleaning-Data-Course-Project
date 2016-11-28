#This is the readme file for the project in Getting and Cleaning data

The script run_analysis creates 2 datasets that are the outputs for the project

##mergedMeanStdDS
This dataset addresses the following.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.

##meanDS
This dataset addresses the following.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The steps in the script are
###0 -- LOAD LIBRARIES
	a. Load tidyr library
	b. Load tidyr library

###1 -- DOWNLOAD AND UNZIP DATASET FILES
	a. Download the data in binary format
	b. Unzip the file

###2 -- READ THE COMMON FILES
	a. Read the common files - features.txt
	b. Read the common files - activity_labels.txt

###3 -- READ THE TRAINING DATASET FILES
	a. Read the training dataset - data - fixed width fields - field widths 16 - number of fields 561
	b. Read the training dataset - subjects - field seperator is a space
	c. Read the training dataset - activities - field seperator is a space

###4 -- MERGE THE TRAINING DATASET FILES
	a. Add id field to trainDataDS
	b. Add id field to trainSubjectDS
	c. Add id field to trainActivityDS
	d Merge trainDataDS and trainSubjectDS on ID
	e Merge new dataset with trainActivityLabeledDS on ID

###5 -- READ THE TEST DATASET FILES
	a. Read the test dataset - data - fixed width fields - field widths 16 - number of fields 561
	b. Read the test dataset - subjects - field seperator is a space
	c. Read the test dataset - activities - field seperator is a space

###6 -- MERGE THE TEST DATASET FILES
	a. Add id field to testDataDS
	b. Add id field to testSubjectDS
	c. Add id field to testActivityLabeledDS
	d Merge trainDataDS and trainSubjectDS on ID
	e Merge new dataset with trainActivityLabeledDS on ID

###7 -- Merges the training and the test sets to create one data set.

###8 -- Extracts only the measurements on the mean and standard deviation for each measurement.

###9 -- Uses descriptive activity names to name the activities in the data set

###10 -- Appropriately labels the data set with descriptive variable names.
	Remove all non alpha characters in names

###11 -- From the data set in step 4, creates a second, independent tidy data set with the 
	average of each variable for each activity and each subject.
	use the mean field for the calculation
	did not use the following freq fields
		fBodyAccmeanFreqX
		fBodyAccmeanFreqY
		fBodyAccmeanFreqZ
		fBodyAccJerkmeanFreqX
		fBodyAccJerkmeanFreqY
		fBodyAccJerkmeanFreqZ
		fBodyGyromeanFreqX
		fBodyGyromeanFreqY
		fBodyGyromeanFreqZ
		fBodyAccMagmeanFreq
		fBodyBodyAccJerkMagmeanFreq
		fBodyBodyGyroMagmeanFreq
		fBodyBodyGyroJerkMagmeanFreq
