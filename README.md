#Getting and Cleaning Data Course Project

This folder contains the following files:
* CodeBook.md - describes the input and output data and the transformations
* run_analysis.R - script performing the transformation.

To reproduce the transformation put the directory *UCR HAR Dataset* of the original data set under the working folder. 
Run the run_analysis() function defined in the script. The result of the processing is the file subject_activity_summary.txt written in the working folder.  

To perform the required transformation the script does the following:  
1. read the variable names from the file *features.txt*  
2. create the index vector of the names containing substrings "mean()" or "std()"  
3. since the bracket characters are illegal for the column names, remove those characters from the variable names read on step 1.  
4. read the activity labels from the file *activity_labels.txt*   
The data obtained in steps 1 to 4 is common for the test and training sets, and is used for processing each of them.  

The test and train data sets have identical structure, the only difference is in the file names. The test files have *test* in their names, whereas training files have *train* in their names. 
The script defines a nested function *readDataSet* that accepts the direcory name as a parameter and builds the file names dynamically. 
The processing logic for both directories is exactly the same with the following steps:  
5. read the activity numbers from the *y_...txt* file, and replace the numbers with labels from the step 4  
6. read the subjects from the file *subject_...txt*  
7. read the measurements data from the *X_...txt* file, using the vector obtained on step 3 as the column names, and apply the index vector obtained on step 2 to select only the mean and standard deviation columns.  
8. construct the result data frame from the subject column from step 6, activity column from step 5, and the data columns from step 7  
9. the data frames received from processing of the test and train data sets are vertically merged  
10. the aggregate function is applied to the dataset received in the step 9 to calculate mean values to all the data columns, grouped by subject and activity.  
11. the result data frame is written to the file *subject_activity_summary.txt*


