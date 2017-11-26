library(data.table)
library(dplyr)

# Read in the required space (" ") separated text files

features <- fread("UCI HAR Dataset/features.txt", sep = " ", stringsAsFactors=FALSE)
activity_labels <- fread("UCI HAR Dataset/activity_labels.txt", sep = " ", stringsAsFactors=FALSE)

X_train <- fread("UCI HAR Dataset/train/X_train.txt", sep = " ")
X_test <- fread("UCI HAR Dataset/test/X_test.txt", sep = " ")

Y_train <- fread("UCI HAR Dataset/train/Y_train.txt", sep = " ")
Y_test <- fread("UCI HAR Dataset/test/Y_test.txt", sep = " ")

subject_train <- fread("UCI HAR Dataset/train/subject_train.txt")
subject_test <- fread("UCI HAR Dataset/test/subject_test.txt")

# Select only the columns that contain the mean and standard deviation of the measurements

mean_std <- which(grepl("mean|std", features$V2))
X_train <- X_train[, ..mean_std]
X_test <- X_test[, ..mean_std]

# Combine the subject, activity, and features data frames for both train and test into a single data frame

all_data <- rbind(cbind(subject_train, Y_train, X_train), cbind(subject_test, Y_test, X_test))
names(all_data) <- c("subject", "activity", unlist(features[mean_std, 2]))

# Replace the numeric values in the activity column with string descriptions i.e. replace all 1s with "WALKING", etc

all_data$activity <- factor(all_data$activity, levels = unlist(activity_labels[,1]), labels = unlist(activity_labels[,2]))
all_data$subject <- as.factor(all_data$subject)

# Calculate the mean of all of the measurements grouped by subject and activity

tidy <- all_data %>% group_by(subject, activity) %>% summarize_all(funs(mean))

# Write the tidy data to "tidy.txt" 

write.table(tidy, "tidy.txt", row.names = FALSE, quote = FALSE)
