# The start of working with Dirty Data and making it tidy.  
# The data is "real" Excel End of Course Survey data from Survey Monkey from the dates of
# February 2016 through August 2016

#Getting my working Directory Info
getwd()

#Setting my working Directory in order to be in the folder where my Dirty Excel file is.
setwd("C:/Users/micha/Desktop/DevLeague Begins Nov 7 2017/Project_Sprint_4/")

#confirming my working directory is correct
getwd()

#reading my Dirty Excel file into R and then viewing it.

#loading the library dplyr in order for the 
library(dplyr)

#loading the libary ggplot2
library(ggplot2)

#creating the variable "Aug_2016" to represent the "Real_CSV_EOC_Survey.CSV" which is my 
#existing Excel Dirty Data
Aug_2016 <- read.csv("Real_CSV_EOC_Survey.csv")


#To remove the first column name try this
Aug_2016 <- subset( Aug_2016, select = -Respondent.ID )

#To remove the next column name try this
Aug_2016 <- subset( Aug_2016, select = -Collector.ID )

#To remove this particular column name which isn't next do this
Aug_2016 <- subset(Aug_2016, select = -IP.Address )


#To remove this particular column name which isn't next do this
Aug_2016 <- subset(Aug_2016, select = -Email.Address )


#To remove this particular column name 
Aug_2016 <- subset(Aug_2016, select = -First.Name )

#To remove this particular column name  (This is an extra column added by Survey Monkey)
Aug_2016 <- subset(Aug_2016, select = -Last.Name )  

#To remove this particular column name (This is an extra column added by Survey Monkey)
Aug_2016 <- subset(Aug_2016, select = -Custom.Data.1 )

#To remove this particular column name (No need to display Student names for this purpose)
Aug_2016 <- subset(Aug_2016, select = -What.is.your.name..optional..)

#To remove this particular column name
Aug_2016 <- subset(Aug_2016, select = -Who.was.your.training.instructor.s..)

#To remove this particular column name (This was an extra column created by Survey Monkey,
#But this Instructor is no longer with the company)
Aug_2016 <- subset(Aug_2016, select = -X.2)

#To remove this particular column name (This was an extra column created by Survey Monkey,
#But this Instructor did not teach this particular collection period)
Aug_2016 <- subset(Aug_2016, select = -X.3)

#To remove this particular column name (This was an extra column created by Survey Monkey,
#But this Person no longer teaches)
Aug_2016 <- subset(Aug_2016, select = -X.5)

#To remove this particular column name (This was an extra column created by Survey Monkey,
#But this Instructor did not teach this particular collection period)
Aug_2016 <- subset(Aug_2016, select = -X.12)

#To remove this particular column name (This was an extra column created by Survey Monkey,
#But this Instructor did not teach this particular collection period)
Aug_2016 <- subset(Aug_2016, select = -X.16)

#To Combine all the Instuctor Columns into one single column
Aug_2016$Instructor <- paste(Aug_2016$X.4,Aug_2016$X.6, Aug_2016$X.7, Aug_2016$X.8,Aug_2016$X.9,Aug_2016$X.10,Aug_2016$X.11,Aug_2016$X.13,
Aug_2016$X.14,Aug_2016$X.15,Aug_2016$X.17,Aug_2016$X.18) 

#To remove all the original Instructor columns.  And note it takes two closed parenthesis at the end
#and not one as the documentation showed
Aug_2016 <- subset( Aug_2016, select = -c( X.18 : X.4))

#To combine the columns of "where did you attend the training course" and X "Other" into a single column "Location" 
Aug_2016$Location <- paste(Aug_2016$Where.did.you.attend.the.training.course.,Aug_2016$X)

#To remove the original column "X" which was "Other" meaning not a defined training location  
Aug_2016 <- subset(Aug_2016, select = -X)

#To remove the original column "Where did you attend the training course" 
Aug_2016 <- subset(Aug_2016, select = -Where.did.you.attend.the.training.course.)

#To Copy the original column "What.training.course.did.you.attend" and "X.1" that Survey Monkey created for "Other"
#into a single Column "Course". 
Aug_2016$Course <- paste(Aug_2016$What.training.course.did.you.attend.,Aug_2016$X.1)

#To Remove the original column "What.training.course.did.you.attend" 
Aug_2016 <- subset(Aug_2016, select = -What.training.course.did.you.attend.)

