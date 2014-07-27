## Assignment for the course "Getting and Cleaning Data" (Coursera)

### Data source

The data for this project was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original source for this data set is: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Project instructions

This project is part of Coursera's "Getting and Cleaning Data"
assignment, which was described as follows:

> Create one R script called `run_analysis.R` that does the following:
>
> 1.  Merges the training and the test sets to create one data set.
> 2.  Extracts only the measurements on the mean and standard deviation for each measurement.
> 3.  Uses descriptive activity names to name the activities in the data set
> 4.  Appropriately labels the data set with descriptive variable names.
> 5.  Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Project files

- `README.md` and `README.html`: describes the assignment and
  solution
- `Codebook.md` and `Codebook.html`: Final tidy data set's codebook
- `run_analysis.R`: R script that reads the original data and applies the
  transformations indicated in the assignment instructions, generating
  the final tidy data set.
- `ucihar_tidy_dataset.txt`: the final tidy data set
- `UCI HAR Dataset.zip`: the data set provided for the assignment

### How was the data processed

The original data was read directly from the compressed (zip) file. In
order to simplify the code, I defined a couple of functions, one to read the
data from the zip file:

~~~
load_data <- function(fname) {
    read.table(unz("UCI HAR Dataset.zip",
                   paste0("UCI HAR Dataset/", fname)),
               header = FALSE,
               stringsAsFactors = FALSE)
}
~~~

And another function to join the data files into the data frames that we need:

~~~
build_dataset <- function(ds) {
    ds_subject <- load_data(paste0(ds, "/subject_", ds ,".txt"))
    ds_X <-  load_data(paste0(ds, "/X_", ds, ".txt"))
    ds_y <-  load_data(paste0(ds, "/y_", ds, ".txt"))
    ds <- cbind(ds_subject, ds_X, ds_y)
}
~~~

With these functions, building the training and testing data sets, and
then merging them together is a matter of three lines:

~~~
train <- build_dataset("train")
test <- build_dataset("test")
data <- rbind(train, test)
~~~ 

After the merged data set us created, appropiate column names are
assigned using the names stored in the `features.txt` file:

~~~
features <- load_data("features.txt")
colnames(data) <- c("subject_id", features[,"V2"], "activity_id")
~~~

The assignment then asks to select the columns that correspond to the
means and standard deviations.

According to the documentation that accompanies de original data set,
the columns we want have names that contain the strings `mean()` and
`std()` respectively.

The columns are selected using the appropriate regular expressions, and
then doing a union operation of the resulting logic vectors:

~~~
mns <- grepl(".*-mean\\(.*", colnames(data))
std <- grepl(".*-std\\(.*", colnames(data))
extcol <- mns | std
data <- cbind(subject_id=data[, 1], activity_id=data[, ncol(data)],
               data[, extcol])
~~~

To be able to assign appropriate activity labels, we read the ones
defined in the file `activity_labels.txt`, and do some minor manipulations
to get rid of the underscore ("_") in a couple of the values. After
that we merge these activity labels with the data set obtained above:

~~~
activity_labels <- load_data("activity_labels.txt")
colnames(activity_labels) <- c("activity_id", "activity")
activity_labels$activity <- gsub("_", " ", activity_labels$activity, fixed = TRUE)
data <- merge(data, activity_labels, by="activity_id")
~~~

Then, we cleanup a bit the variable (column) names, to get rid of all
the extraneous characters (parenthesis, commas, etc.), and also to
replace the abbreviations for complete words (e.g. Acc -> Accelerometer).

To help with this task we defined a `cleanup` function that takes as
parameters:
    1. A list with three components: the string or pattern to be
       replaced, the replacement, and a flag to indicate if we used a
       fixed pattern or not
    2. The character vector with the column names we want to clean up

~~~
cleanup <- function(clist, orig) {
    out <- orig
    for(i in 1:length(clist[[1]])) {
        out <- gsub(clist$from[i], clist$to[i], out, clist$fixed[i])
    }
    return(out)
}
~~~

We define the appropriate list, and fix the column names using the
function defined above:

~~~
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
~~~

Finally, we create a tidy data set containing "... the average of each
variable for each activity and each subject ...".

To make things cleaner and more readable, I am using a couple of
packages: `reshape2` and `dplyr` (which is similar to `plyr` but only
deals with data frames and provides function call chaining). 

To make the tidy data set, we first generate a "long" version of it
using `melt()`, then calculate the mean values (`summarise()`) for each
variable, grouping by subject and activity (`group_by()`), and to finish
we recreate the "wide" version of the data set using `dcast()`.

The resulting data set is saved to a text file.

~~~
library(reshape2)
library(dplyr)
tidy <- data[, -1] %>% melt(id.vars = c("subject_id","activity")) %>%
    group_by(subject_id,activity,variable) %>%
    summarise(mean=mean(value)) %>%
    dcast(subject_id + activity ~ variable, value.var="mean")

write.table(tidy, file = "ucihar_tidy_dataset.txt", row.names = FALSE, quote = TRUE)
~~~