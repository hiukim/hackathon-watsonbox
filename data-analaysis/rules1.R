install.packages("sqldf")
library(sqldf)
library(stringr)
library(reshape2)

install.packages("arules")
library(arules)

setwd("C:\\Users\\aswhazel\\Documents\\data\\3_item_transcations")

#read in csv files

item_trans1<-read.csv(file="temp_transcation_1.csv")
item_trans2<-read.csv(file="temp_transcation_2.csv")
item_trans3<-read.csv(file="temp_transcation_3.csv")
item_trans4<-read.csv(file="temp_transcation_4.csv")
item_trans5<-read.csv(file="temp_transcation_5.csv")
item_trans6<-read.csv(file="temp_transcation_6.csv")
item_trans7<-read.csv(file="temp_transcation_7.csv")
item_trans8<-read.csv(file="temp_transcation_8.csv")
item_trans9<-read.csv(file="temp_transcation_9.csv")
item_trans10<-read.csv(file="temp_transcation_10.csv")
item_trans11<-read.csv(file="temp_transcation_11.csv")
item_trans12<-read.csv(file="temp_transcation_12.csv")
item_trans13<-read.csv(file="temp_transcation_13.csv")
item_trans14<-read.csv(file="temp_transcation_14.csv")
item_trans15<-read.csv(file="temp_transcation_15.csv")
item_trans16<-read.csv(file="temp_transcation_16.csv")
item_trans17<-read.csv(file="temp_transcation_17.csv")
item_trans18<-read.csv(file="temp_transcation_18.csv")
item_trans19<-read.csv(file="temp_transcation_19.csv")
item_trans20<-read.csv(file="temp_transcation_20.csv")
item_trans21<-read.csv(file="temp_transcation_21.csv")
item_trans22<-read.csv(file="temp_transcation_22.csv")
item_trans23<-read.csv(file="temp_transcation_23.csv")
item_trans24<-read.csv(file="temp_transcation_24.csv")
item_trans25<-read.csv(file="temp_transcation_25.csv")
item_trans26<-read.csv(file="temp_transcation_26.csv")

setwd("C:\\Users\\aswhazel\\Documents\\data\\2_product")

product<-read.csv(file="product.csv")

items_trans<-rbind(item_trans1,item_trans2,item_trans3,item_trans4,item_trans5,item_trans6,item_trans7
                   ,item_trans8,item_trans9,item_trans10,item_trans11,item_trans12,item_trans13,item_trans14,
                   item_trans15,item_trans16,item_trans17,item_trans18,item_trans19,item_trans20,item_trans21
                   ,item_trans22,item_trans23,item_trans24,item_trans25,item_trans26)
head(items_trans)
dim(items_trans)

min(items_trans$BUSINESS_DATE)
#20150101
max(items_trans$BUSINESS_DATE)
#20161231

setwd("C:\\Users\\aswhazel\\Documents\\data")


save(items_trans,file="item_trans.R")

rm(item_trans1)
rm(item_trans2)
rm(item_trans3)
rm(item_trans4)
rm(item_trans5)
rm(item_trans6)
rm(item_trans7)
rm(item_trans8)
rm(item_trans9)
rm(item_trans10)
rm(item_trans11)
rm(item_trans12)
rm(item_trans13)
rm(item_trans14)
rm(item_trans15)
rm(item_trans16)
rm(item_trans17)
rm(item_trans18)
rm(item_trans19)
rm(item_trans20)
rm(item_trans21)
rm(item_trans22)
rm(item_trans23)
rm(item_trans24)
rm(item_trans25)
rm(item_trans26)

head(item_trans_small)

rm(items_trans)

#take only members
item_trans_small<-subset(items_trans,items_trans$CONTACT_ID>0)
#1 year of data
item_trans_small2<-subset(item_trans_small,item_trans_small$BUSINESS_DATE>20160101)


#append on product info

data<-merge(item_trans_small2,product,by="PRODUCT_ID")

rm(item_trans_small)
rm(item_trans_small2)

setwd("C:\\Users\\aswhazel\\Documents\\data")
save(data,file="data.R")

#baby category
baby<-subset(data,data$PRODUCT_HIER_LVL2=="Baby")

head(baby)

#take 6 months
baby_small<-subset(baby,baby$BUSINESS_DATE>=20160701)


