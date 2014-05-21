# Getting and Cleaning Data 
# Course Project Code Book

## Overview
We'll be examining data from smartphone accelerometers available here: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

A description of the data is available here <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>


## Data Access

Data were downloaded from the provided website and extracted from the zip file.  Upon examination of the documentation provided with the dataset, five relevant pieces of information were used:

**1. The Activity Labels ** 
This information is found in the top level directory in the `activity_labels.txt` file and contains activity descriptions and associated IDs

**2. The Variable Names ** 
This information is also found in the top level directory in the `features.txt` file and contains the variable names of interest.  A full description of naming conventions and processing used to create the variables is available in `features_info.txt`

**3.  The Data ** 
The test data and training data are found in the test and train directories in `X_test.txt` and `X_train.txt` respectively.  These files contain the data for each subject, activity, and variable.  

**4. The Subject Identifiers **
These data are found in the test and train directories in `subject_test.txt` and `subject_train.txt` respectively.  The subject IDs correspond to rows in the test and training data from #3.  

**5. The Activity Identifiers **
These data are found in the test and train directories in `y_test.txt` and `y_train.txt` respectively.  These data consist of activity IDs that are associated with each row in the test and training data from #3 and can be linked to the activity labesl in #1.  


There is also raw inertial signals data included in the Inertial Signals directories.  We'll ignore this data as it is not relevant; the appropriate information we need has been summarized in the five parts described above.  

## Data Processing
After loading the five pieces of information described above, the data were processed to produce a tidy dataset by:

**1. Selecting relevant Means and Standard Devations **
Not all of the features (variables) included in the dataset are relevant to our pursuits and interests.  Only mean and standard deviation features (variables) were selected.  

** 2. Combining Test and Training Data **
The test and training data were combined and labeled accordingly.  

** 3.  Adding Subject IDs **
Subject IDs were added to the data from part #4 above.  

** 4. Labelling Activities **
Activites were labeled according to information provided in part #1 and #5 above.  

** 5. Averaging by Subject and Activity **
The mean of each variable was determined for each variable, subject and activity

** 6. Conversion to Tidy Format **
The data were converted to a tidy format with fixed variables then measured variables as columns and each row an observation.  

The tidy data can be found in `tidy_data.txt` provided with this Code Book.  

## Variables and Nomenclature

Column names for the variables included in the tidy dataset are included in Table 1 below.  

** Subject.ID ** is a unique identifier for each subject that participated in the original study.  

** Activity ** describes one of six activities that study participants enjoyed.  

** Set ** denotes whether the data were designated as part of the training or test set.  

** Other Variables ** are the measured variables provided by the study.  Variables beginning with an *f* denote frequency domains while variables beginning with a *t* denote time domains.  Variables containing X,Y, or Z designations denote metrics for that axis respectively while the absence of such designations denotes magnitude across the axes.  Means and standard deviations (std) are labeled accordingly.  


### Table 1
|Column |    Column Name         |
|----|---------------------------|
| 1  | Subject.ID                |
| 2  | Activity                  |
| 3  | Set                       |
| 4  | fBodyAcc.mean.X           |
| 5  | fBodyAcc.mean.Y           |
| 6  | fBodyAcc.mean.Z           |
| 7  | fBodyAcc.std.X            |
| 8  | fBodyAcc.std.Y            |
| 9  | fBodyAcc.std.Z            |
| 10 | fBodyAccJerk.mean.X       |
| 11 | fBodyAccJerk.mean.Y       |
| 12 | fBodyAccJerk.mean.Z       |
| 13 | fBodyAccJerk.std.X        |
| 14 | fBodyAccJerk.std.Y        |
| 15 | fBodyAccJerk.std.Z        |
| 16 | fBodyAccMag.mean          |
| 17 | fBodyAccMag.std           |
| 18 | fBodyBodyAccJerkMag.mean  |
| 19 | fBodyBodyAccJerkMag.std   |
| 20 | fBodyBodyGyroJerkMag.mean |
| 21 | fBodyBodyGyroJerkMag.std  |
| 22 | fBodyBodyGyroMag.mean     |
| 23 | fBodyBodyGyroMag.std      |
| 24 | fBodyGyro.mean.X          |
| 25 | fBodyGyro.mean.Y          |
| 26 | fBodyGyro.mean.Z          |
| 27 | fBodyGyro.std.X           |
| 28 | fBodyGyro.std.Y           |
| 29 | fBodyGyro.std.Z           |
| 30 | tBodyAcc.mean.X           |
| 31 | tBodyAcc.mean.Y           |
| 32 | tBodyAcc.mean.Z           |
| 33 | tBodyAcc.std.X            |
| 34 | tBodyAcc.std.Y            |
| 35 | tBodyAcc.std.Z            |
| 36 | tBodyAccJerk.mean.X       |
| 37 | tBodyAccJerk.mean.Y       |
| 38 | tBodyAccJerk.mean.Z       |
| 39 | tBodyAccJerk.std.X        |
| 40 | tBodyAccJerk.std.Y        |
| 41 | tBodyAccJerk.std.Z        |
| 42 | tBodyAccJerkMag.mean      |
| 43 | tBodyAccJerkMag.std       |
| 44 | tBodyAccMag.mean          |
| 45 | tBodyAccMag.std           |
| 46 | tBodyGyro.mean.X          |
| 47 | tBodyGyro.mean.Y          |
| 48 | tBodyGyro.mean.Z          |
| 49 | tBodyGyro.std.X           |
| 50 | tBodyGyro.std.Y           |
| 51 | tBodyGyro.std.Z           |
| 52 | tBodyGyroJerk.mean.X      |
| 53 | tBodyGyroJerk.mean.Y      |
| 54 | tBodyGyroJerk.mean.Z      |
| 55 | tBodyGyroJerk.std.X       |
| 56 | tBodyGyroJerk.std.Y       |
| 57 | tBodyGyroJerk.std.Z       |
| 58 | tBodyGyroJerkMag.mean     |
| 59 | tBodyGyroJerkMag.std      |
| 60 | tBodyGyroMag.mean         |
| 61 | tBodyGyroMag.std          |
| 62 | tGravityAcc.mean.X        |
| 63 | tGravityAcc.mean.Y        |
| 64 | tGravityAcc.mean.Z        |
| 65 | tGravityAcc.std.X         |
| 66 | tGravityAcc.std.Y         |
| 67 | tGravityAcc.std.Z         |
| 68 | tGravityAccMag.mean       |
| 69 | tGravityAccMag.std        |