#And to Remove the "X.1" Column that Survey Monkey created for "Other" courses attended
Aug_2016 <- subset(Aug_2016, select = -X.1)

#To Copy the original column "The.technical.details.in.the.course.were.appropriate.for.my.learning.
#.If.you.Disagree.or.Strongly.Disagree..please.also.mark.if.it.was.Too.Much.or.Too.Little.." and "X.21", "X.22", and "X.23"
#that Survey Monkey created for the answers into a single Column "Technical_Details".
Aug_2016$Technical_Details <- paste(Aug_2016$The.technical.details.in.the.course.were.appropriate.for.my.learning..If.you.Disagree.or.Strongly.Disagree..please.also.mark.if.it.was.Too.Much.or.Too.Little..,
Aug_2016$X.21,Aug_2016$X.22,Aug_2016$X.23)

#To delete the original column "The.technical.details.in.the.course.were.appropriate.for.my.learning.
#.If.you.Disagree.or.Strongly.Disagree..please.also.mark.if.it.was.Too.Much.or.Too.Little.." 
Aug_2016 <- subset(Aug_2016, select = -The.technical.details.in.the.course.were.appropriate.for.my.learning..If.you.Disagree.or.Strongly.Disagree..please.also.mark.if.it.was.Too.Much.or.Too.Little..)

#Delete Columns "X.21", "X.22", and "X.23" that Survey Monkey created for the answers.
Aug_2016 <- subset( Aug_2016, select = -c( X.23 : X.21))

#Delete Columns X.24, X.25, X.26 for Too Little and Comments
Aug_2016 <- subset( Aug_2016, select = -c( X.26 : X.24))


#Renaming first Column to Start_Date
names(Aug_2016)[1] <- "Start_Date"

#Renaming second Column to End_Date  (This column is being kept in case I want to calculate time for the actual survey to complete)
names(Aug_2016)[2] <- "End_Date"

#Renaming third Column to Company
names(Aug_2016)[3] <- "Company"

#Renaming fourth Column to Lecture
names(Aug_2016)[4] <- "Lecture"

#Renaming fifth Column to Lecture
names(Aug_2016)[5] <- "Lecture_Comments"

#Renaming sixth Column to Responsive 
names(Aug_2016)[6] <- "Responsive"

#Renaming seventh Column to Responsive_Comments
names(Aug_2016)[7] <- "Responsive_Comments"

#Renaming eighth Column to Student_Guide
names(Aug_2016)[8] <- "Student_Guide"

#Renaming ninth Column to Guide_Comment
names(Aug_2016)[9] <- "Guide_Comment"

#Renaming tenth Column to Lab_Exercises
names(Aug_2016)[10] <- "Lab_Exercises"

#Renaming eleventh Column to Lab_Comments
names(Aug_2016)[11] <- "Lab_Comments"

#Renaming twelfth Column to Classroom
names(Aug_2016)[12] <- "Classroom"

#Renaming thirteenth Column to Classroom_Comments
names(Aug_2016)[13] <- "Classroom_Comments"

#Renaming fourteenth Column to Computer 
names(Aug_2016)[14] <- "Computer"

#Renaming fifteenth Column to Computer_Comments 
names(Aug_2016)[15] <- "Computer_Comments"

#Renaming sixteenth Column to Network 
names(Aug_2016)[16] <- "Network"

#Renaming sixteenth Column to Network 
names(Aug_2016)[16] <- "Network"

#Renaming seventeenth Column to Network_Comments 
names(Aug_2016)[17] <- "Network_Comments"

#Renaming eighteenth Column to See_Hear  
names(Aug_2016)[18] <- "See_Hear"

#Renaming nineteenth Column to See_Hear_Comments  
names(Aug_2016)[19] <- "See_Hear_Comments"

#Renaming twentieth Column to Experience  
names(Aug_2016)[20] <- "Years_Experience"

#Renaming twenty first Column to IP_or_Telephony  
names(Aug_2016)[21] <- "Experience_Comments"

#Renaming twenty second Column to IP_or_Telephony_Background    
names(Aug_2016)[22] <- "IP_or_Telephony_Background"

#Renaming twenty third Column to Background_Comments    
names(Aug_2016)[23] <- "Background_Comments"

