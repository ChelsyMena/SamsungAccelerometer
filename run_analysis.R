# run_anaysis.R
# Chelsy M (GitHub: TwoPointNo)

setwd("./Data Science/Rcodes")

library(stringr) # for the str_split_fixed function

features <- read.delim("./UCI HAR Dataset/features.txt",header=F)
for (i in 1:length(features[,1])){
  features[i,1] <- sub("^[0-9] ","",features[i,1])
  features[i,1] <- sub("^[0-9]. ","",features[i,1])
  features[i,1] <- sub("^[0-9].. ","",features[i,1])
  features[i,1] <- trimws(features[i,1])}

test<- read.delim("./UCI HAR Dataset/test/X_test.txt",header=F)
test[,1] <- gsub("  "," ",test[,1])
test <- str_split_fixed(test[,1]," ",562)
test <- test[,2:562]
testlabels <- read.delim("./UCI HAR Dataset/test/y_test.txt",header=F)
subjecttest <- read.delim("./UCI HAR Dataset/test/subject_test.txt",header=F)
test <-cbind(subjecttest,testlabels,test)

training <- read.delim("./UCI HAR Dataset/train/X_train.txt",header=F)
training[,1] <- gsub("  "," ",training[,1])
training <- str_split_fixed(training[,1]," ",562)
training <- training[,2:562]
traininglabels <- read.delim("./UCI HAR Dataset/train/y_train.txt",header=F)
subjecttrain <- read.delim("./UCI HAR Dataset/train/subject_train.txt",header=F)
training <- cbind(subjecttrain,traininglabels,training)

# Merges the training and the test sets to create one data set
data <- rbind.data.frame(test,training)

# Appropriately labels the data set with descriptive variable names.
# Extracts only the measurements on the mean and standard deviation for each measurement
colnames(data) <- c("SUBJECT","ACTIVITY",features[,1])
indexmean <- grep("mean", colnames(data))
indexstd <- grep("std", colnames(data))
data <- data[,c(1,2,indexmean,indexstd)]

# Uses descriptive activity names to name the activities in the data set
for (i in 1:length(data[,2])){
  data[i,2] <- sub("1","WALKING",data[i,2])
  data[i,2] <- sub("2","WALKING_UPSTAIRS",data[i,2])
  data[i,2] <- sub("3","WALKING_DOWNSTAIRS",data[i,2])
  data[i,2] <- sub("4","SITTING",data[i,2])
  data[i,2] <- sub("5","STANDING",data[i,2])
  data[i,2] <- sub("6","LAYING",data[i,2])
}

# From the data set in step 4, creates a second, independent tidy data set with the
# average of each variable for each activity and each subject.
for (i in 1:79){
  data[,(i+2)] <- as.numeric(data[,(i+2)])}

averages <- data.frame()
for (i in 1:30){
  datai <- data[which(data$SUBJECT == i),]
  datai <- datai[datai$ACTIVITY == "WALKING",3:81]
  means <- colMeans(datai)
  averages <- rbind(averages,c(i,"WALKING",means))
  
  datai <- data[which(data$SUBJECT == i),]
  datai <- datai[datai$ACTIVITY == "WALKING_UPSTAIRS",3:81]
  means <- colMeans(datai)
  averages <- rbind(averages,c(i,"WALKING_UPSTAIRS",means))
  
  datai <- data[which(data$SUBJECT == i),]
  datai <- datai[datai$ACTIVITY == "WALKING_DOWNSTAIRS",3:81]
  means <- colMeans(datai)
  averages <- rbind(averages,c(i,"WALKING_DOWNSTAIRS",means))
  
  datai <- data[which(data$SUBJECT == i),]
  datai <- datai[datai$ACTIVITY == "SITTING",3:81]
  means <- colMeans(datai)
  averages <- rbind(averages,c(i,"SITTING",means))
  
  datai <- data[which(data$SUBJECT == i),]
  datai <- datai[datai$ACTIVITY == "STANDING",3:81]
  means <- colMeans(datai)
  averages <- rbind(averages,c(i,"STANDING",means))
  
  datai <- data[which(data$SUBJECT == i),]
  datai <- datai[datai$ACTIVITY == "LAYING",3:81]
  means <- colMeans(datai)
  averages <- rbind(averages,c(i,"LAYING",means))
  }

for (i in 3:81){averages[,i]<- as.numeric(averages[,i])}
averages[,1]<- as.numeric(averages[,1])

# Saving just the last table as a .txt at last
write.table(averages,"./averages_ChelsyM.txt",row.names=FALSE)
