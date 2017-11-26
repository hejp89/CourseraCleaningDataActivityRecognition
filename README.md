# Getting and Cleaning Data - Course Project

This repo contains my submission for the Coursera "Getting and Cleaning Data" project.

The script "run_analysis.R" performs the follows steps:

1. Reads the subjects, features, and measurements datasets in the "UCI HAR Dataset" folder.
2. Removes measurements that are not of the mean or standard deviation.
3. Combines the subject, activity, and features data frames for both train and test into a single data frame.
4. Replaces the numeric values in the activity column with string descriptions i.e. replace all 1s with "WALKING", etc
5. Calculates the mean of all of the measurements grouped by subject and activitys
6. Outputs the tidy data to tidy.txt.

The input data can be found here: <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones</a>
