# GetDataProj2
course project 2 in the getting data course

To run the program in the file, run_analysis.R, you need to run the following command in R-Studio:
Run_Analysis()

Prior to that, copy the input files along with the directories "UCI HAR Dataset" and its subdirectories in your working directory. This function will read all the input files assuming they are in the above mentioned directory or its subdirectories.

And when you run the function, Run_Analysis(), it will create a text file called tidy.txt in your working directory. This is a comma separated file containing 180 rows and 81 columns as described below:
The 180 rows are for 30 subjects doing 6 different activities with each activity in one row. The first 2 columns in each row are "SUBJECT" and "ACTIVITY".
The SUBJECT column contains a number between 1 and 30 which is a number denoting each of the 30 subjects.
The ACTIVITY column contains one of the 6 different activities performed - "WALKING", "WALKING UPSTAIRS", "WALKING DOWNSTAIRS", "SITTING", "STANDING", and "LAYING"
The other 79 columns are a subset of the original data columns. These are columns that have either a standard deviation or a mean of the measurements. The value itself is an average value (mean) for each subject and the activity.
Since there are 30 subjects and 6 different activities, the new data set contains 30 x 6 = 180 rows with each column containing the mean value for each group - that is, each subject and each activity.
