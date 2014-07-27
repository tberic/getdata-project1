# unzip the data file
unzip("getdata-projectfiles-UCI HAR Dataset.zip")

folder <- "UCI HAR Dataset"

## this is for testing purposes only
n <- -1 # 302 # 2947

# read the test data
testData <- read.table(paste0(folder, "/test", "/X_test.txt"), nrows = n)

## read in the names of the features and name the columns
features <- read.table(paste0(folder, "/features.txt"))

## extract only the mean and standard deviation measures
## we do not include *meanFreq()* variables, just those that end with mean()
## the same holds for std()
feat <- grep("*-mean\\(\\)|-std\\(\\)*", features[,2])
testData <- testData[, feat]
names(testData) <- features[feat, 2]

## read the subject IDs and activity codes
testData <- cbind(read.table(paste0(folder, "/test", "/y_test.txt"), nrows = n), testData)
testData <- cbind(read.table(paste0(folder, "/test", "/subject_test.txt"), nrows = n), testData)
names(testData)[1] <- "subjectID"
names(testData)[2] <- "activity"



# read the training data
trainData <- read.table(paste0(folder, "/train", "/X_train.txt"), nrows = n)

## extract only the mean and standard deviation measures
trainData <- trainData[, feat]
names(trainData) <- features[feat, 2]

## read the subject IDs and activity codes
trainData <- cbind(read.table(paste0(folder, "/train", "/y_train.txt"), nrows = n), trainData)
trainData <- cbind(read.table(paste0(folder, "/train", "/subject_train.txt"), nrows = n), trainData)
names(trainData)[1] <- "subjectID"
names(trainData)[2] <- "activity"


# merge test and training data
completeData <- rbind(testData, trainData)

# remove temporary tables from memory
rm(testData)
rm(trainData)

# give descriptive names to activities
activities <- read.table(paste0(folder, "/activity_labels.txt"))
for (i in 1:6) 
    completeData[, 2] <- gsub(activities[, 1][i], 
                              activities[, 2][i], 
                              completeData[, 2])


# calculate the mean for each subject and activity
newData <- aggregate(completeData[,3:68], 
                     by=list(subjectID = completeData$subjectID, 
                             activity = completeData$activity), 
                     FUN=mean)

# remove the old data set from memory
rm(completeData)
# write the tidy data set to a txt file
write.table(newData, "UCI_HAR_tidy.txt")
