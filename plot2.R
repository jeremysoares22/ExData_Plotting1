require(data.table)


##Set Input parameters
filename<-c("C:/Operation Research/R/Training/household_power_consumption.txt")


#set output_path
output_path<-c("C:/Operation Research/R/Training/")


###################################Function Definitions####################################

#read input file
Read_File<-function(filename)
{
   data<-data.table(read.table(filename,header=T, sep=";",fill=TRUE,na.strings=" "))[Global_active_power!="?" & (Date=="1/2/2007" | Date=="2/2/2007")]
   data[,DateTime:=as.POSIXct(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S")]
   return(data)
}


Generate_Plot<-function(data)
{
  #open png device
  png(filename=paste0(output_path,"/plot2.png"),width=480,height=480,units="px")
  
  #plot DateTime vs Global Active Power
  plot(data,type="l",xlab="Day Of Week",ylab="Global Active Power (kilowatts)")
    
  #close device
  dev.off(which=dev.cur())
  
  
}

###################################Function Definitions End####################################






data<-Read_File(filename)
data<-data[,list(DateTime,as.numeric(Global_active_power)/500)]
Generate_Plot(data)
rm(list=ls())
gc()
