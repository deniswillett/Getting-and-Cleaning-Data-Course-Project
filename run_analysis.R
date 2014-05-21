#============================================================#
#        Getting and Cleaning Data Course Project            #
#============================================================#

## Project assignment is to create a tidy dataset from :
## https://d396qusza40orc.cloudfront.net/getdata%2Fproject
## files%2FUCI%20HAR%20Dataset.zip 

## Description of data is available from:
## http://archive.ics.uci.edu/ml/datasets/
## Human+Activity+Recognition+Using+Smartphones 

## See accompanying README.md and CodeBook.md files for
## more information regarding data structure and processing

################ Libraries #####################

# Load appropriate libraries for project
library(dplyr) #awesome at split-apply-combine
library(reshape2) #used for melting and casting

################# Download Data ##############
#Set Working Directory appropriately

#Url of data source
url='https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

#Download File
download.file(url,'data.zip', method='curl')

# Unzip All Files
unzip('data.zip')


####################### Read in Data #################

# Based on reading the informative README.txt file provided from
# the website, it seems we'll
# need to read in five pieces of information:
# -The Activity Labels (identifiers for the participants activity)
# -The names of the variables (they call this the features- see the
#                              features_info.txt file)
# -The Data (both test and training)
# -The Subject Identifiers (for both Training and Test Data)
# -The Activity Identifiers (for both Training and Test Data)
# 
# We'll ignore the raw inertial signals data as that does not seem relevant
# to our pursuits at this time; the data features should provide enough 
# information

# We'll start from the top level and work down.  

setwd('./UCI HAR Dataset')

#Step 1: Read in Activity Labels
Activity.Labels=read.table('activity_labels.txt',
                           col.names=c('Activity.ID','Activity'))

#Step 2: Read in variable names
Var.Names=read.table('features.txt', colClasses=c('NULL', 'character'), 
                     col.names=c('None','Variable'))

# Step 3: Read in Test Data
test=read.table('./test/X_test.txt')

# Step 4: Read in Training Data
train=read.table('./train/X_train.txt')

# Step 5: Read in Subject Identifiers
subject.test=read.table('./test/subject_test.txt')
subject.train=read.table('./train/subject_train.txt')

# Step 6: Read in Activity Identifiers
activity.test=read.table('./test/y_test.txt')
activity.train=read.table('./train/y_train.txt')

############## Select and Combine Relevant Data ################

# We're now going to do the first two objectives from the project 
# description, namely:
# -1: Merge the training and test sets to create one data set.
# and
# -2: Extract only the measurements on the mean and standard deviation 
#     for each measurement. 

# (Note: Subsequent processing steps do not correspond with the numbered 
# objectives from the project description)

# Since we're only interested in means and standard deviations, let's
# first determine which variables are relevant:

# Step 1.1: Determine which variables are relevant means (ie not meanFreq()
# or gravityMean())

var.mns=
        with(Var.Names, {
                grep('-mean()', Variable, fixed=TRUE)     
        })

# Step 1.2: Determine which variables are relevant standard deviations

var.std=
        with(Var.Names, {
                grep('-std()', Variable, fixed=TRUE)
        })

# Next we'll construct a data frame with the relevant variables and the 
# training and test sets.  

# Step 2.1: Combine Test and Training Sets
combined=rbind(test[,c(var.mns, var.std)], train[,c(var.mns, var.std)])

# Step 2.2: Name columns
colnames(combined)=Var.Names[c(var.mns, var.std),1]

# Step 3: Add Training and Test IDs
combined$Set=c(rep('Test', nrow(test)),rep('Train', nrow(train)))

# Step 4: Add Subject IDs
combined$Subject.ID=c(subject.test[,1], subject.train[,1])

################## Label Activities #########################

# Now let's do objectives 3 and 4 from the project description, namely:
# -3: Use descriptive activity names to name the activities in the data set
# and
# -4: Appropriately label the data set with descriptive activity names. 

# (Note: Subsequent processing steps do not correspond with the numbered 
# objectives from the project description)

#Step 1: Add Activity IDs
combined$Activity.ID=c(activity.test[,1], activity.train[,1])

# Step 2: Associate Activities with Activity IDs
joined=left_join(combined, Activity.Labels, by='Activity.ID')

####################### Create Tidy Data Set ############################

# Now let's create a tidy dataset, objective 5 from the project description
# -5: Creates a second, independent tidy data set with the average of 
#      each variable for each activity and each subject. 

# Step 1: Melt the data frame for summarization
m.joined=melt(joined, id=c('Set','Subject.ID','Activity.ID', 'Activity'), 
              variable.name='Metric')

# Step 2: Find mean for each variable, subject, and activity
Complete=m.joined %.%
        group_by(Subject.ID, Activity, Metric) %.%
        summarize(Set=first(Set),
                  Average=mean(value))

# Now let's Reformat variable names more appropriately

# Step 3.1: Replace dashes with dots
Complete$Metric=with(Complete, {
        gsub('-', '.', Metric)
})

# Step 3.2: Get rid of parentheses
Complete$Metric=with(Complete, {
        gsub('()', '', Metric, fixed=TRUE)
})

# Step 4.1:
# Recast the dataset into tidy format with fixed variables first,
# then measured variables and each row an observation.  
tidy=dcast(Subject.ID+Activity+Set ~ Metric, data=Complete)

# Step 4.2: Order by Subject, Activity, and Set
tidy=arrange(tidy, 
             Subject.ID, Activity, Set)

################## Save Tidy Data ######################

#Move to parent directory
setwd('..')

# Save as a txt file in parent directory
write.table(tidy, file='tidy_data.txt')






