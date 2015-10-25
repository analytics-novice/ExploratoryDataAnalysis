## This first line will likely take a few seconds. Be patient!
getwd()
setwd("D:/Study/Exploratory Data Analysis/CourseProject2")
if(!exists("NEI_data")){
  NEI <- readRDS("./NEI_data/summarySCC_PM25.rds")
  SCC <- readRDS("./NEI_data/Source_Classification_Code.rds")
}
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?
mergedData <- merge(NEI,SCC,by.x = "SCC", by.y = "SCC")

#Subset data
subSetNEI <- NEI[(NEI$fips=="24510" | NEI$fips=="06037") & NEI$type=="ON-ROAD",]

aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips , subSetNEI, sum)
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

#Plot and save to file
png('plot6.png', width = 640, height = 480)
g <- ggplot(aggregatedTotalByYearAndFips,aes(factor(year),Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat = "identity") + xlab("year") + ylab(expression("Total PM 2.5 Emissions")) + ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()