#Renaming twenty fourth Column to Had_Knowledge_Skills    
names(Aug_2016)[24] <- "Had_Knowledge_Skills"

#Renaming twenty fifth Column to Knowledge_Skills_Comments    
names(Aug_2016)[25] <- "Knowledge_Skills_Comments"

#Renaming twenty Sixth Column to Metaswitch_Experience    
names(Aug_2016)[26] <- "Metaswitch_Experience"

#Renaming twenty seventh Column to Metaswitch_Exp_Comments    
names(Aug_2016)[27] <- "Metaswitch_Exp_Comments"

#Renaming twenty eight Column to Attended_Appropriate_Time     
names(Aug_2016)[28] <- "Attended__Appropriate_Time"

#Renaming twenty ninth Column to Appropriate_Time_Comments     
names(Aug_2016)[29] <- "Appropriate_Time_Comments"

#Renaming thirtieth Column to Learned_What_I_Needed     
names(Aug_2016)[30] <- "Learned_What_I_Needed"

#Renaming thirty first Column to Learned_Comment     
names(Aug_2016)[31] <- "Learned_Comment"

#Renaming thirty second Column to Recommend_Class     
names(Aug_2016)[32] <- "Recommend_Class"

#Renaming thirty third Column to Recommend_Comments     
names(Aug_2016)[33] <- "Recommend_Comments"

#Renaming thirty fourth Column to Feedback     
names(Aug_2016)[34] <- "Feedback"


#Changing the Column "Lecture" Character String Answers to Numerical Values for future Statiscal Analysis
#Strong Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Lecture <- gsub('Strongly Agree', '40', Aug_2016$Lecture)
Aug_2016$Lecture <- gsub('Strongly Disagree', '10', Aug_2016$Lecture)
Aug_2016$Lecture <- gsub('Disagree', '20', Aug_2016$Lecture)
Aug_2016$Lecture <- gsub('Agree', '30', Aug_2016$Lecture)


#Changing the Column "Responsive" Character String Answers to Numerical Values for future Statistical Analysis
#Strong Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Responsive <- gsub('Strongly Agree', '40', Aug_2016$Responsive)
Aug_2016$Responsive <- gsub('Strongly Disagree', '10', Aug_2016$Responsive)
Aug_2016$Responsive <- gsub('Disagree', '20', Aug_2016$Responsive)
Aug_2016$Responsive <- gsub('Agree', '30', Aug_2016$Responsive)


#Changing the Column "Student_Guide" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Student_Guide <- gsub('Strongly Agree', '40', Aug_2016$Student_Guide)
Aug_2016$Student_Guide <- gsub('Strongly Disagree', '10', Aug_2016$Student_Guide)
Aug_2016$Student_Guide <- gsub('Disagree', '20', Aug_2016$Student_Guide)
Aug_2016$Student_Guide <- gsub('Agree', '30', Aug_2016$Student_Guide)


#Changing the Column "Student_Guide" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Student_Guide <- gsub('Strongly Agree', '40', Aug_2016$Student_Guide)
Aug_2016$Student_Guide <- gsub('Strongly Disagree', '10', Aug_2016$Student_Guide)
Aug_2016$Student_Guide <- gsub('Disagree', '20', Aug_2016$Student_Guide)
Aug_2016$Student_Guide <- gsub('Agree', '30', Aug_2016$Student_Guide)


#Changing the Column "Lab_Exercises" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Lab_Exercises <- gsub('Strongly Agree', '40', Aug_2016$Lab_Exercises)
Aug_2016$Lab_Exercises <- gsub('Strongly Disagree', '10', Aug_2016$Lab_Exercises)
Aug_2016$Lab_Exercises <- gsub('Disagree', '20', Aug_2016$Lab_Exercises)
Aug_2016$Lab_Exercises <- gsub('Agree', '30', Aug_2016$Lab_Exercises)


#Changing the Column "Classroom" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Classroom <- gsub('Strongly Agree', '40', Aug_2016$Classroom)
Aug_2016$Classroom <- gsub('Strongly Disagree', '10', Aug_2016$Classroom)
Aug_2016$Classroom <- gsub('Disagree', '20', Aug_2016$Classroom)
Aug_2016$Classroom <- gsub('Agree', '30', Aug_2016$Classroom)

