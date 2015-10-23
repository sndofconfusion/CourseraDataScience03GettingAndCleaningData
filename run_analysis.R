# Getting and Cleaning Data - Course Project


# load libraries
library(data.table)
library(dplyr)



# load and filter column names

    # load column names
    colsAll <- fread("./UCI HAR Dataset/features.txt")
    
    
    # filter columns for standard deviation and mean measurements
    colsForOutput <- colsAll[grep('std\\(\\)|mean\\(\\)', colsAll$V2),]

    

# load training data and tidy up

    # load training data and filter for required fields
    dataTrain <- fread("./UCI HAR Dataset/train/X_train.txt", col.names = colsAll$V2)
    dataTrain <- select(dataTrain, colsForOutput$V1)
    

    # load activities and subjects for training data set
    activityTrain <- fread("./UCI HAR Dataset/train/y_train.txt", col.names=c("ActivityID"))
    subjectTrain <- fread("./UCI HAR Dataset/train/subject_train.txt", col.names=c("SubjectID"))
    
    
    # add activity & subject IDs to training data set
    dataTrain <- bind_cols(dataTrain, activityTrain, subjectTrain)
    
    
    
# load test data and tidy up
    
    # load test data and filter for required fields
    dataTest <- fread("./UCI HAR Dataset/test/X_test.txt", col.names = colsAll$V2)
    dataTest <- select(dataTest, colsForOutput$V1)
    

    # load activities and subjects for test data set
    activityTest <- fread("./UCI HAR Dataset/test/y_test.txt", col.names=c("ActivityID"))
    subjectTest <- fread("./UCI HAR Dataset/test/subject_test.txt", col.names=c("SubjectID"))
    
    
    # add activity & subject IDs to test data set
    dataTest <- bind_cols(dataTest, activityTest, subjectTest)

    

# combine training & test data, and add activity labels
    
    #combine data sets
    dataAll <- bind_rows(dataTrain, dataTest)


    # load activity labels
    activityLabel <- fread("./UCI HAR Dataset/activity_labels.txt", col.names=c("ActivityID", "Activity"))
    
    
    # join activity labels onto combined data set and remove ActivityID
    dataAll <- inner_join(as.data.table(dataAll), activityLabel, by=c("ActivityID" = "ActivityID"))
    dataAll <- select(dataAll, -ActivityID)    
    
    
    
# find averages per subject & activity
    
    # group by and summerise data
    avgMeasure <- summarise_each(group_by(dataAll, SubjectID, Activity), funs(mean))


    # write summary to text file
    write.table(avgMeasure, file="./Average_measurements.txt", row.names=FALSE)


