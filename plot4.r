## This first line will likely take a few seconds. Be patient!
getwd()
setwd("D:/Study/Exploratory Data Analysis/CourseProject2")
if(!exists("NEI_data")){
  NEI <- readRDS("./NEI_data/summarySCC_PM25.rds")
  SCC <- readRDS("./NEI_data/Source_Classification_Code.rds")
}
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
# Merge the dat ato get coal information from Source Classifcation Code file
mergedData <- merge(NEI,SCC,by.x = "SCC", by.y = "SCC")
coal <- grepl("coal",mergedData$Short.Name,ignore.case=TRUE)
#Subset for Coal data only
subSetNEICC <- mergedData[coal,]

aggregatedTotalByYear <- aggregate(Emissions ~ year , subSetNEICC, sum)

#Plot and save to file
png('plot4.png', width = 640, height = 480)
g <- ggplot(aggregatedTotalByYear,aes(factor(year),Emissions))
g <- g + geom_bar(stat = "identity") + xlab("year") + ylab(expression("Total PM 2.5 Emissions")) + ggtitle("Total Emissions from coal from 1999 to 2008")
print(g)
dev.off()