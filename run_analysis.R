# run_analysis.R

# loads data from the apropriate file in the .zip archive
load_data <- function(fname) {
    read.table(unz("UCI HAR Dataset.zip",
                   paste0("UCI HAR Dataset/", fname)),
               header = FALSE,
               stringsAsFactors = FALSE)
}

# loads all the pieces for the training or test data sets
build_dataset <- function(ds) {
    ds_subject <- load_data(paste0(ds, "/subject_", ds ,".txt"))
    ds_X <-  load_data(paste0(ds, "/X_", ds, ".txt"))
    ds_y <-  load_data(paste0(ds, "/y_", ds, ".txt"))
    ds <- cbind(ds_subject, ds_X, ds_y)
}

# 1.  Merges the training and the test sets to create one data set.

train <- build_dataset("train")
test <- build_dataset("test")
data <- rbind(train, test)

features <- load_data("features.txt")
colnames(data) <- c("subject_id", features[,"V2"], "activity_id")

# 2.  Extracts only the measurements on the mean and standard deviation
#     for each measurement.

mns <- grepl(".*-mean\\(.*", colnames(data))
std <- grepl(".*-std\\(.*", colnames(data))
extcol <- mns | std
data <- cbind(subject_id=data[, 1], activity_id=data[, ncol(data)],
               data[, extcol])

# 3.  Uses descriptive activity names to name the activities in
#     the data set

activity_labels <- load_data("activity_labels.txt")
colnames(activity_labels) <- c("activity_id", "activity")
data <- merge(data, activity_labels, by="activity_id")

# 4.  Appropriately labels the data set with descriptive variable names.

# remove extraneous characters
fields <- gsub("[)(,]","", colnames(data))
fields <- gsub("-", "_", fields, fixed = TRUE)
fields <- gsub("^t", "TimeDomain_", fields)
fields <- gsub("^f", "FrequencyDomain_", fields)
fields <- gsub("BodyBody", "Body_", fields, fixed = TRUE)
fields <- gsub("Body", "Body_", fields, fixed = TRUE)
fields <- gsub("Acc", "Accelerometer_", fields, fixed = TRUE)
fields <- gsub("Gyro", "Gyroscope_", fields, fixed = TRUE)
fields <- gsub("Mag", "Magnitude_", fields, fixed = TRUE)
fields <- gsub("Gravity", "Gravity_", fields, fixed = TRUE)
fields <- gsub("Jerk", "Jerk_", fields, fixed = TRUE)
fields <- gsub("__", "_", fields, fixed = TRUE)
colnames(data) <- fields

# save some space storing the data set in compressed form
write.csv(data, file = gzfile("ucihar_dataset.csv.gz"), row.names = FALSE)
#saveRDS(data, file = "ucihar_dataset.RDS")

# 5.  Creates a second, independent tidy data set with the average of
#     each variable for each activity and each subject.

library(reshape2)
library(dplyr)
tidy <- melt(data[, -1], id.vars = c("subject_id","activity")) %>%
    group_by(subject_id,activity,variable) %>%
    summarise(mean=mean(value))
tidy <- dcast(tidy, subject_id + activity ~ variable, value.var="mean")

write.csv(tidy, file = "ucihar_tidy_dataset.csv", row.names = FALSE)
#saveRDS(tidy, file= "ucihar_tidy_dataset.RDS")