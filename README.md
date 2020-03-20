Getting and Cleaning Data - Course Project

•	This is the course project for the Getting and Cleaning Data Coursera course.
•	The included R script, run_analysis.R, conducts the following:

1.	Read both the train and test datasets and merge them into DT3(subject), DAT3 (activity), and Train.set3 (measurements) respectively.
2.	Load the data 'feature', activity info and extract columns named 'mean'(-mean) and 'standard'(-std). Also, modify column names to descriptive(-mean to Mean, -std to Std, and remove symbols like -, (, )). 
3.	Read descriptive activity names to 'TESTnames' and merge it to the final data set(finalData).
5.	Generate Tidy Dataset(AT_Tidy) that consists of the average (mean) of each variable for each subject and each activity The result is shown in the file tidydata.txt.
