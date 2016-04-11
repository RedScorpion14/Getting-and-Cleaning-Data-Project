**Preparer:** Fazleali Pirbhai
**Assignment:** Getting and cleaning data – Coursera – John Hopkins University
**Project Name:** Human Activity Recognition Using Smartphones Data Set

**Data**
The files uploaded in github for this assignment are: -

1.	README.md
2.	Codebook.md
3.	Run_analysis.R

For this assignment, the data was downloaded from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 

Steps used for this assignments 
1.	Downloaded the original dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2.	Load the following datasets in R: -

**Data Frame	                  Original File Name**
activity_labels_raw	          activity_labels.txt
features_raw	                features.txt
x_test_raw	                  X_test.txt
y_test_raw	                  y_test.txt
Subject_test_raw	            subject_test.txt
x_train_raw	                  X_train.txt
y_train_raw	                  y_train.txt
Subject_train_raw	            subject_train.txt

3.	Merge the training and test data tables into one, namely ‘x_test_train’. This table has 10,299 observations and 561 variables.
4.	Extracted only measurements with either ‘mean’ or ‘std’ and saved to a new table ‘mean_std’
5.	Inserted the following variables in the above data frame: ‘subject’, ‘type_act’ and ‘activity_description’. 
6.	Then we labels the remaining variables.
7.	Finally, we summarize the table by grouping the table by subject,Type_Activity and activity description. For each of this group, we provide the mean for each variable. 

