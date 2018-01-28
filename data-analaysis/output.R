setwd("C:\\Users\\aswhazel\\Documents\\data")

library(sqldf)

load(file="data.R")

head(data)


tbp<-sqldf("select  
CONTACT_ID
,       PRODUCT_HIER_LVL2
,       PRODUCT_NAME
,       case when mem_trxs>1 then cast((max_date-min_date)/(mem_trxs-1) as decimal(5,2)) else 0 end as tbp
,       total_mem_sales
,       tot_mem_quantity
,       mem_trxs
from  (
  select  
    
    t.CONTACT_ID
  ,       PRODUCT_HIER_LVL2
  ,       PRODUCT_NAME
  ,       min(to_date(t.BUSINESS_DATE,'yyyymmdd')) as min_date
  ,       max(to_date(t.BUSINESS_DATE,'yyyymmdd')) as max_date
  ,       sum(t.ITEM_AMOUNT) total_mem_sales
  ,       sum(t.ITEM_QUANTITY) tot_mem_quantity
  ,       count(distinct t.ORDER_NUMBER) as mem_trxs
  from data t
  where t.CONTACT_ID >0
  product
  group by  
  ,         t.CONTACT_ID
  ,       PRODUCT_HIER_LVL2
  ,       PRODUCT_NAME
)")
