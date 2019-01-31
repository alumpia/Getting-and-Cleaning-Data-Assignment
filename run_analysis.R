# Purpose of this file:
# 1 - Merge the training and the test sets to create one data set.
# 2 - Extract only the measurements on the mean and standard deviation for each measurement.
# 3 - Use descriptive activity names to name the activities in the data set
# 4 - Appropriately label the data set with descriptive variable names.
# 5 - From the data set in step 4, create a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
library(dplyr)

 
# directory<-"C:/Users/Familia/Dropbox/Maria/R/R Programming/Data cleaning/project assignment"
# setwd(directory)


#read train data
#561-feature vector with time and frequency domain variables
X_train_variables<-read.table("train/X_train.txt")
#activity labels 
activity_labels<-read.table("activity_labels.txt")
Y_train_activity_labels<-read.table("train/Y_train.txt")
#dentifier of the subject who carried out the experiment.
train_activity_subjects<-read.table("train/subject_train.txt")

#read test data
#561-feature vector with time and frequency domain variables
X_test_variables<-read.table("test/X_test.txt")
#activity labels 
Y_test_activity_labels<-read.table("test/Y_test.txt")
#dentifier of the subject who carried out the experiment.
test_activity_subjects<-read.table("test/subject_test.txt")

#read features.txt file
features_file<-read.table("features.txt")


# 1 - Merge the training and the test sets to create one data set.
#merge features
features_df<-X_train_variables
features_df<-rbind (features_df, X_test_variables)
#merge labels
labels_df<-Y_train_activity_labels
labels_df<-rbind(labels_df, Y_test_activity_labels)
#merge subjects
subjects<-train_activity_subjects
subjects<-rbind(subjects, test_activity_subjects)
colnames(subjects)<-c("subject_id")

# 2 - Extract only the measurements on the mean and standard deviation for each measurement.
# get the columns names related with mean and sd
mean_ids<-grep("mean", features_file[,2])
std_ids<-grep("std", features_file[,2])
columns_ids_selected<-c(mean_ids, std_ids)
columns_names_selected<-features_file[columns_ids_selected, ]

features<-features_df[, columns_ids_selected]
colnames(features)<-columns_names_selected$V2
#slightly rename the colnames by taking out () and -
colnames(features) <- gsub('[(][)]', '', colnames(features)) 
colnames(features) <- gsub('[-]', '', colnames(features)) 

# 3 - Use descriptive activity names to name the activities in the data set
activity<-factor(x=labels_df$V1, levels = activity_labels$V1, labels = activity_labels$V2)

# 4 - Appropriately label the data set with descriptive variable names.
data_set<-data.frame()
data_set<-cbind(subjects, activity, features)

# 5 - From the data set in step 4, create a second,str independent tidy data set with the 
# average of each variable for each activity and each subject.
tidy_data_set<-group_by(data_set,subject_id, activity)
tidy_data_set<-summarize_at(tidy_data_set, 3:81, mean)

#export the data set to a text file
write.table(tidy_data_set, "tidy_data_set.txt", row.name=FALSE)

