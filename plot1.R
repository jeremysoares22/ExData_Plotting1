setwd("C:/Operation Research/R/Training/")
library("data.table")


##Set Input parameters
input_file_path<-c("C:/Operation Research/R/Training/household_power_consumption.txt")


#set output_path
output_path<-c("C:/Operation Research/R/Training/")


###################################Function Definitions####################################

Read_File<-function(filename)
{
   data<-data.table(read.table(filename,header=T, sep=";",fill=TRUE,na.strings=" "))
   data<-data[Global_active_power!="?"]
   data<-data[,Date:=as.Date(Date, "%d/%m/%Y")]
   return(data[Date>="2007-02-01" & Date<="2007-02-02"])
}

Generate_Plot<-function(data)
{
  
  png(filename=paste0(output_path,"/plot1.png"),width=480,height=480,units="px")
  
  hist(data[,as.numeric(Global_active_power)/500],
        main=c("Global Active Power"),
        xlab=c("Global Active power (kilowatts)"),
        ylab=c("Frequency"),
        col="red"
        
        )
    
  dev.off(which=dev.cur())
  
  
}

###################################Function Definitions End####################################






data<-Read_File(input_file_path)
Generate_Plot(data)
