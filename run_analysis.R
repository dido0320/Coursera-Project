#Read subjects
path <- getwd()
d <- 'UCI HAR Dataset'
DT1<-data.table(read.table(file.path(path, d, 'train', 'subject_train.txt')))
DT2 <- data.table(read.table(file.path(path, d, 'test', 'subject_test.txt')))
DT3 <- rbind(DT1, DT2)

#Read activities
DAT1<- data.table(read.table(file.path(path, d, 'train','Y_train.txt')))
DAT2<-data.table(read.table(file.path(path, d, 'test','Y_test.txt')))
DAT3<- rbind(DAT1,DAT2)
names(DT3)<- c('subject')
names(DAT3)<-c('activity')

#Combine subject and activity
SA<- cbind(DT3,DAT3)

#Read datasets
Train.set1 <- data.table(read.table(file.path(path,d,'train','X_train.txt')))
Train.set2 <- data.table(read.table(file.path(path,d,'test','X_test.txt')))
Train.set3<- rbind(Train.set1,Train.set2)

#Combine subject,activity and datasets
TEST<- cbind(SA,Train.set3)

#Read feature 
feature <- data.table(read.table(file.path(path,d,'features.txt'))) 
names(feature) <- c('index','value')
featurename <- feature [,2]

#Extract mean and std
featureIndex <- grep(("mean\\(\\))|std\\(\\)"), featurename$value)
finalData <- select(TEST,c(1,2,featureIndex+2))
b<- c(featurename[featureIndex])
colnames(finalData) <- c("subject", "activity", as.character(b$value))

#Use descriptive activity names to name the activities in the data set
TESTnames<-data.table(read.table(file.path(path, d, 'activity_labels.txt')))
names(TESTnames ) <- c('activity','activity_type')

#Appropriately label the data set with descriptive variable names
names(finalData) <- gsub("\\()", "", names(finalData))
names(finalData) <- gsub("^t", "time", names(finalData))
names(finalData) <- gsub("^f", "frequence", names(finalData))
names(finalData) <- gsub("-mean", "Mean", names(finalData))
names(finalData) <- gsub("-std", "Std", names(finalData))

#Create a second, independent tidy data set with the average of each variable for each activity and each subject
AT<-merge(TESTnames,finalData,by = "activity")
AT_Tidy<- AT %>% group_by(subject, activity_type)  %>% summarise_each(funs(mean)) %>% select(-activity)