#Changing the Column "Computer" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Computer <- gsub('Strongly Agree', '40', Aug_2016$Computer)
Aug_2016$Computer <- gsub('Strongly Disagree', '10', Aug_2016$Computer)
Aug_2016$Computer <- gsub('Disagree', '20', Aug_2016$Computer)
Aug_2016$Computer <- gsub('Agree', '30', Aug_2016$Computer)

#Changing the Column "Network" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Network <- gsub('Strongly Agree', '40', Aug_2016$Network)
Aug_2016$Network <- gsub('Strongly Disagree', '10', Aug_2016$Network)
Aug_2016$Network <- gsub('Disagree', '20', Aug_2016$Network)
Aug_2016$Network <- gsub('Agree', '30', Aug_2016$Network)

#Changing the Column "See_Hear" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$See_Hear <- gsub('Strongly Agree', '40', Aug_2016$See_Hear)
Aug_2016$See_Hear <- gsub('Strongly Disagree', '10', Aug_2016$See_Hear)
Aug_2016$See_Hear <- gsub('Disagree', '20', Aug_2016$See_Hear)
Aug_2016$See_Hear <- gsub('Agree', '30', Aug_2016$See_Hear)

#Changing the Column "Had_Knowledge_Skills" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Had_Knowledge_Skills <- gsub('Strongly Agree', '40', Aug_2016$Had_Knowledge_Skills)
Aug_2016$Had_Knowledge_Skills <- gsub('Strongly Disagree', '10', Aug_2016$Had_Knowledge_Skills)
Aug_2016$Had_Knowledge_Skills <- gsub('Disagree', '20', Aug_2016$Had_Knowledge_Skills)
Aug_2016$Had_Knowledge_Skills <- gsub('Agree', '30', Aug_2016$Had_Knowledge_Skills)

#Changing the Column "Learned_What_I_Needed" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Learned_What_I_Needed <- gsub('Strongly Agree', '40', Aug_2016$Learned_What_I_Needed)
Aug_2016$Learned_What_I_Needed <- gsub('Strongly Disagree', '10', Aug_2016$Learned_What_I_Needed)
Aug_2016$Learned_What_I_Needed <- gsub('Disagree', '20', Aug_2016$Learned_What_I_Needed)
Aug_2016$Learned_What_I_Needed <- gsub('Agree', '30', Aug_2016$Learned_What_I_Needed)

#Changing the Column "Technical_Details" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Technical_Details <- gsub('Strongly Agree', '40', Aug_2016$Technical_Details)
Aug_2016$Technical_Details <- gsub('Strongly Disagree', '10', Aug_2016$Technical_Details)
Aug_2016$Technical_Details <- gsub('Disagree', '20', Aug_2016$Technical_Details)
Aug_2016$Technical_Details <- gsub('Agree', '30', Aug_2016$Technical_Details)



#Changing the Character String Column "Lecture" to Numeric
Aug_2016$Lecture <- as.numeric(as.character(Aug_2016$Lecture))

#Changing the Character String Column "Responsive" to Numeric
Aug_2016$Responsive <- as.numeric(as.character(Aug_2016$Responsive))

#Changing the Character String Column "Student_Guide" to Numeric
Aug_2016$Student_Guide <- as.numeric(as.character(Aug_2016$Student_Guide))

#Changing the Character String Column "Lab_Exercises" to Numeric
Aug_2016$Lab_Exercises <- as.numeric(as.character(Aug_2016$Lab_Exercises))

#Changing the Character String Column "Classroom" to Numeric
Aug_2016$Classroom <- as.numeric(as.character(Aug_2016$Classroom))

#Changing the Character String Column "Computer" to Numeric
Aug_2016$Computer <- as.numeric(as.character(Aug_2016$Computer))

#Changing the Character String Column "Network" to Numeric
Aug_2016$Network <- as.numeric(as.character(Aug_2016$Network))

#Changing the Character String Column "See_Hear" to Numeric
Aug_2016$See_Hear <- as.numeric(as.character(Aug_2016$See_Hear))

#Changing the Character String Column "Had_Knowledge_Skills" to Numeric
Aug_2016$Had_Knowledge_Skills <- as.numeric(as.character(Aug_2016$Had_Knowledge_Skills))

#Changing the Character String Column "Learned_What_I_Needed" to Numeric
Aug_2016$Learned_What_I_Needed <- as.numeric(as.character(Aug_2016$Learned_What_I_Needed))