baby_freq<-sqldf("SELECT CONTACT_ID,PRODUCT_ID,COUNT(DISTINCT ORDER_NUMBER) as trans
  FROM baby_small
GROUP BY CONTACT_ID,PRODUCT_ID")

#remove custs with only 1 transaction
baby_small2<-sqldf("SELECT * FROM baby_small where contact_id in (SELECT DISTINCT contact_id from baby_freq where trans>1)")


baby_data<-sqldf("SELECT DISTINCT CONTACT_ID,PRODUCT_NAME FROM baby_small2")


#take a sample for now, due to memory issues
sample<-baby_data[sample(1:nrow(baby_data), 30000, replace=FALSE),]
head(sample)


trans_data <- split(sample$PRODUCT_NAME, sample$CONTACT_ID) 
as(trans_data, "transactions") 

trans_data<-split(sample$PRODUCT_NAME, sample$CONTACT_ID) 



rulesA <- apriori(trans_data, parameter = list(support = 0.001, confidence = 0.01, maxlen = 6, minlen = 2))
rulesA <- sort(rulesA, by = "confidence", decreasing = TRUE)
inspect(rulesA)
summary(rulesA)

#split out lhs & rhs rules into columns
rulesA <- as(rulesA, "data.frame")
rulesA<-rulesA[c(1,3)]

rules_split<-as.data.frame(str_split_fixed(rulesA[,1],"=>",2))
colnames(rules_split)<-c("LHS","RHS")

#add confidence score back in
rulesA.split<-cbind(rules_split,rulesA[,2])

colnames(rulesA.split)[3]<-"confidence_score"

#remove special characters {}

remove <- function (x) gsub("[[:punct:]]", "", x)

rulesA.split$LHS<-remove(rulesA.split$LHS)
rulesA.split$RHS<-remove(rulesA.split$RHS)



head(rulesA.split)
colnames(rulesA.split)[3]<-"confidence_score"

getwd()
write.table(rulesA.split,file="arules.xls")

rulesA.matrix<-acast(rulesA.split, LHS ~ RHS , value.var='confidence_score', 
                     fun.aggregate=sum, margins=FALSE)


##VITAMINS

VITAMINS<-subset(data,data$PRODUCT_HIER_LVL2=="VITAMINS")

head(VITAMINS)

VITAMINS_small<-subset(VITAMINS,VITAMINS$BUSINESS_DATE>=20160701)


vitamins_freq<-sqldf("SELECT CONTACT_ID,PRODUCT_ID,COUNT(DISTINCT ORDER_NUMBER) as trans
  FROM VITAMINS_small
GROUP BY CONTACT_ID,PRODUCT_ID")

#remove custs with only 1 transaction
vitamins_small2<-sqldf("SELECT * FROM VITAMINS_small where contact_id in (SELECT DISTINCT contact_id from vitamins_freq where trans>1)")


vitamins_data<-sqldf("SELECT DISTINCT CONTACT_ID,PRODUCT_NAME FROM vitamins_small2")


trans_data <- split(vitamins_data$PRODUCT_NAME, vitamins_data$CONTACT_ID) 
as(trans_data, "transactions") 

rulesB <- apriori(trans_data, parameter = list(support = 0.001, confidence = 0.1, maxlen = 6, minlen = 2))
rulesB <- sort(rulesB, by = "confidence", decreasing = TRUE)
inspect(rulesB)
summary(rulesB)

#split out lhs & rhs rules into columns
rulesB <- as(rulesB, "data.frame")
rulesB<-rulesB[c(1,3)]

rules_split<-as.data.frame(str_split_fixed(rulesB[,1],"=>",2))
colnames(rules_split)<-c("LHS","RHS")

#add confidence score back in
rulesB.split<-cbind(rules_split,rulesB[,2])

colnames(rulesB.split)[3]<-"confidence_score"

#remove special characters {}

remove <- function (x) gsub("[[:punct:]]", "", x)

rulesB.split$LHS<-remove(rulesB.split$LHS)
rulesB.split$RHS<-remove(rulesB.split$RHS)

head(rulesB.split)


getwd()
write.table(rulesB.split,file="arules vitamins.xls")

rulesB.matrix<-acast(rulesB.split, LHS ~ RHS , value.var='confidence_score', 
                     fun.aggregate=sum, margins=FALSE)

##CONFECTIONERY

CONFEC<-subset(data,data$PRODUCT_HIER_LVL2=="CONFECTIONERY")

head(CONFEC)

CONFEC_small<-subset(CONFEC,CONFEC$BUSINESS_DATE>=20160701)


CONFEC_freq<-sqldf("SELECT CONTACT_ID,PRODUCT_ID,COUNT(DISTINCT ORDER_NUMBER) as trans
                     FROM CONFEC_small
                     GROUP BY CONTACT_ID,PRODUCT_ID")

#remove custs with only 1 transaction
CONFEC_small2<-sqldf("SELECT * FROM CONFEC_small where contact_id in (SELECT DISTINCT contact_id from CONFEC_freq where trans>1)")





CONFEC_data<-sqldf("SELECT DISTINCT CONTACT_ID,PRODUCT_NAME FROM CONFEC_small2")



trans_data <- split(CONFEC_data$PRODUCT_NAME, CONFEC_data$CONTACT_ID) 
as(trans_data, "transactions") 

rulesC <- apriori(trans_data, parameter = list(support = 0.001, confidence = 0.1, maxlen = 6, minlen = 2))
rulesC <- sort(rulesC, by = "confidence", decreasing = TRUE)
inspect(rulesC)
summary(rulesC)

#split out lhs & rhs rules into columns
rulesC <- as(rulesC, "data.frame")
rulesC<-rulesC[c(1,3)]

rules_split<-as.data.frame(str_split_fixed(rulesC[,1],"=>",2))
colnames(rules_split)<-c("LHS","RHS")

#add confidence score back in
rulesC.split<-cbind(rules_split,rulesC[,2])

colnames(rulesC.split)[3]<-"confidence_score"

#remove special characters {}

remove <- function (x) gsub("[[:punct:]]", "", x)

rulesC.split$LHS<-remove(rulesC.split$LHS)
rulesC.split$RHS<-remove(rulesC.split$RHS)



head(rulesC.split)


getwd()
write.table(rulesC.split,file="arules CONFEC.xls")

rulesB.matrix<-acast(rulesB.split, LHS ~ RHS , value.var='confidence_score', 
                     fun.aggregate=sum, margins=FALSE)
