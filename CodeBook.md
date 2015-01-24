# Codebook

This is the code book that describes the variables, the data, and any transformations or work that is performed to clean up the data.

## The Data Source

 * Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 * Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities *(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)* wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## The Data

The dataset includes the following files:

 * `README.txt`
 * `features_info.txt`: Shows information about the variables used on the feature vector.
 * `features.txt`: List of all features.
 * `activity_labels.txt`: Links the class labels with their activity name.
 * `train/X_train.txt`: Training set.
 * `train/y_train.txt`: Training labels.
 * `test/X_test.txt`: Test set.
 * `test/y_test.txt`: Test labels.

## Transformation Details

There are 5 parts:

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive activity names.
 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How the above Steps are implemented in `run_analysis.R`

 * Require data.table and plyr libraries.
 * Load both test and train data sets
    + there are 10,299 instances where each instance contains 561 features 
      (560 measurements and subject identifier).
    + After merge operation the rsulting data, the table contains 560 measurements,
      subject identifer and acitivity label. 
 * Load the features and activity labels
 * Extract the mean and standard deviation column names and data
    + Out of 560 measurements are 33 mean and 33 standard devitaions extracted
    + resulting in a data frame with 68 features
    + additional features are subject identifier and activity label.
 * Activity label are replace with descriptive activity names, defined in the file
   *activity_labels.txt* in the original data folder.
 * Create the tidy data set with the average of each variable for each
   activity and each subject. 
     + 10299 instances are split into 180 groups.
     + 66 mean and standard deviation features are averaged for each group.
     + The resulting data table has 180 rows and 66 columns.
 * The tidy data set is exported to the file *UCIHAR_tidy.csv* with the header in the
   first row containing the names of each column.
