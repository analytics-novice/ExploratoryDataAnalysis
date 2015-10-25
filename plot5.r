## This first line will likely take a few seconds. Be patient!
getwd()
setwd("D:/Study/Exploratory Data Analysis/CourseProject2")
if(!exists("NEI_data")){
  NEI <- readRDS("./NEI_data/summarySCC_PM25.rds")
  SCC <- readRDS("./NEI_data/Source_Classification_Code.rds")
}
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
mergedData <- merge(NEI,SCC,by.x = "SCC", by.y = "SCC")

subSetNEI <- mergedData[NEI$fips=="24510" & NEI$type=="ON-ROAD",]

aggregatedTotalByYear <- aggregate(Emissions ~ year , subSetNEI, sum)


png('plot5.png', width = 640, height = 480)
g <- ggplot(aggregatedTotalByYear,aes(factor(year),Emissions))
g <- g + geom_bar(stat = "identity") + xlab("year") + ylab(expression("Total PM 2.5 Emissions")) + ggtitle("Total Emissions from motor vehicle(type = ON-ROAD) in Baltimore, Maryland from 1999 to 2008")
print(g)
dev.off()
