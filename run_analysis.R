library(data.table)
library(dplyr)
library(reshape2)

features <- fread("UCI HAR Dataset/features.txt", sep = " ", stringsAsFactors=FALSE)
activity_labels <- fread("UCI HAR Dataset/activity_labels.txt", sep = " ", stringsAsFactors=FALSE)

X_train <- fread("UCI HAR Dataset/train/X_train.txt", sep = " ")
X_test <- fread("UCI HAR Dataset/test/X_test.txt", sep = " ")

Y_train <- fread("UCI HAR Dataset/train/Y_train.txt", sep = " ")
Y_test <- fread("UCI HAR Dataset/test/Y_test.txt", sep = " ")

subject_train <- fread("UCI HAR Dataset/train/subject_train.txt")
subject_test <- fread("UCI HAR Dataset/test/subject_test.txt")

mean_std <- which(grepl("mean|std", features$V2))
X_train <- X_train[, ..mean_std]
X_test <- X_test[, ..mean_std]

all_data <- rbind(cbind(subject_train, Y_train, X_train), cbind(subject_test, Y_test, X_test))
names(all_data) <- c("subject", "activity", unlist(features[mean_std, 2]))

all_data$activity <- factor(all_data$activity, levels = unlist(activity_labels[,1]), labels = unlist(activity_labels[,2]))
all_data$subject <- as.factor(all_data$subject)

all_data <- melt(all_data, id = c("subject", "activity"))
all_data <- dcast(all_data, subject + activity ~ variable, mean)

write.table(all_data, "tidy.txt", row.names = FALSE, quote = FALSE)