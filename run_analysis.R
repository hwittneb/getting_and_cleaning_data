# Getting and Cleaning Data: 
# ==========================
# Week3: Project at Coursera, Jan 2015
#
# This R script gets and performs some cleaning on human activity data, built
# from recordings of subjects performing daily activities while carrying
# smartphone. The full description of the data set is available at:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# Create one R script called run_analysis.R that does the following: 
# ---------------------------------------------------------------------------------------------
#    1. Merges the training and the test sets to create one data set.
#    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#    3. Uses descriptive activity names to name the activities in the data set
#    4. Appropriately labels the data set with descriptive variable names. 
#    5. From the data set in step 4, creates a second, independent tidy data set with the 
#       average of each variable for each activity and each subject.
# ---------------------------------------------------------------------------------------------
# last changed: 2015-01-24
#
library(plyr)

downloadData = function() {
    # Checks for data directory and creates one if it doesn't exist
    if (!file.exists("data")) {
        message("Creating data directory")
        dir.create("data")
    } 
    if (!file.exists("data/UCI HAR Dataset")) {
        # download the data
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        zipfile="data/UCI_HAR_data.zip"
        message("Downloading data")
        download.file(fileURL, destfile=zipfile, method="curl")
        unzip(zipfile, exdir="data")
    }
}

mergeDatasets = function() {
    # Read data and merge training and test datasets
    #
    # Read data from training and test data files
    message("reading X_train.txt")
    trainingX <- read.table("data/UCI HAR Dataset/train/X_train.txt")
    message("reading y_train.txt")
    trainingY <- read.table("data/UCI HAR Dataset/train/y_train.txt")
    message("reading subject_train.txt")
    trainingSubject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
    message("reading X_test.txt")
    testX <- read.table("data/UCI HAR Dataset/test/X_test.txt")
    message("reading y_test.txt")
    testY <- read.table("data/UCI HAR Dataset/test/y_test.txt")
    message("reading subject_test.txt")
    testSubject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
    #
    # Merge training and test datasets
    mergedX <- rbind(trainingX, testX)
    mergedY <- rbind(trainingY, testY)
    mergedSubject <- rbind(trainingSubject, testSubject)
    # and return
    list(x=mergedX, y=mergedY, subject=mergedSubject)
}

extractMeanStd = function(df) {
    # Given the dataset (x values), extract only the measurements on the mean
    # and standard deviation for each measurement.
    #
    # Read the feature list file
    features <- read.table("data/UCI HAR Dataset/features.txt")
    #
    # Find the mean and std columns
    meanCol <- sapply(features[,2], function(x) grepl("mean()", x, fixed=T))
    stdCol <- sapply(features[,2], function(x) grepl("std()", x, fixed=T))
    #
    # Extract them from the meanCol and stdCol and store them into a data frame
    extractDf <- df[, (meanCol | stdCol)]
    colnames(extractDf) <- features[(meanCol | stdCol), 2]
    extractDf
}

nameActivities = function(df) {
    # Use descriptive activity names to name the activities in the dataset
    colnames(df) <- "activity"
    df$activity[df$activity == 1] = "WALKING"
    df$activity[df$activity == 2] = "WALKING_UPSTAIRS"
    df$activity[df$activity == 3] = "WALKING_DOWNSTAIRS"
    df$activity[df$activity == 4] = "SITTING"
    df$activity[df$activity == 5] = "STANDING"
    df$activity[df$activity == 6] = "LAYING"
    df
}

bindData <- function(x, y, subjects) {
    # Combine mean-std values (x), activities (y) and subjects into one data
    # frame.
    cbind(x, y, subjects)
}

createTidyDataset = function(df) {
    # Given X values, y values and subjects, create an independent tidy dataset
    # with the average of each variable for each activity and each subject.
    tidy <- ddply(df, .(subject, activity), function(x) colMeans(x[,1:60]))
    tidy
}

# =======================================================================================
#
# Download data
downloadData()
#
# 1. Merge the training and the test datasets
# -------------------------------------------
# mergeDatasets function returns a list of three dataframes: X, y, and subject
merged <- mergeDatasets()

# 2. Extract only the measurements of the mean and standard deviation for each measurement
# ----------------------------------------------------------------------------------------
colx <- extractMeanStd(merged$x)

# 3. Use descriptive activity names to name the activities in the data set
# -------------------------------------------------------------------------
coly <- nameActivities(merged$y)

# 4. Label the data set with descriptive variable names. 
# ------------------------------------------------------
colnames(merged$subject) <- c("subject")

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
# -------------------------------------------------------------------------------------------------------------------- 
# Combine the 3 dataframes into one 
combined <- bindData(colx, coly, merged$subject)
#
# Create the tidy dataset
tidy <- createTidyDataset(combined)
#
# Write the tidy dataset as csv
write.csv(tidy, "UCIHAR_tidy.csv", row.names=FALSE)


