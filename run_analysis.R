# run_analysis.R

# 1.  Merges the training and the test sets to create one data set.
train_subject <- read.table(unz("UCI HAR Dataset.zip", "UCI HAR Dataset/train/subject_train.txt"), header = FALSE)
train_X <-  read.table(unz("UCI HAR Dataset.zip",
                           "UCI HAR Dataset/train/X_train.txt"),
                       header = FALSE)
train_y <-  read.table(unz("UCI HAR Dataset.zip",
                           "UCI HAR Dataset/train/y_train.txt"),
                       header = FALSE)
train <- cbind(train_subject, train_X, train_y)

test_subject <- read.table(unz("UCI HAR Dataset.zip", "UCI HAR Dataset/test/subject_test.txt"), header = FALSE)
test_X <-  read.table(unz("UCI HAR Dataset.zip",
                           "UCI HAR Dataset/test/X_test.txt"),
                       header = FALSE)
test_y <-  read.table(unz("UCI HAR Dataset.zip",
                           "UCI HAR Dataset/test/y_test.txt"),
                       header = FALSE)
test <- cbind(test_subject, test_X, test_y)

data <- rbind(train, test)

features <- read.table(unz("UCI HAR Dataset.zip",
                           "UCI HAR Dataset/features.txt"),
                       header = FALSE, stringsAsFactors = FALSE)

columns <- c("subject_id", features[,"V2"], "activity_id")
colnames(data) <- columns

# 2.  Extracts only the measurements on the mean and standard deviation
#     for each measurement.

mns <- grepl(".*-mean.*", colnames(data))
std <- grepl(".*-std.*", colnames(data))
extcol <- mns | std
d1 <- data[, 1]
d2 <- data[, ncol(data)]
d3 <- data[, extcol]
data2 <- cbind(subject_id=d1,activity_id=d2,d3)

# 3.  Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table(unz("UCI HAR Dataset.zip",
                                  "UCI HAR Dataset/activity_labels.txt"),
                              header = FALSE, stringsAsFactors = FALSE)
names(activity_labels) <- c("activity_id", "activity")
data3 <- merge(data2, activity_labels, by="activity_id")

# 4.  Appropriately labels the data set with descriptive variable names.

colnames(data3) <- gsub("-", "_", gsub("[)(,]","", colnames(data3)), fixed = TRUE)

# 5.  Creates a second, independent tidy data set with the average of
#     each variable for each activity and each subject.

library(reshape2)
library(dplyr)
data4 <- melt(data3, id.vars = c("subject_id","activity_id","activity"))
data5 <- data4[,-c(2)] %>% group_by(subject_id,activity,variable) %>%
    summarise(mean=mean(value))
