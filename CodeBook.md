#Overview
The "raw" data is obtained vrom the project [Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) dataset.

The processing is done in two steps.  
The raw data is divided into training and test sets that have identical structure.
During the first step of processing each of these sets goes through the following conversion:
1. values for the subject and activity are added for each measurement 
2. only the values representing mean and standard deviation are taken
3. the variable descriptive names are used as the measurment column labels  
After this conversion the test and training data sets are merged to create one data set, which is writtent into the file *X_test_and_train.txt* 

On the second step mean values are calculated for each variable, aggregated by the subject and activity. The result of this calculation is written into the file *X_mean_by_subject_activity.txt*

#Step 1 details

To perform the required transformation the script does the following:
1.read the variable names from the file *features.txt*
2.creates the index vector of the names containing substrings "mean()" or "std()"
3.since the bracket characters are illegal for the column names, remove those characters from the variable names read on step 1.
4. read the activity labels from the file *activity_labels.txt*  
The data obtained in steps 1 to 4 is common for the test and training sets, and is used for processing each of them.  

The data sets have identical structure, the only difference is in the file names. The test files have *test* in their names, whereas training files have *train* in their names. The script builds the file names dynamically, and the processing logic is exactly the same. The steps for each data set are as follows:
5. read the activity numbers from the *y_...txt* file, and replace the numbers with labels from the step 4
6. read the subjects from the file *subject_...txt*
7. read the measurements data from the *X_...txt* file, using the vector obtained on step 3 as the column names, and apply the index vector obtained on step 2 to select only the mean and standard deviation columns.
8. construct the result data frame from the subject column from step 6, activity column from step 5, and the data columns from step 7
9. the data frames received from processing of the test and train data sets are vertically merged

# Step 2 details

The second step is simple - the aggregate function is applied to the data frame received on  the first step.

# The variables of the resulting data sets

Both data sets are built from the same variables:  
* subject - identifies the person performing the activity. Range from 1 to 30
* activity - one of the 6 activities:
  +WALKING
  +WALKING_UPSTAIRS
  +WALKING_DOWNSTAIRS
  +SITTING
  +STANDING
  +LAYING
* The semantics of the following feature vector variables are described in the features_info.txt file of the original data set. Note that for each variable we keep the mean and std values
  +tBodyAcc-XYZ
  +tGravityAcc-XYZ
  +tBodyAccJerk-XYZ
  +tBodyGyro-XYZ
  +tBodyGyroJerk-XYZ
  +tBodyAccMag
  +tGravityAccMag
  +tBodyAccJerkMag
  +tBodyGyroMag
  +tBodyGyroJerkMag
  +fBodyAcc-XYZ
  +fBodyAccJerk-XYZ
  +fBodyGyro-XYZ
  +fBodyAccMag
  +fBodyAccJerkMag
  +fBodyGyroMag
  +fBodyGyroJerkMag
