## Human Recognition Activity Using Smartphones Project  - Data Cleanup
##

## Script requirements:
## 1. Merge the training and the test sets to create one data set.
## 2. Extract only the measurements on the mean and standard deviation for each measurement.
## 3. Use descriptive activity names to name the activities in the data set
## 4. Appropriately label the data set with descriptive variable names.
## 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

## This script assumes that data is already downloaded (and unzipped) in the same directory 
## where this script is located.

library(plyr)    
rawDataFilePath <-  file.path(".","RawData","UCI HAR Dataset")
#### ----------   Get the column Ids and columns Names from features.txt that we need   ---------- ####
    
#   First column of this data.frame are column Ids for X-train and X_test datasets that we'll extract
#   Second column will be column names for X-train and Xtest datasets
    
featureList <- read.table(file.path(rawDataFilePath,"features.txt"))
    
# Extract rows that are related to mean() and std() measurements
#   filteredFeatures contains colimn Ids and column Names we need to keep in X-train and X-test
filteredFeatures <- featureList[(grepl("mean()",featureList[,2], fixed = TRUE)|grepl("std()",featureList[,2], fixed = TRUE)),]
colIds <- filteredFeatures[,1]
colNames <- filteredFeatures[,2]
    
# Column Name Clean-up - getting rid of (), fixing "BodyBody" and using Camel Case
colNames <- sub("()", "", filteredFeatures[,2], fixed = TRUE)
colNames <- sub("BodyBody", "Body", colNames, fixed = TRUE)
colNames <- sub("tBodyAcc", "TimeBodyAccelerometer", colNames, fixed = TRUE)
colNames <- sub("tGravityAcc", "TimeGravityAccelerometer", colNames, fixed = TRUE)
colNames <- sub("fBodyAcc", "FrequencyBodyAccelerometer", colNames, fixed = TRUE)
colNames <- sub("fGravityAcc", "FrequencyGravityAccelerometer", colNames, fixed = TRUE)
colNames <- sub("tBodyGyro", "TimeBodyGyroscope", colNames, fixed = TRUE)
colNames <- sub("tGravityGyro", "TimeGravityGyroscope", colNames, fixed = TRUE)
colNames <- sub("fBodyGyro", "FrequencyBodyGyroscope", colNames, fixed = TRUE)
colNames <- sub("fGravityGyro", "FrequencyGravityGyroscope", colNames, fixed = TRUE)
colNames <- sub("Mag", "Magnitude", colNames, fixed = TRUE)
colNames <- sub("-","",colNames, fixed = TRUE)
colNames <- sub("-X","DirectionX",colNames, fixed = TRUE)
colNames <- sub("-Y","DirectionY",colNames, fixed = TRUE)
colNames <- sub("-Z","DirectionZ",colNames, fixed = TRUE)
colNames <- data.frame(colNames)
colNames <- apply(colNames, 1:2, function(x) {
                if (grepl("mean",x, fixed = TRUE)) {
                    x <- paste("MeanOf",sub("mean", "", x, fixed = TRUE),sep = "")
                }else {
                    if (grepl("std",x, fixed = TRUE)){
                        x <- paste("StdOf",sub("std", "", x, fixed = TRUE),sep = "")
                    } else {
                        x <- x
                    }
                }})
    
#### ----------   X-train   ---------- ####
#### ----------   Load X-train file and keep only columns that are realted to mean() or std()   ---------- ####
    
XTrainRaw <- read.table(file.path(rawDataFilePath,"train","X_train.txt"))
XTrain <- XTrainRaw[,colIds]   # Column Ids are already extracted from features.txt (colIds)
names(XTrain) <- colNames[,1]
    
# Add a column for the subject
# First load subject data for train subset
trainSubjects <- read.table(file.path(rawDataFilePath,"train","subject_train.txt"))
XTrain$subject <- trainSubjects[,1]
    
# Add column for the activity type
# That is stored in y-train - let's load that first
trainActivities<- read.table(file.path(rawDataFilePath,"train","y_train.txt"))
XTrain$activityId <- trainActivities[,1]
    
#### ----------   X-test   ---------- ####
#### ----------   Load X-test file and keep only column that are realted to mean() or std()   ---------- ####
    
XTestRaw <- read.table(file.path(rawDataFilePath,"test","X_test.txt"))
XTest <- XTestRaw[,colIds]   # Column Ids are already extracted from features.txt (colIds)
names(XTest) <- colNames[,1]
    
# Add a column for the subject
# First load subject data for test subset
testSubjects <- read.table(file.path(".","RawData","UCI HAR Dataset","test","subject_test.txt"))
XTest$subject <- testSubjects[,1]
    
# Add column for the activity type
# That is stored in y-train - let's load that first
testActivities<- read.table(file.path(rawDataFilePath,"test","y_test.txt"))
XTest$activityId <- testActivities[,1]
    
#### ----------   Merge the 2 datasets   ---------- ####
    
XMerged <- rbind(XTrain,XTest)
    
#### ----------   Load activities (activity_labels.txt first   ---------- ####
    
activityLabels <- read.table(file.path(rawDataFilePath,"activity_labels.txt"))
names(activityLabels) <- c("activityId", "activityName")
# Renaming activity labels - fixing typo and looking nicer
activityLabels$activityName <- c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Lying")
    
# Replace the activityId column with activity label
# by using merge() function
XMeasurements <- merge(XMerged,activityLabels,"activityId")
    
#Eliminating "activityId" column from the dataset
drops <- c("activityId")
XMeasurements <- XMeasurements[,!(names(XMeasurements) %in% drops)]
    
#### ----------   Calculate average values for each column per subject/activityName combination   ---------- ####
    
avgValues <- ddply(XMeasurements, .(subject,activityName), function(v){x <- v[,1:66]; colMeans(x)})
names(avgValues) <- paste("avgOf",names(avgValues),sep = "")
colnames(avgValues)[1] <- "subject"
colnames(avgValues)[2] <- "activityName"
write.table(data.frame(names(avgValues)), "./CleanedData/HARAveragesLabels.txt", row.names = FALSE, sep = "\t", quote = FALSE)
write.table(avgValues, "./CleanedData/HARAveragesValues.txt", sep = "\t", row.names=FALSE, quote = FALSE)