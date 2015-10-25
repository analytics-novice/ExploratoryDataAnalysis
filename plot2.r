## This first line will likely take a few seconds. Be patient!
getwd()
setwd("D:/Study/Exploratory Data Analysis/CourseProject2")
if(!exists("NEI_data")){
  NEI <- readRDS("./NEI_data/summarySCC_PM25.rds")
  SCC <- readRDS("./NEI_data/Source_Classification_Code.rds")
}
# Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to 
#make a plot answering this question
subSetMaryland <- NEI[NEI$fips=="24510",]
aggregatedTotalByYear <- aggregate(Emissions ~ year, subSetMaryland, sum)

png('plot2.png')
barplot(height=aggregatedTotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*'in Baltimore, Maryland - emissions at various years'))
dev.off()
