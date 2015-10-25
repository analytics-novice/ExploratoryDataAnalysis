## This first line will likely take a few seconds. Be patient!
getwd()
setwd("D:/Study/Exploratory Data Analysis/CourseProject2")
if(!exists("NEI_data")){
  NEI <- readRDS("./NEI_data/summarySCC_PM25.rds")
  SCC <- readRDS("./NEI_data/Source_Classification_Code.rds")
}
# Of the four types of sources indicated by the type (point, nonpoint, onroad, 
#nonroad) variable, which of these four sources have seen decreases in emissions 
#from 1999-2008 for Baltimore City? Which have seen increases in emissions from 
#1999-2008? Use the ggplot2 plotting system to make a plot answer this question
subSetMaryland <- NEI[NEI$fips=="24510",]
aggregatedTotalByYearAndType <- aggregate(Emissions ~ year + type, subSetMaryland, sum)

#Plot and save to file
png('plot3.png', width = 640, height = 480)
g <- ggplot(aggregatedTotalByYearAndType,aes(year,Emissions,color=type))
g <- g + geom_line() + xlab("year") + ylab(expression("Total PM 2.5 Emissions")) + ggtitle("Total Emissions in Baltimore City,Maryland")
print(g)
dev.off()