#Changing the Character String Column "Technical_Details" to Numeric
Aug_2016$Technical_Details <- as.numeric(as.character(Aug_2016$Technical_Details))


#Deleting the first row since it does not provide any useful data
Aug_2016 = Aug_2016[-1,]



#Calculate the Mean of the Lecture Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Lecture,na.rm = TRUE)

#Calculate the Mean of the Responsive Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Responsive,na.rm = TRUE)

#Calculate the Mean of the Student_Guide Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Student_Guide,na.rm = TRUE)

#Calculate the Mean of the Lab_Exercises Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Lab_Exercises,na.rm = TRUE)

#Calculate the Mean of the Classroom Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Classroom,na.rm = TRUE)

#Calculate the Mean of the Computer Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Computer,na.rm = TRUE)

#Calculate the Mean of the Network Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Network,na.rm = TRUE)

#Calculate the Mean of the See_Hear Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$See_Hear,na.rm = TRUE)

#Calculate the Mean of the Had_Knowledge_Skills Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Had_Knowledge_Skills,na.rm = TRUE)

#Calculate the Mean of the Learned_What_I_Needed Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Learned_What_I_Needed,na.rm = TRUE)

#Calculate the Mean of the Technical_Details Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Technical_Details,na.rm = TRUE)


#Creating variable name "MPLS_Lecture"  (Mean Perceived Learning Score)
Lecture <- mean(Aug_2016$Lecture,na.rm = TRUE)

#Creating variable name "MPLS_Responsive"  (Mean Perceived Learning Score)
Responsive <- mean(Aug_2016$Responsive,na.rm = TRUE)

#Creating variable name "MPLS_Student_Guide"  (Mean Perceived Learning Score)
Student_Guide <- mean(Aug_2016$Student_Guide,na.rm = TRUE)

#Creating variable name "MPLS_Lab_Exercises"  (Mean Perceived Learning Score)
Lab_Exercises <- mean(Aug_2016$Lab_Exercises,na.rm = TRUE)

#Creating variable name "MPLS_Classroom"  (Mean Perceived Learning Score)
Classroom <- mean(Aug_2016$Classroom,na.rm = TRUE)

#Creating variable name "MPLS_Computer"  (Mean Perceived Learning Score)
Computer <- mean(Aug_2016$Computer,na.rm = TRUE)

#Creating variable name "MPLS_Network"  (Mean Perceived Learning Score)
Network <- mean(Aug_2016$Network,na.rm = TRUE)

#Creating variable name "MPLS_See_Hear"  (Mean Perceived Learning Score)
See_Hear <- mean(Aug_2016$See_Hear,na.rm = TRUE)

#Creating variable name "MPLS_Had_Knowledge_Skills"  (Mean Perceived Learning Score)
Had_Knowledge_Skills <- mean(Aug_2016$Had_Knowledge_Skills,na.rm = TRUE)

#Creating variable name "MPLS_Learned_What_I_Needed"  (Mean Perceived Learning Score)
Learned_What_I_Needed <- mean(Aug_2016$Learned_What_I_Needed,na.rm = TRUE)

#Creating variable name "MPLS_Technical_Details"  (Mean Perceived Learning Score)
Technical_Details <- mean(Aug_2016$Technical_Details,na.rm = TRUE)




#Calculate the Standard Deviation of the Lecture Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Lecture,na.rm = TRUE)

#Calculate the Standard Deviation of the Responsive Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Responsive,na.rm = TRUE)

#Calculate the Standard Deviation of the Student_Guide Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Student_Guide,na.rm = TRUE)

#Calculate the Standard Deviation  of the Lab_Exercises Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Lab_Exercises,na.rm = TRUE)

#Calculate the Standard Deviation of the Classroom Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Classroom,na.rm = TRUE)

#Calculate the Standard Deviation of the Computer Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Computer,na.rm = TRUE)

#Calculate the Standard Deviation of the Network Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Network,na.rm = TRUE)

#Calculate the Standard Deviation of the See_Hear Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$See_Hear,na.rm = TRUE)

#Calculate the Standard Deviation of the Had_Knowledge_Skills Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Had_Knowledge_Skills,na.rm = TRUE)

#Calculate the Standard Deviation of the Learned_What_I_Needed Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Learned_What_I_Needed,na.rm = TRUE)

