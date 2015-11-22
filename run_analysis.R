#function used to move columns to first position in a data frame
movetofirst <- function(data, move) {
  data[c(move, setdiff(names(data), move))]
}

#install dplyr if not installed and load
if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}
library(dplyr)

#read data
subject_test <- read.table("data/test/subject_test.txt", stringsAsFactors=FALSE)
subject_train <- read.table("data/train/subject_train.txt", stringsAsFactors=FALSE)
X_test <- read.table("data/test/X_test.txt", stringsAsFactors=FALSE)
X_train <- read.table("data/train/X_train.txt", stringsAsFactors=FALSE)
y_test <- read.table("data/test/y_test.txt", stringsAsFactors=FALSE)
y_train <- read.table("data/train/y_train.txt", stringsAsFactors=FALSE)
activity_labels <- read.table("data/activity_labels.txt", stringsAsFactors=FALSE)
features <- read.table("data/features.txt", stringsAsFactors=FALSE)

#merge test and train data
subject <- rbind(subject_test, subject_train)
data <- rbind(X_test, X_train)
y <- rbind(y_test, y_train)

#properly name variables
names(data) <- features[, 2]

#remove duplicated names (they are not useful anyway)
data <- data[ , !duplicated(colnames(data))]

#keep only mean and std variables
data <- select(data, contains("mean"), contains("std"))

#add subject and activity columns
data$subject <- subject[[1]]
data$activity <- as.factor(apply(y, MARGIN = 2, FUN = function(x) activity_labels[x, 2]))

#move activity and subject columns to beginning
data <- movetofirst(data, "activity")
data <- movetofirst(data, "subject")

#save data
write.table(data, file = "dirty.txt", row.names = FALSE)
#clean up the workspace
# remove(subject_test, subject_train, X_test, X_train, y_test, y_train)
# remove(y, subject, features, activity_labels)
#generate final tidy dataset
tidy <- data %>% group_by(subject, activity) %>% summarize_each (funs(mean), contains("mean"), contains("std"))
write.table(tidy, file = "tidy.txt", row.names = FALSE)
