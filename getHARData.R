## Human Recognition Activity Using Smartphones Project  - Data Download

## I decided to separate data download from the actual data clean-up 
## since the data scientist may choose to write different data processing scripts 
## for the same underlying downloaded data set

## Location of all the data and info:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Location of the datasets:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#### ----------------   Download the .zip file   ------------------ ####

url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
tempZipFile = "./RawData/downloadedZipFile.zip"
download.file(url, tempZipFile, method = "curl") 
print(paste("....  ","downloaded from",url,"into", tempZipFile, sep = " "))

#### -----------------  Unzip the file   -----------------------####

unzip(tempZipFile, overwrite = FALSE, exdir = "./RawData") 
# It unzips the file into "UCI HAR Dataset" folder and subfolders "train" and "test"....
print(paste("....  ","unzipped file", tempZipFile, sep = " "))
