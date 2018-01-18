# The start of working with Dirty Data and making it tidy.  
# The data is "real" Excel End of Course Survey data from Survey Monkey 
# from the dates of February 2016 through August 2016

#Getting my working Directory Info
getwd()

#Setting my working Directory in order to be in the folder where my Dirty Excel file is.
setwd("C:/Users/micha/Desktop/DevLeague Begins Nov 7 2017/Project_Sprint_4/")

#Confirming my working directory is correct
getwd()

#Loading libraries and reading my Dirty Excel file into R.

#Loading the library dplyr in order for the 
library(dplyr)

#Loading the libary ggplot2
library(ggplot2)

#Creating the variable "Aug_2016" to represent the "Real_CSV_EOC_Survey.CSV" 
#which is my existing Excel Dirty Data
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
#that Survey Monkey created for the answers into a single Column "Details".
Aug_2016$Details <- paste(Aug_2016$The.technical.details.in.the.course.were.appropriate.for.my.learning..If.you.Disagree.or.Strongly.Disagree..please.also.mark.if.it.was.Too.Much.or.Too.Little..,
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

#Renaming eighth Column to Guide
names(Aug_2016)[8] <- "Guide"

#Renaming ninth Column to Guide_Comment
names(Aug_2016)[9] <- "Guide_Comment"

#Renaming tenth Column to Labs
names(Aug_2016)[10] <- "Labs"

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

#Renaming twenty fourth Column to Had_Skills    
names(Aug_2016)[24] <- "Had_Skills"

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

#Renaming thirtieth Column to Learned     
names(Aug_2016)[30] <- "Learned"

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


#Changing the Column "Guide" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Guide <- gsub('Strongly Agree', '40', Aug_2016$Guide)
Aug_2016$Guide <- gsub('Strongly Disagree', '10', Aug_2016$Guide)
Aug_2016$Guide <- gsub('Disagree', '20', Aug_2016$Guide)
Aug_2016$Guide <- gsub('Agree', '30', Aug_2016$Guide)


#Changing the Column "Guide" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Guide <- gsub('Strongly Agree', '40', Aug_2016$Guide)
Aug_2016$Guide <- gsub('Strongly Disagree', '10', Aug_2016$Guide)
Aug_2016$Guide <- gsub('Disagree', '20', Aug_2016$Guide)
Aug_2016$Guide <- gsub('Agree', '30', Aug_2016$Guide)


#Changing the Column "Labs" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Labs <- gsub('Strongly Agree', '40', Aug_2016$Labs)
Aug_2016$Labs <- gsub('Strongly Disagree', '10', Aug_2016$Labs)
Aug_2016$Labs <- gsub('Disagree', '20', Aug_2016$Labs)
Aug_2016$Labs <- gsub('Agree', '30', Aug_2016$Labs)


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

#Changing the Column "Had_Skills" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Had_Skills <- gsub('Strongly Agree', '40', Aug_2016$Had_Skills)
Aug_2016$Had_Skills <- gsub('Strongly Disagree', '10', Aug_2016$Had_Skills)
Aug_2016$Had_Skills <- gsub('Disagree', '20', Aug_2016$Had_Skills)
Aug_2016$Had_Skills <- gsub('Agree', '30', Aug_2016$Had_Skills)

#Changing the Column "Learned" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Learned <- gsub('Strongly Agree', '40', Aug_2016$Learned)
Aug_2016$Learned <- gsub('Strongly Disagree', '10', Aug_2016$Learned)
Aug_2016$Learned <- gsub('Disagree', '20', Aug_2016$Learned)
Aug_2016$Learned <- gsub('Agree', '30', Aug_2016$Learned)

#Changing the Column "Details" Character String Answers to Numerical Values for future Statistical Analysis
#Strongly Agree = 40
#Agree = 30
#Disagree = 20
#Strongly Disagree = 10
Aug_2016$Details <- gsub('Strongly Agree', '40', Aug_2016$Details)
Aug_2016$Details <- gsub('Strongly Disagree', '10', Aug_2016$Details)
Aug_2016$Details <- gsub('Disagree', '20', Aug_2016$Details)
Aug_2016$Details <- gsub('Agree', '30', Aug_2016$Details)



#Changing the Character String Column "Lecture" to Numeric
Aug_2016$Lecture <- as.numeric(as.character(Aug_2016$Lecture))

#Changing the Character String Column "Responsive" to Numeric
Aug_2016$Responsive <- as.numeric(as.character(Aug_2016$Responsive))

#Changing the Character String Column "Guide" to Numeric
Aug_2016$Guide <- as.numeric(as.character(Aug_2016$Guide))

#Changing the Character String Column "Labs" to Numeric
Aug_2016$Labs <- as.numeric(as.character(Aug_2016$Labs))

#Changing the Character String Column "Classroom" to Numeric
Aug_2016$Classroom <- as.numeric(as.character(Aug_2016$Classroom))

#Changing the Character String Column "Computer" to Numeric
Aug_2016$Computer <- as.numeric(as.character(Aug_2016$Computer))

#Changing the Character String Column "Network" to Numeric
Aug_2016$Network <- as.numeric(as.character(Aug_2016$Network))

#Changing the Character String Column "See_Hear" to Numeric
Aug_2016$See_Hear <- as.numeric(as.character(Aug_2016$See_Hear))

#Changing the Character String Column "Had_Skills" to Numeric
Aug_2016$Had_Skills <- as.numeric(as.character(Aug_2016$Had_Skills))

#Changing the Character String Column "Learned" to Numeric
Aug_2016$Learned <- as.numeric(as.character(Aug_2016$Learned))

#Changing the Character String Column "Details" to Numeric
Aug_2016$Details <- as.numeric(as.character(Aug_2016$Details))


#Deleting the first row since it does not provide any useful data
Aug_2016 = Aug_2016[-1,]



#Calculate the Mean of the Lecture Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Lecture,na.rm = TRUE)

#Calculate the Mean of the Responsive Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Responsive,na.rm = TRUE)

#Calculate the Mean of the Guide Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Guide,na.rm = TRUE)

#Calculate the Mean of the Labs Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Labs,na.rm = TRUE)

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

#Calculate the Mean of the Had_Skills Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Had_Skills,na.rm = TRUE)

#Calculate the Mean of the Learned Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Learned,na.rm = TRUE)

#Calculate the Mean of the Details Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
mean(Aug_2016$Details,na.rm = TRUE)


#Creating variable name "MPLS_Lecture"  (Mean Perceived Learning Score)
Lecture <- mean(Aug_2016$Lecture,na.rm = TRUE)

#Creating variable name "MPLS_Responsive"  (Mean Perceived Learning Score)
Responsive <- mean(Aug_2016$Responsive,na.rm = TRUE)

#Creating variable name "MPLS_Guide"  (Mean Perceived Learning Score)
Guide <- mean(Aug_2016$Guide,na.rm = TRUE)

#Creating variable name "MPLS_Labs"  (Mean Perceived Learning Score)
Labs <- mean(Aug_2016$Labs,na.rm = TRUE)

#Creating variable name "MPLS_Classroom"  (Mean Perceived Learning Score)
Classroom <- mean(Aug_2016$Classroom,na.rm = TRUE)

#Creating variable name "MPLS_Computer"  (Mean Perceived Learning Score)
Computer <- mean(Aug_2016$Computer,na.rm = TRUE)

#Creating variable name "MPLS_Network"  (Mean Perceived Learning Score)
Network <- mean(Aug_2016$Network,na.rm = TRUE)

#Creating variable name "MPLS_See_Hear"  (Mean Perceived Learning Score)
See_Hear <- mean(Aug_2016$See_Hear,na.rm = TRUE)

#Creating variable name "MPLS_Had_Skills"  (Mean Perceived Learning Score)
Had_Skills <- mean(Aug_2016$Had_Skills,na.rm = TRUE)

#Creating variable name "MPLS_Learned"  (Mean Perceived Learning Score)
Learned <- mean(Aug_2016$Learned,na.rm = TRUE)

#Creating variable name "MPLS_Details"  (Mean Perceived Learning Score)
Details <- mean(Aug_2016$Details,na.rm = TRUE)




#Calculate the Standard Deviation of the Lecture Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Lecture,na.rm = TRUE)

#Calculate the Standard Deviation of the Responsive Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Responsive,na.rm = TRUE)

#Calculate the Standard Deviation of the Guide Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Guide,na.rm = TRUE)

#Calculate the Standard Deviation  of the Labs Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Labs,na.rm = TRUE)

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

#Calculate the Standard Deviation of the Had_Skills Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Had_Skills,na.rm = TRUE)

#Calculate the Standard Deviation of the Learned Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Learned,na.rm = TRUE)

#Calculate the Standard Deviation of the Details Column with dropping the NA values from the Calculation
#By using the na.rem = TRUE which means remove the NA Values
sd(Aug_2016$Details,na.rm = TRUE)



#Creating variable name "SD_Lecture"  (Standard Deviation Lecture)
SD_Lecture <- sd(Aug_2016$Lecture,na.rm = TRUE)

#Creating variable name "SD_Responsive"  (Standard Deviation Responsive)
SD_Responsive <- sd(Aug_2016$Responsive,na.rm = TRUE)

#Creating variable name "SD_Guide"  (Standard Deviation Guide)
SD_Guide <- sd(Aug_2016$Guide,na.rm = TRUE)

#Creating variable name "SD_Labs"  (Standard Deviation Labs)
SD_Labs <- sd(Aug_2016$Labs,na.rm = TRUE)

#Creating variable name "SD_Classroom"  (Standard Deviation Classroom)
SD_Classroom <- sd(Aug_2016$Classroom,na.rm = TRUE)

#Creating variable name "SD_Computer"  (Standard Deviation Computer)
SD_Computer <- sd(Aug_2016$Computer,na.rm = TRUE)

#Creating variable name "SD_Network"  (Standard Deviation Computer)
SD_Network <- sd(Aug_2016$Network,na.rm = TRUE)

#Creating variable name "SD_See_Hear"  (Standard Deviation See_Hear)
SD_See_Hear <- sd(Aug_2016$See_Hear,na.rm = TRUE)

#Creating variable name "SD_Had_Skills"  (Standard Deviation Had_Skills)
SD_Had_Skills <- sd(Aug_2016$Had_Skills,na.rm = TRUE)

#Creating variable name "SD_Learned"  (Standard Deviation Learned)
SD_Learned <- sd(Aug_2016$Learned,na.rm = TRUE)

#Creating variable name "SD_Details"  (Standard Deviation Details)
SD_Details <- sd(Aug_2016$Details,na.rm = TRUE)



#Create a new data.set named "SD_Analysis_Aug_2016" which can then be used to output all of the Standard Deviation Scores for each column
SD_Analysis_Aug_2016 <- rbind(Aug_2016$Lecture,data.frame(SD_Lecture, SD_Responsive, SD_Guide, SD_Labs,
                                                          SD_Classroom,SD_Computer,SD_Network,SD_See_Hear,SD_Had_Skills, SD_Learned, SD_Details))


#Rename my SD Columns to straight without the SD (example original was "SD_Lecture" - renamed to "Lecture") so it lines up correctly with the original column names
SD_Analysis_Aug_2016 <- setNames(SD_Analysis_Aug_2016, c("Lecture","Responsive","Guide", "Labs", "Classroom", "Computer",
                                                         "Network", "See_Hear", "Had_Skills", "Learned", "Details"))

#Create a new data.set named "Mean_Analysis_Aug_2016" which can then be used to output all of the Mean Scores for each column
Mean_Analysis_Aug_2016 <- rbind(Aug_2016$Lecture,data.frame(Lecture, Responsive, Guide, Labs,Classroom,Computer,Network,See_Hear,Had_Skills, Learned, Details))


#I believe this sets all my columns to numeric with the sapply function
MPLS_Scores <- Aug_2016[sapply(Aug_2016, is.numeric)]

#bind the rows together - essentially read the three different datasets into one file - this does need the dplyr package loaded prior.
Total_MPLS_Mean_SD_Aug_2016 <- bind_rows(MPLS_Scores,Mean_Analysis_Aug_2016,SD_Analysis_Aug_2016)


#Write the cleaned and total Calculated SD_MPLS (Standard Deviation Mean Perceived Learning Score) Data from R back to a CSV File (SD_MPLS_August_2016)
write.csv(Total_MPLS_Mean_SD_Aug_2016, "Total_MPLS_Mean_SD_Aug_2016.csv")
#Round the Column Mean answers to two digits
round(Column_mean, digits = 2)


#Calculate the mean for each and every column
Column_mean <- sapply(MPLS_Scores,mean,na.rm=TRUE)

#Round the Column Mean answers to two digits
round(Column_mean, digits = 2)

Rounded_Mean <- round(Column_mean, digits = 2)

#Calculate the standard deviation for each and every column
Column_SD <- sapply(MPLS_Scores,sd,na.rm=TRUE)

##Bind the Column_mean and Columm_SD rows together
bind_rows(Rounded_Mean,Column_SD,) 

#Assign the variable name Summary_stats to the two combined rows (Column_mean & Column_SD)
New_Summary_stats <- bind_rows(Rounded_Mean,Column_SD)

#For the first two rows give the title of Mean and Standard_Dev to those two row names
rownames(New_Summary_stats) <- c("Mean", "Standard_Dev")

#View the Summary_stats which should show on the R panel the Calculated Mean and Standard 
#Deviation for all of the Columns with the Mean and Standard_Dev as row names as well


#Removing the Column Headers and just outputing the Mean on Each Column
unname(unlist(Rounded_Mean))

#Removing the Column Headers and just outputing the Standard Deviation on Each Column
unname(unlist(Column_SD))

View(New_Summary_stats)




#This will plot the Standard Deviation from each Column (question)
#Though I have it commented out at the moment
#barplot(Column_SD)

#This will make the Barplot for Column_mean 
# colored dark green:  col="darkgreen" 
#with a border of red: 
#with the MPLS_Scores labeled as the Title on the top: main="MPLS_Scores"
#with the Y Axis (vertical) measurement columns displaying from 0 to 40 (limits for the y axis): ylim = c(0, 40)

#Creating the labels which will be at the bottom of the Standard Deviation and MPLS_Scores for the bar graphs
labels <- list('Lecture', 'Responsive', 'Guide', 'Labs', 'Classroom', 'Computer', 'Network', 'See_Hear', 'Had_Skills', 'Learned', 'Details')

#Trying to get the actual values to appear on the top of the bar for the Mean
Mean_Values = c(37.15, 38.02, 34.88, 35.51, 33.55, 35.35 ,35.26, 36.62, 33.46, 33.67, 34.00)

#Trying to get the actual values to appear on the top of the bar for the Standard Deviation
Standard_Dev_Values = c(4.88, 4.19, 5.57, 5.43, 5.68, 5.60, 5.60, 4.87, 5.70, 5.64, 5.60)


#Creating the Standard Deviation (Column_SD) bar graph from all columns (Questions)
barplot(height=Column_SD, names.arg=labels, beside = TRUE, col="darkgreen", border = "red", main="Standard_Deviation", ylab="STD", las=2, ylim = c(0, 7))


#Putting this code in to be able to save the barplot and possibly other things
Revised_Barplot_SD <- barplot(height=Column_SD, names.arg=labels, beside = TRUE, col="darkgreen", border = "red", main="Standard_Deviation", ylab="STD", las=2, srt=45, adj = 1,xpd = TRUE,ylim = c(0, 7))


#This sets the row heights for the barplot from 0 to 6
#ylim = c(0, 6)
#This labels the barplot with Standard_Deviation as the title & STD on the Y Axis 
#las=2 This makes the labels of the bar graph go vertical 



#Creating the MPLS_Scores (Column_mean) bar graph from all columns (Questions)
barplot(height=Column_mean, names.arg=labels, beside = TRUE, col="orange", border = "green", 
        main="MPLS_Scores", ylab="Mean", las=2, ylim = c(0, 46))

#Putting this code in to be able to save the barplot and possibly other things
Revised_barplot_Mean <- barplot(height=Column_mean, names.arg=labels, beside = TRUE, col="orange", 
        border = "green", main="MPLS_Scores", ylab="Mean", las=2, ylim = c(0, 46))

#This labels the barplot with MPLS_Scores as the title & Mean on the Y Axis 
#This sets the row heights for the barplot from 0 to 40
#ylim = c(0, 40)
#las=2 This makes the labels of the bar graph go vertical 

#Creating the Standard Deviation (Column_SD) bar graph from all columns (Questions)
barplot(height=Column_SD, names.arg=labels, beside = TRUE, col="darkgreen", border = "red", main="Standard_Deviation", ylab="STD", las=2, ylim = c(0, 7))

#Creating the MPLS_Scores (Column_mean) bar graph from all columns (Questions)
barplot(height=Column_mean, names.arg=labels, beside = TRUE, col="red", border = "green", 
        main="MPLS_Scores", ylab="Mean", las=2, ylim = c(0, 46))





Combined_PDF = "C:/Users/micha/Desktop/DevLeague Begins Nov 7 2017/Project_Sprint_4/Combined_PDF.pdf"

pdf(file = Combined_PDF)

#Creating the labels which will be at the bottom of the Standard Deviation and MPLS_Scores for the bar graphs
labels <- list('Lecture', 'Responsive', 'Guide', 'Labs', 'Classroom', 'Computer', 'Network', 'See_Hear', 'Had_Skills', 'Learned', 'Details')

labels_SD <- list('Lecture', 'Responsive', 'Guide', 'Labs', 'Classroom', 'Computer', 'Network', 'See_Hear', 'Had_Skills', 'Learned', 'Details')


#Putting this code in to be able to save the barplot and possibly other things
Revised_barplot_Mean <- barplot(height=Column_mean, names.arg=labels, beside = TRUE, col="red", 
                                border = "green", main="MPLS_Scores", ylab="Mean", las=2, ylim = c(0, 46))

text(Revised_barplot_Mean, Column_mean, labels = Mean_Values,pos=3, offset=.5)

#Putting this code in to be able to save the barplot and possibly other things
Revised_Barplot_SD <- barplot(height=Column_SD, names.arg=labels_SD, beside = TRUE, col="darkgreen", border = "red", main="Standard_Deviation", ylab="STD", las=2 ,ylim = c(0, 7))

#This sets the row heights for the barplot from 0 to 6
#ylim = c(0, 6)
#This labels the barplot with Standard_Deviation as the title & STD on the Y Axis 
#las=2 This makes the labels of the bar graph go vertical 

text(Revised_Barplot_SD, Column_SD, labels = Standard_Dev_Values, pos=3, offset = .5)


dev.off()

#This is writing a PDF file called Revised_Bar_Plot_Mean to my folder and displaying it on my screen
dev.print(pdf, 'Revised_Barplot_Mean.pdf')

#This is writing a PDF file called Revised_Bar_Plot_SD to my folder and displaying it (quickly) on my screen
dev.print(pdf, 'Revised_Barplot_SD.pdf')

