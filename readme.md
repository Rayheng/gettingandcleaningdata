---
Title: "run_analysis_Cookbook"
Author: "Heng Rui Jie"
Date: "22 August, 2015"
Output: html_document
---

1. Purposes of the Readme Markdown file:
- Provides the overview of the key challenges faced and assumptions made in the course of producing the final tidy data
- Gives an overall approach in getting and cleaning the data for run_analysis.R
- Describes the labels/variable names in the final tidy data for the user to use and explore the dataset further

Note: run_analysis.R contains the comments that depict the various functions used throughout the R script. Reader may refer to the script itself for more details on the producing the final tidy data

2. Getting and Cleaning Data Approach
2.1 Key Challenges
  One of the key challenges faced in producing the data is to merge/join data across various files which does not contain the necessary header row. While the course project only requires the extraction of mean and standard deviation features, there is no explicit mention of which feature name to include/exclude. Assumptions are made along the way to produce the final result.

2.2 Assumptions Made
* The respective columns in X_Train.txt and X_Test.txt are ordered with the sequence in Features.txt. E.g. we can assume the first column in X_Train refers to the first row in Features.txt
* Only variable with mean() and std() are considered for the final tidy data
* the Train and Test data could be merged without the need later to distinguish between Training and Testing data
* the Inertia folder data is not required as the data in the training and test set are sufficient (after retaining only mean and std calculated fields)

2.3 Approach on processing the data
2.3.1 Process main Data such as activity, feature
2.3.2 Further process the feature data to extract only mean() and std()
2.3.3 Process the Subject Data
2.3.4 Process the Activty Data
2.3.5 Process the measurements Data
2.3.6 Column bind/Append all together
2.3.7 Improve the description of the Activity with Activity labels
2.3.8 Calculate the average to form the final tidy data

3. Variables Description

3.1 Overall Naming Convention
- ID_ refers to unique Identificatio number of the variable
- NM_ refers to the label name
- TIME_ refers to the Time component of the feature
- FREQ_ refers to the Frequency component of the feature
- _MEAN_ refers to the mean() calculation
- _STD_ refers to the std() calculation

3.1 ID_SUBJECT
  This is the unique ID that identifies the 30 different volunteers that participated in the 

3.2 ID_ACTIVTY
  This is the unique ID for activities
  
3.3 NM_ACTIVITY
  Contains the actual label of the activities which are mapped to the ID_ACTIVITY as follows:
---  
ID_ACTIVITY        NM_ACTIVITY
---
1                       WALKING
2              WALKING_UPSTAIRS
3            WALKING_DOWNSTAIRS
4                       SITTING
5                      STANDING
6                        LAYING

3.4 Remaining Features Columns
  The feature columns are largely retained in its naming convention as of source (feature_info.txt). Only a slight modification to the variables name to make it more readable.
  For example.
  * t has been replaced by TIME_
  * f has been replaced by FREQ_
  * mean() has been replaced by _MEAN_
  * std() has been replaced by _STD_

4. Tidy Data Output:  Result.txt
  The final output result produces the average of the features at each subject and activities grouping. Hence, the final output has 180 rows (30 volunteers by 6 different activities).

*** End of Readme.md ****