#Calculate the Standard Deviation of the Technical_Details Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Technical_Details,na.rm = TRUE)



#Creating variable name "SD_Lecture"  (Standard Deviation Lecture)
SD_Lecture <- sd(Aug_2016$Lecture,na.rm = TRUE)

#Creating variable name "SD_Responsive"  (Standard Deviation Responsive)
SD_Responsive <- sd(Aug_2016$Responsive,na.rm = TRUE)

#Creating variable name "SD_Student_Guide"  (Standard Deviation Student_Guide)
SD_Student_Guide <- sd(Aug_2016$Student_Guide,na.rm = TRUE)

#Creating variable name "SD_Lab_Exercises"  (Standard Deviation Lab_Exercises)
SD_Lab_Exercises <- sd(Aug_2016$Lab_Exercises,na.rm = TRUE)

#Creating variable name "SD_Classroom"  (Standard Deviation Classroom)
SD_Classroom <- sd(Aug_2016$Classroom,na.rm = TRUE)

#Creating variable name "SD_Computer"  (Standard Deviation Computer)
SD_Computer <- sd(Aug_2016$Computer,na.rm = TRUE)

#Creating variable name "SD_Network"  (Standard Deviation Computer)
SD_Network <- sd(Aug_2016$Network,na.rm = TRUE)

#Creating variable name "SD_See_Hear"  (Standard Deviation See_Hear)
SD_See_Hear <- sd(Aug_2016$See_Hear,na.rm = TRUE)

#Creating variable name "SD_Had_Knowledge_Skills"  (Standard Deviation Had_Knowledge_Skills)
SD_Had_Knowledge_Skills <- sd(Aug_2016$Had_Knowledge_Skills,na.rm = TRUE)

#Creating variable name "SD_Learned_What_I_Needed"  (Standard Deviation Learned_What_I_Needed)
SD_Learned_What_I_Needed <- sd(Aug_2016$Learned_What_I_Needed,na.rm = TRUE)

#Creating variable name "SD_Technical_Details"  (Standard Deviation Technical_Details)
SD_Technical_Details <- sd(Aug_2016$Technical_Details,na.rm = TRUE)



#Create a new data.set named "SD_Analysis_Aug_2016" which can then be used to output all of the Standard Deviation Scores for each column
SD_Analysis_Aug_2016 <- rbind(Aug_2016$Lecture,data.frame(SD_Lecture, SD_Responsive, SD_Student_Guide, SD_Lab_Exercises,
SD_Classroom,SD_Computer,SD_Network,SD_See_Hear,SD_Had_Knowledge_Skills, SD_Learned_What_I_Needed, SD_Technical_Details))


#Rename my SD Columns to straight without the SD (example original was "SD_Lecture" - renamed to "Lecture") so it lines up correctly with the original column names
SD_Analysis_Aug_2016 <- setNames(SD_Analysis_Aug_2016, c("Lecture","Responsive","Student_Guide", "Lab_Exercises", "Classroom", "Computer",
"Network", "See_Hear", "Had_Knowledge_Skills", "Learned_What_I_Needed", "Technical_Details"))

#Create a new data.set named "Mean_Analysis_Aug_2016" which can then be used to output all of the Mean Scores for each column
Mean_Analysis_Aug_2016 <- rbind(Aug_2016$Lecture,data.frame(Lecture, Responsive, Student_Guide, Lab_Exercises,Classroom,Computer,Network,See_Hear,Had_Knowledge_Skills, Learned_What_I_Needed, Technical_Details))


#I believe this sets all my columns to numeric with the sapply function
MPLS_Scores <- Aug_2016[sapply(Aug_2016, is.numeric)]

#bind the rows together - essentially read the three different datasets into one file - this does need the dplyr package loaded prior.
Total_MPLS_Mean_SD_Aug_2016 <- bind_rows(MPLS_Scores,Mean_Analysis_Aug_2016,SD_Analysis_Aug_2016)


#Write the cleaned and total Calculated SD_MPLS (Standard Deviation Mean Perceived Learning Score) Data from R back to a CSV File (SD_MPLS_August_2016)
write.csv(Total_MPLS_Mean_SD_Aug_2016, "Total_MPLS_Mean_SD_Aug_2016.csv")


View(Total_MPLS_Mean_SD_Aug_2016)




  