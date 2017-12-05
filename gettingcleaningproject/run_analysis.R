# The script's working directory must be set to the train and test
# parent directory.


if (require(dplyr) == FALSE) {
  install.packages("dplyr")
  library(dplyr)
}

features <- read.delim("features.txt", header=FALSE, sep="")
features <- unlist(features[2])

movements <- read.delim("activity_labels.txt", header=FALSE, sep="")

xtest <- read.delim("test/X_test.txt", header=FALSE, sep="", col.names=features)
xtrain <- read.delim("train/X_train.txt", header=FALSE, sep="", col.names=features)
ytest <- read.delim("test/y_test.txt", header=FALSE, sep="", col.names=c("movement"))
ytrain <- read.delim("train/y_train.txt", header=FALSE, sep="", col.names=c("movement"))
subjecttest <- read.delim("test/subject_test.txt", header=FALSE, sep="", col.names=c("subject"))
subjecttrain <- read.delim("train/subject_train.txt", header=FALSE, sep="", col.names=c("subject"))
rm(features)

xdataset <- rbind(xtest, xtrain)
ydataset <- rbind(ytest,ytrain)
subjectdataset <- rbind(subjecttest, subjecttrain)

rm(xtest)
rm(ytest)
rm(xtrain)
rm(ytrain)
rm(subjecttest)
rm(subjecttrain)

fitdata <- cbind(subjectdataset, xdataset, ydataset)

rm(xdataset)
rm(ydataset)
rm(subjectdataset)

### 1. End of dataset merge process
### 2. Mean and std measurement selection
fitdata <- select(fitdata, matches("subject|movement|mean()|std()"))

### 3. Descriptive names for movements
fitdata$movement <- movements[fitdata$movement,2]

### 4. Appropriate variable names
names(fitdata) <- tolower(gsub("\\.", "", names(fitdata)))


### 5. Avg for each activity per subject
fitsummary <- group_by(fitdata, subject, movement) %>% summarize_all("mean")

