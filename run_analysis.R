datacleaning <- function() {
  ## 1. Merging the training set and the test set
  
  ## Creating one table containing all data for the training set
  ## With a table with a first column for subject, then X on the right, then y
  data<-read.table("UCI HAR Dataset/train/subject_train.txt")
  X<-read.table("UCI HAR Dataset/train/X_train.txt")
  data<-cbind(data, X)
  Y<-read.table("UCI HAR Dataset/train/y_train.txt")
  data<-cbind(data,Y)
  ## Same operation for the test set
  databis<-read.table("UCI HAR Dataset/test/subject_test.txt")
  X<-read.table("UCI HAR Dataset/test/X_test.txt")
  databis<-cbind(databis, X)
  Y<-read.table("UCI HAR Dataset/test/y_test.txt")
  databis<-cbind(databis,Y)
  ## Merging both data sets
  bigdata<-rbind(data, databis)
  
  ## 2. Extracts only the measurements on mean and std for each measurement
  
  ## Subsets according to the matching column, using infos from the features
  ## and including first and last column (subject and activity)
  selection<-c(0,1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,266:271,345:350,424:429,503:504,529:530,562)+1
  bigdata<-bigdata[,selection]
  
  ## 3. Uses descriptive activity names to name the activities
  
  ## Match numbers and activity names in an extra column added to the data frame
  activity<-c("WALKING"=1, "WALKING UPSTAIRS"=2, "WALKING DOWNSTAIRS"=3, "SITTING"=4, "STANDING"=5, "LAYING"=6)
  bigdata<-cbind(names(activity)[match(bigdata[,62], activity)], bigdata)
  head(bigdata,5)
  
  ## 4. Appropriately labels the data set with descriptive variable names
  
  ## Get variable names
  selection2<-c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,266:271,345:350,424:429,503:504,529:530)
  noms<-read.table("./UCI HAR Dataset/features.txt")
  noms<-as.character(noms[selection2,2])
  a<-c("activity", "subject")
  b<-c("activitynumber")
  noms<-as.vector(c(a, noms, b))

  ## Replace column names with the new names
  colnames(bigdata)<-noms
  
  
  ## 5.  creates a second, independent tidy data set with the average of
  ## each variable for each activity and each subject
  
  ## Rearrange according by activity and subject
  library(dplyr)
  smalldata<-tbl_df(bigdata[,1:62])
  smalldata<-arrange(smalldata, activity, subject)
  ## Group and average by activity and subject
  result<-smalldata %>% group_by(activity, subject) %>% summarise_each(funs(mean))
  print(head(result, 5))
  
  ## Create text file for the results
  write.table(result, file="results.txt", row.name=FALSE)
}
