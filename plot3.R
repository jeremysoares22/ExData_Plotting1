require(data.table)


##Set Input parameters
filename<-c("C:/Operation Research/R/Training/household_power_consumption.txt")


#set output_path
output_path<-c("C:/Operation Research/R/Training/")


###################################Function Definitions####################################

#read input file
Read_File<-function(filename)
{
   data<-data.table(read.table(filename,header=T, sep=";",fill=TRUE,na.strings=" ",stringsAsFactors=F))[Global_active_power!="?" & (Date=="1/2/2007" | Date=="2/2/2007")]
   data[,DateTime:=as.POSIXct(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S")]
   return(data)
}


Generate_Plot<-function(data)
{
  #open png device
  png(filename=paste0(output_path,"/plot3.png"),width=480,height=480,units="px")
  
  
  plot(data[,DateTime],data[,Sub_metering_1],type="l",xlab="Day of Week",ylab="Energy sub metering")
  lines(data[,DateTime],data[,Sub_metering_2],col="red",type="l")
  lines(data[,DateTime],data[,Sub_metering_3],col="blue",type="l")
  legend("topright",c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=1,col=c("black","red","blue"))
  
  
  #close device
  dev.off(which=dev.cur())
  
  
}

###################################Function Definitions End####################################






data<-Read_File(filename)
data[,`:=`(
          Sub_metering_1=as.numeric(Sub_metering_1),
          Sub_metering_2=as.numeric(Sub_metering_2),
          Sub_metering_3=as.numeric(Sub_metering_3)
  )]
data<-data[,list(DateTime,Sub_metering_1,Sub_metering_2,Sub_metering_3)]
Generate_Plot(data)
rm(list=ls())
gc()
