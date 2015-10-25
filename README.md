# Getting and Cleaning Data Course Project

### Assumptions

The data has been extracted to the same folder as the script "run_analysis.R", i.e. the expected folder structure is

	./
	./run_analysis.R
	./UCI HAR Dataset/activity_labels.txt
	./UCI HAR Dataset/features.txt
	./UCI HAR Dataset/test/subject_test.txt
	./UCI HAR Dataset/test/X_test.txt
	./UCI HAR Dataset/test/y_test.txt
	./UCI HAR Dataset/train/subject_train.txt
	./UCI HAR Dataset/train/X_train.txt
	./UCI HAR Dataset/train/y_train.txt


### Description of "run_analysis.R"

The script performs the following actions

* Loads the list of column names from "./UCI HAR Dataset/features.txt"
	* Create a column filter for those columns which are standard deviation and mean measurements

* Loads the training data from "./UCI HAR Dataset/train/subject_train.txt"
	* Applies the column filter
	* Loads the data for which activity each row represents from "./UCI HAR Dataset/train/y_train.txt"
	* Loads the data for which subject each row represents from "./UCI HAR Dataset/train/subject_train.txt"
	* Binds the activity and subject data to the training data

* Loads the test data from "./UCI HAR Dataset/test/X_test.txt"
	* Applies the column filter
	* Loads the data for which activity each row represents from "./UCI HAR Dataset/test/y_test.txt"
	* Loads the data for which subject each row represents from "./UCI HAR Dataset/test/subject_test.txt"
	* Binds the activity and subject data to the training data

* Combine the training and test data into one dataset
	* Read the activity labels from "./UCI HAR Dataset/activity_labels.txt"
	* Join the activity labels onto the dataset
	* Remove the ActivityID column as no longer needed

* Group the data by SubjectID and Activity and calculate the mean average of each column
* Write the resulting data out to "./Average_measurements.txt"
	* See "./CodeBook.txt" for an explanation of the fields

