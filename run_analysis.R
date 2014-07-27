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
activity_labels$activity <- gsub("_", " ", activity_labels$activity, fixed = TRUE)
data <- merge(data, activity_labels, by="activity_id")

# 4.  Appropriately labels the data set with descriptive variable names.

# remove extraneous characters
cleanup <- function(clist, orig) {
    out <- orig
    for(i in 1:length(clist[[1]])) {
        out <- gsub(clist$from[i], clist$to[i], out, clist$fixed[i])
    }
    return(out)
}

clist <- list(
            from=c("[)(,]", "^t", "^f",
                   "-", "BodyBody", "Body", "Acc", "Gyro",
                   "Mag", "Gravity", "Jerk", "__"),
            to=c("", "TimeDomain_", "FrequencyDomain_",
                 "_", "Body_", "Body_", "Accelerometer_", "Gyroscope_",
                 "Magnitude_", "Gravity_", "Jerk_", "_"),
            fixed=c(rep(FALSE, 3), rep(TRUE, 9))
        )

colnames(data) <- cleanup(clist, colnames(data))

# save some space storing the data set in compressed form
write.csv(data, file = gzfile("ucihar_dataset.csv.gz"), row.names = FALSE)

# 5.  Creates a second, independent tidy data set with the average of
#     each variable for each activity and each subject.

library(reshape2)
library(dplyr)
tidy <- melt(data[, -1], id.vars = c("subject_id","activity")) %>%
    group_by(subject_id,activity,variable) %>%
    summarise(mean=mean(value)) %>%
    dcast(subject_id + activity ~ variable, value.var="mean")

write.table(tidy, file = "ucihar_tidy_dataset.txt", row.names = FALSE, quote = TRUE)