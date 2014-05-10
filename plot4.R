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
  png(filename=paste0(output_path,"/plot4.png"),width=480,height=480,units="px")
  
  
  par(mfrow=c(2,2),mar=c(4,4,4,1.5))
  plot(data[,DateTime],data[,Global_active_power],type="l",xlab="Day Of Week",ylab="Global Active Power (kilowatts)",)
  plot(data[,DateTime],data[,Voltage],type="l",xlab="DateTime",ylab="Voltage")
  
  plot(data[,DateTime],data[,Sub_metering_1],type="l",xlab="Day of Week",ylab="Energy sub metering")
  lines(data[,DateTime],data[,Sub_metering_2],col="red",type="l")
  lines(data[,DateTime],data[,Sub_metering_3],col="blue",type="l")
  legend("topright",c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="n",xjust=1,yjust=1,lwd=0.5)
  
  
  plot(data[,DateTime],data[,Global_reactive_power],type="l",,xlab="DateTime",ylab="Global_reactive_power")
  
  #close device
  dev.off(which=dev.cur())
  
  
}

###################################Function Definitions End####################################






data<-Read_File(filename)
data[,`:=`(
  Global_active_power =as.numeric(Global_active_power),
  Global_reactive_power = as.numeric(Global_reactive_power),
  Voltrage=as.numeric(Voltage),
  Sub_metering_1=as.numeric(Sub_metering_1),
  Sub_metering_2=as.numeric(Sub_metering_2),
  Sub_metering_3=as.numeric(Sub_metering_3)
)]




Generate_Plot(data)
rm(list=ls())
gc()
