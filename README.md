getdata-project1
================

Course Project for the course Getting and Cleaning Data on Coursera


## The goal

The goal is to clean a data set on wearable computing found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


## Reading the data

First we unzip the file. Then we read in the data file by file. We start with the /test/X_test.txt file which contains the raw accelerometer data. Then we extract from that file only the variables that contain information about mean values and standard deviations. We can find out which columns to keep by reading the /features.txt file. Using that file we can also name the variables in our table. 

Next, we add the activities data which can be found in /test/y_test.txt. Also we add the subject IDs which are in /test/subject_test.txt.

Everything we did for the test data we also do for the training data by replacing *test* with *train* in the file names in all occurrences.


## Merging data

By using the `rbind` command, we merge the test data with the training data giving a complete data set. In this stage we also remove the tables with the training and test data from the memory as they are no longer needed. All the following calculations will be done on the complete data set.


## Naming everything

We give descriptive names to the variables from the /features.txt file. Also we name the activities which are given by numbers 1-6 from the file /activity_labels.txt.


## Tidy data

Finally, using the `aggregate` function, we give the average of each variable for each activity and each subject. This gives us the file UCI_HAR_tidy.txt which we obtain by writing out the content of the table with the averages via the function `write.table`.
