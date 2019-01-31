---
title: "README"
output: html_document
---

The steps to obtain the tidy data set are these:

1 - First we read the X train data file, the activity labels, the Y data and the subject data

2 - Then we do the sama with the test data

3- We read he features file

4 - We then merge the training and the test sets to create one data set.

5 - We leave the columns with the mean and standard deviation for each measurement

6 - I take out the characters "()"" and "-"to make more readable the column names

7 - We set descriptive activity names to name the activities in the data set

8 - Build the data frame with the selected columns

9 - From the data set in step 8, we create an independent tidy data set with the  average of each variable for each activity and each subject.

10 - We export the data set to a text file


