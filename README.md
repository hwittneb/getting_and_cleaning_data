# Getting and Cleaning Data

This repository contains R code that downloads and does some preprocessing on Human 
Activity Recognition data set. The full description and the data can be found
[here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

See file *CodeBook.md* in this repository for details.


### Course Project: January 2015

You should create one R script called run_analysis.R that does the following:

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive activity names.
 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Steps to work on this course project

Run source(run_analysis.R") with:

  * Input Data:
      1. Check for *data* directory and creates one if it doesn't exist.
      2. Check for directory *data/UCI HAR Dataset*. If it down't exist download and 
         extract the data zip file into *data* directory.

   * Output Data:
       * *run_anaylsis.R* generates a new file UCIHAR_tidy.csv in your working directory.


### Dependencies

run_analysis.R file will install the dependencies automatically. 
It depends on the CRAN packages read.table and plyr.

