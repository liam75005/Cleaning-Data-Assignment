# Cleaning-Data-Assignment
Documents for the Coursera Assigment in course "Getting and Cleaning Data"

How the script works

The script contains only one file : run_analysis.R with one function named "datacleaning" that needs to be run. 
To make use of the script, you have to download the run_analysis.R file in your working directory and then 
source the file and finally run the following command line :

datacleaning()

To use the script on the  UCI HAR Dataset, this data set needs to be downloaded
and unzipped into your working directory within a folder named "UCI HAR Dataset" that will contain
both subfolders "train" and "test" containing the text files of the dataset.

Then, once the function datacleaning() will be called the script will :
1. Merging the training set and the test set
Create one table containing all data for the training set with a table with a first column for subject, 
then X on the right, then y. The same operation will then be performed for the test set.
Both set will then be merged with rbind. It may take a few minutes as the data set is quite big.

2. Extracts only the measurements on mean and std for each measurement
The script will subset according to the matching column, using infos from the features and including 
first and last column (subject and activity).

3. Uses descriptive activity names to name the activities
Match numbers and activity names in an extra column added to the data frame, using the match function.

4. Appropriately labels the data set with descriptive variable names
The script will get variable names and replace column names with the new names, using colnames.

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
Using the dplyr package (although it could have been used earlier in the program), the script will first rearrange 
the data by activity and subject and then group and average by activity and subject. 

Finally it creates a text file in the working directory named "results.txt" containing the second tidy data set.
