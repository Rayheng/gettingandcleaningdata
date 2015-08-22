## Coursera: Data Science Specialization
## Subject: Getting and Cleaning Data
## Project: Course Project 1
## Author : Heng Rui Jie
## Date   : 22nd August 2015

## Initalization
#   Set up working directory and loading of library
#
setwd("/Users/kilopy82/Coursera/Data Science Specialization/Getting and Cleaning Data/Week3/Course Project/UCI HAR Dataset")

library(dplyr)
library(Hmisc)
library(reshape2)
# Approach
# 1. Process Main Data such as activity, feature
# 2. Further process the feature data to extract only mean() and std()
# 3. Process the Subject Data
# 4. Process the Activty Data
# 5. Process the measurements Data
# 6. Column Append all together
# 7. Improve the description of the Activity with Label
# 8. Calculate the average to form the tidy data

## 1. Process Main Data
## Extract the Main Labels for Activity and Feature Measured
activity_label_File <- "./activity_labels.txt"
activity_label_Data <- read.table(file=activity_label_File, header=FALSE, col.names = c("ID_ACTIVITY", "NM_ACTIVITY"))

feature_label_File <- "./features.txt"
feature_label_Data <- read.table(file=feature_label_File, header=FALSE, col.names = c("ID_FEATURE", "NM_FEATURE"))

## 2. Further process the feature data to extract only mean() and std()
# Use of Regular Expression to tidy the variable naming 

feature_label_Data <- feature_label_Data %>% mutate(NM_FEATURE = sub("(^t)(+)" , "TIME_\\2", NM_FEATURE)) %>%
  mutate(NM_FEATURE = sub("(^f)(+)" , "FREQ_\\2", NM_FEATURE)) %>%
  mutate(NM_FEATURE = sub("(+)(-mean\\(\\)[-]*)(*)" , "\\1_MEAN_\\3", NM_FEATURE)) %>%
  mutate(NM_FEATURE = sub("(+)(-std\\(\\)[-]*)(*)" , "\\1_STD_\\3", NM_FEATURE))                          

# Assumption: Extract only features of its Mean or Standard Deviation calculation
# Note that for mean, the label contains "mean()" 
# Note that for standard deviation, the label contains "std()"

# Extract the various index of the label
label_Mean_FUN <- grep("_MEAN_" , feature_label_Data$NM_FEATURE) 
label_Std_FUN <- grep("_STD_" , feature_label_Data$NM_FEATURE)

# Perform the necessary processing to ensure the indices are unique and sorted
require_Feature_list <- data.frame(ID_FEATURE = c(label_Mean_FUN,label_Std_FUN))
require_Feature_list$ID_FEATURE <- unique(require_Feature_list$ID_FEATURE)
require_Feature_list <- require_Feature_list[order(require_Feature_list$ID_FEATURE), ]

# Retrieve all labels that are required for the exercise
# requireFeatures_label <- feature_label_Data[require_Feature_list$ID_FEATURE, ]


## 3. Process the Subject Data
## Extract data from the train folder
subject_Train_File <- "./train/subject_train.txt"
subject_Train_Data <- read.table(file=subject_Train_File, header=FALSE, col.names = c("ID_SUBJECT"), colClasses = c("integer"))

## Extract data from the test folder
subject_Test_File <- "./test/subject_test.txt"
subject_Test_Data <- read.table(file=subject_Test_File, header=FALSE, col.names = c("ID_SUBJECT"), colClasses = c("integer"))

# Append the train and test subject data together
subject_data <- rbind(subject_Train_Data, subject_Test_Data)


## 4. Process the Activty Data
## Extract data from the train folder
activity_Train_File <- "./Train/y_train.txt"
activity_Train_Data <- read.table(file=activity_Train_File, header=FALSE, col.names = c("ID_ACTIVITY"), colClasses = c("integer"))

## Extract data from the test folder
activity_Test_File <- "./Test/y_test.txt"
activity_Test_Data <- read.table(file=activity_Test_File, header=FALSE, col.names = c("ID_ACTIVITY"), colClasses = c("integer"))

activity_data <- rbind(activity_Train_Data, activity_Test_Data)


## 5. Process the measurements Data
## Extract data from the train folder
measurement_Train_File <- "./train/X_train.txt"
measurement_Train_Data <- read.table(file=measurement_Train_File, header=FALSE, col.names = feature_label_Data$NM_FEATURE, colClasses = c("numeric"))

## Extract data from the test folder
measurement_Test_File <- "./test/X_test.txt"
measurement_Test_Data <- read.table(file=measurement_Test_File, header=FALSE, col.names = feature_label_Data$NM_FEATURE, colClasses = c("numeric"))

measurement_data <- rbind(measurement_Train_Data, measurement_Test_Data)

measurement_data_subset <- select(measurement_data , require_Feature_list)


## 6. Column Append all together
tidy_data <- cbind(subject_data, activity_data, measurement_data_subset)

## 7. Improve the description of the Activity with Label

tidy_data_final <- merge(y=tidy_data, x =activity_label_Data, by.x="ID_ACTIVITY" , by.y="ID_ACTIVITY" )

## 8. Calculate the average to form the tidy data

# Prepare the tidy data into subsets. Group by ID_SUBJECT and NM_ACTIVITY
tidy_data_group <- select(tidy_data_final, ID_SUBJECT, NM_ACTIVITY)
tidy_data_col <- select(tidy_data_final, -(ID_ACTIVITY:ID_SUBJECT)) 

# Aggregate the data by ID_SUJBECT and NM_ACTIVITY. Sort the final output
result <- aggregate(tidy_data_col, tidy_data_group, mean)
result <- result[order(result$ID_SUBJECT) ,]

# Output results to text file
write.table(x=result, file="./result.txt", row.names = FALSE, sep=",")
