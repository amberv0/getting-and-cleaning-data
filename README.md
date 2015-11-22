# Getting and Cleaning Data course project
In the "data" folder there is all the data needed to run the script run_analysis.R. The data is exactly the same as was provided in the .zip file.

##How run_analysis.R script works
* checks if there is dplyr package installed and installs it if it's not the case.
* loads all data the files into data frames
* merges test and train data, putting test data first
* names variables according to how they are defined in data/activity_labels.txt
* removes columns with duplicated names (as otherwise we'll have problems with dplyr later, and we don't need these columns anyway)
* chooses only columns with names that have "mean" and "std", case insensitive
* adds data about which subject corresponds to each row and which activity type (presented as string)
* makes subject and activity columns the first in the data frame
* saves the data to "dirty.txt"
* generates and saves (to "tidy.txt") a tidy dataset where for each pair (subject, activity) the mean of each variable (names are in data/activity_labels.txt) is calculated. 

To explain the last point. Let's say we have following piced of data:

subject | activity | var1
------
1 | ACTIVITY1 | VAR1_VALUE1
------
1 | ACTIVITY1 | VAR1_VALUE2
------
1 | ACTIVITY2 | VAR_VALUE3


Then in the file "dirty.txt" data will be saved as it is.
In the file "tidy.txt" following data will be saved:

subject activity var1
subject | activity | var1
------
1 | ACTIVITY1 | mean(c(VAR1_VALUE1, VAR1_VALUE2))
------
1 | ACTIVITY2 | VAR_VALUE3

That is, since the pair subject="1" and  activity="ACTIVITY1" was present twice, the mean of corresponding var1 values was taken 

There is some more info in CodeBook.md