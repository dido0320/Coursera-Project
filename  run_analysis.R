#read subjects
path <- getwd()
d <- 'UCI HAR Dataset'
DT1<-data.table(read.table(file.path(path, d, 'train', 'subject_train.txt')))
DT2 <- data.table(read.table(file.path(path, d, 'test', 'subject_test.txt')))
DT3 <- rbind(DT1, DT2)
#read activities
DAT1<- data.table(read.table(file.path(path, d, 'train','Y_train.txt')))
DAT2<-data.table(read.table(file.path(path, d, 'test','Y_test.txt')))
DAT3<- rbind(DAT1,DAT2)
names(DT3)<- c('subject')
names(DAT3)<-c('activity')
#combine subject and activity
SA<- cbind(DT3,DAT3)
#read set data
Train.set1 <- data.table(read.table(file.path(path,d,'train','X_train.txt')))
Train.set2 <- data.table(read.table(file.path(path,d,'test','X_test.txt')))
Train.set<- rbind(Train.set1,Train.set2)
# combine sebject/activity/set data
TEST<- cbind(SA,Train.set)
#get only std and mean features
feature <- data.table(read.table(file.path(path,d,'features.txt'))) 
names(feature) <- c('index','value')
#Appropriately labels the data set with descriptive variable names.
TESTnames<-data.table(read.table(file.path(path, d, 'activity_labels.txt')))
names(TESTnames ) <- c('activity','activity_type')
AT<-merge(TESTnames,TEST,by = "activity")
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.H
AT_Tidy<- AT %>% group_by(subject, activity_type)  %>% summarise_each(funs(mean)) %>% select(-activity)




