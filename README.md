# HumanActivityRecognition
Human Activity Recognition Project for Getting Data Course

## Purpose
The purpose of this project was to obtain and clean data related to the Human Activity Recognition Project.  
Details can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Content
This repository contains scripts that will get the raw data for the Human Activity Recognition experiments and through multiple transformation clean and save the tidy data.  
Components:
* getHARData.r
* run_analysis.R
* CodeBook.md

### GetHARData.r
* Downloads the zip file with raw data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Unzips the .zip file into the working directory
  * Data is unzipped into the "UCI HAR Dataset" folder

### run_analysis.R
The requirements for this script are:
* Merge the training and the test sets to create one data set.
* Extract only the measurements on the mean and standard deviation for each measurement. 
* Use descriptive activity names to name the activities in the data set
* Appropriately label the data set with descriptive variable names. 
* From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
Assumptions and decisions:
* The script assumes that extracted folders and files with raw data are in the "UCI HAR Dataset" folder under the working directory where the script is called from - default unzip location
* The script will create 2 separate files:
  * HARMeasurements.txt - file containing the cleaned dataset with only variables related to mean() and std()
  * HARAveragesLabels.txt - file containig all labels/column names of the final file
  * HARAveragesValues.txt - independent tidy data set with the average of each variable for each activity and each subject - final requirement of the project
* Output files will be saved in the working directory

I separated the download and analysis scripts in case the data scientist wants to use the same downloaded and unzipped raw files for varios analysis scripts.

## Result
The main output of this project is the HARAveragesValues.txt file in the working directory

## How to run this project
1. If you don't have the downloaded data, run, in R, _source("getHARData.r")_
  * If you do have the downloaded data please sure its top folder ("UCI HAR Dataset") is in the working directory
2. Run in R _source("run_analysis.R)_
