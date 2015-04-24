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
This script: 
* Downloads the zip file with raw data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Unzips the .zip file into ./RawData folder
  * The assumption is that the RawData folder already exists within the working directory where the scripts are called from

### run_analysis.R
The requirements for this script are:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Assumptions and decisions:
* The script assumes that extracted folders and files with raw data are in the ./RawData folder under the working directory where the script is called from
* The script will create 2 separate files:
  * HARAveragesLabels.txt - file containig all lavels/column names of the final file
  * HARAveragesValues.txt - independent tidy data set with the average of each variable for each activity and each subject - requirement of the project
* Output files will be saved in ./CleanedData folder

I separated the download and analysis scripts in case the data scientist wants to use the same downloaded and unzipped raw files for varios analysis scripts.
## Result
The output of this project is the HARAveragesValues.txt file under CleanedData folder

## How to run this project
1. In the working directory create a RawData folder
2. IN the working directory create a CleanedData folder
3. If you don't have the downloaded data, run, in R, source("getHARData.r")
  * If you do have the downloaded datam please it under RawData folder
4. Run in R source("run_analysis.R)
