##############################################################################################################################
##############################################################################################################################
##R CODE FOR NET MIGRATION PROFILE ADJUSTMENT COMPARISONS
##
##EDDIE HUNSINGER (AFFILIATION: ALASKA DEPARTMENT OF LABOR AND WORKFORCE DEVELOPMENT), SEPTEMBER 2019
##https://edyhsgr.github.io/
##edyhsgr@protonmail.com
##############################################################################################################################
##############################################################################################################################

library(shiny)

ui<-fluidPage(

	tags$h3("Net Migration Adjustment Comparisons - Using Alaska PFD-Based Migration Data"),
	p("Related information, ",
	tags$a(href="https://www.r-project.org/", "R"),
	"code, and ",
	tags$a(href="https://products.office.com/en-us/excel-c", "Excel"),
	"spreadsheet available at: ",
	tags$a(href="https://github.com/edyhsgr/NetMigrationAdjustCompare", 
	"NetMigrationAdjustCompare GitHub Repository")
),

hr(),

sidebarLayout(
sidebarPanel(

 selectInput("Area", "Area", selected = "Alaska",
c(
"Alaska"="Alaska",
"Aleutians East Census Area"="AleutiansEast",
"Aleutians West Census Area"="AleutiansWest",
"Anchorage Municipality"="Anchorage",
"Bethel Census Area"="Bethel",
"Bristol Bay Borough"="BristolBay",
"Denali Borough"="Denali",
"Dillingham Census Area"="Dillingham",
"Fairbanks North Star Borough"="FairbanksNorthStar",
"Haines City and Borough"="Haines",
"Hoonah-Angoon Census Area"="HoonahAngoon",
"Juneau City and Borough"="Juneau",
"Kenai Peninsula Borough"="KenaiPeninsula",
"Ketchikan Gateway Borough"="KetchikanGateway",
"Kodiak Island Borough"="KodiakIsland",
"Kusilvak Census Area"="Kusilvak",
"Lake and Peninsula Borough"="LakeandPeninsula",
"Matanuska-Susitna Borough"="MatanuskaSusitna",
"Nome Census Area"="Nome",
"North Slope Borough"="NorthSlope",
"Northwest Arctic Borough"="NorthwestArctic",
"Petersburg City and Borough"="Petersburg",
"Prince of Wales-Hyder Census Area"="PrinceofWalesHyder",
"Sitka City and Borough"="Sitka",
"Municipality of Skagway Borough"="Skagway",
"Southeast Fairbanks Census Area"="SoutheastFairbanks",
"Valdez-Cordova Census Area"="ValdezCordova",
"Wrangell City and Borough"="Wrangell",
"Yakutat City and Borough"="Yakutat",
"Yukon-Koyukuk Census Area"="YukonKoyukuk"
),
),

 selectInput("period", "Starting Period", selected = "2010to2015",
c(
"2010 to 2015"="2010to2015",
"2005 to 2010"="2005to2010",
"2000 to 2005"="2000to2005"
),
),

 selectInput("period_Goal", "Period to Match", selected = "2005to2010",
c(
"2010 to 2015"="2010to2015",
"2005 to 2010"="2005to2010",
"2000 to 2005"="2000to2005"
),
),

 selectInput("numberorrate", "Numbers or Age-Specific Rates?",
c(
"Numbers (average annual)"="numbers",
"Age-Specific Rates"="agespecificrates"
),
),

 selectInput("sex", "Sex",
c(
"Total"="Total",
"Male"="Male",
"Female"="Female"
),
),

 selectInput("AreaBorrow", "Borrowed Area (same starting period)", selected = "Anchorage",
c(
"Alaska"="Alaska",
"Aleutians East Census Area"="AleutiansEast",
"Aleutians West Census Area"="AleutiansWest",
"Anchorage Municipality"="Anchorage",
"Bethel Census Area"="Bethel",
"Bristol Bay Borough"="BristolBay",
"Denali Borough"="Denali",
"Dillingham Census Area"="Dillingham",
"Fairbanks North Star Borough"="FairbanksNorthStar",
"Haines City and Borough"="Haines",
"Hoonah-Angoon Census Area"="HoonahAngoon",
"Juneau City and Borough"="Juneau",
"Kenai Peninsula Borough"="KenaiPeninsula",
"Ketchikan Gateway Borough"="KetchikanGateway",
"Kodiak Island Borough"="KodiakIsland",
"Kusilvak Census Area"="Kusilvak",
"Lake and Peninsula Borough"="LakeandPeninsula",
"Matanuska-Susitna Borough"="MatanuskaSusitna",
"Nome Census Area"="Nome",
"North Slope Borough"="NorthSlope",
"Northwest Arctic Borough"="NorthwestArctic",
"Petersburg City and Borough"="Petersburg",
"Prince of Wales-Hyder Census Area"="PrinceofWalesHyder",
"Sitka City and Borough"="Sitka",
"Municipality of Skagway Borough"="Skagway",
"Southeast Fairbanks Census Area"="SoutheastFairbanks",
"Valdez-Cordova Census Area"="ValdezCordova",
"Wrangell City and Borough"="Wrangell",
"Yakutat City and Borough"="Yakutat",
"Yukon-Koyukuk Census Area"="YukonKoyukuk"
),
),

hr(),

p("This interface was made with ",
tags$a(href="https://shiny.rstudio.com/", 
	"Shiny for R."),
       
tags$a(href="https://edyhsgr.github.io/eddieh/", 
	"Eddie Hunsinger,"), 

"September 2019."),

p("Migration data from: ",
tags$a(href="http://live.laborstats.alaska.gov/pop/migration.cfm", 
	"Alaska PFD-Based Migration Data (accessed October 2018)."),

" Population data from: ",
tags$a(href="http://live.laborstats.alaska.gov/pop/index.cfm", 
	"Alaska Population Estimates (accessed October 2018)."),

" Plus-minus method from: ",
tags$a(href="https://books.google.com/books?id=-uPrAAAAMAAJ", 
	"Shyrock and Siegel (1973)."),

"Alaska migration by age over time comparisons: ",
tags$a(href="https://applieddemogtoolbox.shinyapps.io/AKMigrationProfiles/", 
	"Hunsinger (2018) (using the Alaska PFD-Based Migration Data - many thanks to terrific colleagues Eric Sandberg and David Howell).")),

width=3
),

mainPanel(
	plotOutput("plots"),width=3
))
)

#To print full names - thanks https://stackoverflow.com/questions/48106504/r-shiny-how-to-display-choice-label-in-selectinput 
choiceVec <- c(
"Alaska"="Alaska",
"Aleutians East Census Area"="AleutiansEast",
"Aleutians West Census Area"="AleutiansWest",
"Anchorage Municipality"="Anchorage",
"Bethel Census Area"="Bethel",
"Bristol Bay Borough"="BristolBay",
"Denali Borough"="Denali",
"Dillingham Census Area"="Dillingham",
"Fairbanks North Star Borough"="FairbanksNorthStar",
"Haines City and Borough"="Haines",
"Hoonah-Angoon Census Area"="HoonahAngoon",
"Juneau City and Borough"="Juneau",
"Kenai Peninsula Borough"="KenaiPeninsula",
"Ketchikan Gateway Borough"="KetchikanGateway",
"Kodiak Island Borough"="KodiakIsland",
"Kusilvak Census Area"="Kusilvak",
"Lake and Peninsula Borough"="LakeandPeninsula",
"Matanuska-Susitna Borough"="MatanuskaSusitna",
"Nome Census Area"="Nome",
"North Slope Borough"="NorthSlope",
"Northwest Arctic Borough"="NorthwestArctic",
"Petersburg City and Borough"="Petersburg",
"Prince of Wales-Hyder Census Area"="PrinceofWalesHyder",
"Sitka City and Borough"="Sitka",
"Municipality of Skagway Borough"="Skagway",
"Southeast Fairbanks Census Area"="SoutheastFairbanks",
"Valdez-Cordova Census Area"="ValdezCordova",
"Wrangell City and Borough"="Wrangell",
"Yakutat City and Borough"="Yakutat",
"Yukon-Koyukuk Census Area"="YukonKoyukuk"
)

choiceVec2 <- c(
"2000 to 2005"="2000to2005",
"2005 to 2010"="2005to2010",
"2010 to 2015"="2010to2015"
)

choiceVec3 <- c(
"Total"="Total",
"Male"="Male",
"Female"="Female"
)

##Inputs
#For time comparison
PFDInAgeSexBCA0005<-read.table(file="https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/PFDInMigrationByAgeBySexBCA_2000to2005.csv",header=TRUE,sep=",")
PFDOutAgeSexBCA0005<-read.table(file="https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/PFDOutMigrationByAgeBySexBCA_2000to2005.csv",header=TRUE,sep=",")
PFDInAgeSexBCA0510<-read.table(file="https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/PFDInMigrationByAgeBySexBCA_2005to2010.csv",header=TRUE,sep=",")
PFDOutAgeSexBCA0510<-read.table(file="https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/PFDOutMigrationByAgeBySexBCA_2005to2010.csv",header=TRUE,sep=",")
PFDInAgeSexBCA1015<-read.table(file="https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/PFDInMigrationByAgeBySexBCA_2010to2015.csv",header=TRUE,sep=",")
PFDOutAgeSexBCA1015<-read.table(file="https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/PFDOutMigrationByAgeBySexBCA_2010to2015.csv",header=TRUE,sep=",")

#For time comparison
PopAgeSexBCA0005<-read.table(file="https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/PopByAgeBySexBCA_072002.csv",header=TRUE,sep=",")
PopAgeSexBCA0510<-read.table(file="https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/PopByAgeBySexBCA_072007.csv",header=TRUE,sep=",")
PopAgeSexBCA1015<-read.table(file="https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/PopByAgeBySexBCA_072012.csv",header=TRUE,sep=",")

#Some distinguishing characteristics (just Eddie's definitions)
Characteristics<-read.csv(file="https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/AKBCACharacteristics.csv",header=TRUE,sep=",")

server<-function(input, output) {	
	output$plots<-renderPlot({
par(mfrow=c(2,2))
	
##############################################################################################################################
##############################################################################################################################
##########
##Inputs
#PFD migration
PFDInDataFileInput<-paste(c("https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/PFDInMigrationByAgeBySexBCA_",input$period,".csv"),collapse="")
PFDInAgeSexBCA<-read.table(file=PFDInDataFileInput,header=TRUE,sep=",")
PFDOutDataFileInput<-paste(c("https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/PFDOutMigrationByAgeBySexBCA_",input$period,".csv"),collapse="")
PFDOutAgeSexBCA<-read.table(file=PFDOutDataFileInput,header=TRUE,sep=",")

PFDInDataFileInput_Goal<-paste(c("https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/PFDInMigrationByAgeBySexBCA_",input$period_Goal,".csv"),collapse="")
PFDInAgeSexBCA_Goal<-read.table(file=PFDInDataFileInput_Goal,header=TRUE,sep=",")
PFDOutDataFileInput_Goal<-paste(c("https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/PFDOutMigrationByAgeBySexBCA_",input$period_Goal,".csv"),collapse="")
PFDOutAgeSexBCA_Goal<-read.table(file=PFDOutDataFileInput_Goal,header=TRUE,sep=",")

#Population
if (input$period=="2000to2005") {PopDataFileInputYear<-"2002"}
if (input$period=="2005to2010") {PopDataFileInputYear<-"2007"}
if (input$period=="2010to2015") {PopDataFileInputYear<-"2012"}
PopDataFileInput<-paste(c("https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/PopByAgeBySexBCA_07",PopDataFileInputYear,".csv"),collapse="")
PopAgeSexBCA<-read.table(file=PopDataFileInput,header=TRUE,sep=",")

#Population Goal
if (input$period_Goal=="2000to2005") {PopDataFileInputYear_Goal<-"2002"}
if (input$period_Goal=="2005to2010") {PopDataFileInputYear_Goal<-"2007"}
if (input$period_Goal=="2010to2015") {PopDataFileInputYear_Goal<-"2012"}
PopDataFileInput_Goal<-paste(c("https://raw.githubusercontent.com/edyhsgr/AKMigrationProfiles/master/Tables/PopByAgeBySexBCA_07",PopDataFileInputYear_Goal,".csv"),collapse="")
PopAgeSexBCA_Goal<-read.table(file=PopDataFileInput_Goal,header=TRUE,sep=",")

#Age group labels
agegroups <- c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80-84", "85+")
##########
##########

##########
##Selections
#Area and sex for migration
In<-paste(c(input$Area,input$sex,"In"),collapse="")
PFDInAgeSexBCA_1<-PFDInAgeSexBCA[In]
Out<-paste(c(input$Area,input$sex,"Out"),collapse="")
PFDOutAgeSexBCA_1<-PFDOutAgeSexBCA[Out]
PFDInAgeSexBCA_2<-PFDInAgeSexBCA_Goal[In]
PFDOutAgeSexBCA_2<-PFDOutAgeSexBCA_Goal[Out]

InBorrow<-paste(c(input$AreaBorrow,input$sex,"In"),collapse="")
PFDInAgeSexBCABorrow_1<-PFDInAgeSexBCA[InBorrow]
OutBorrow<-paste(c(input$AreaBorrow,input$sex,"Out"),collapse="")
PFDOutAgeSexBCABorrow_1<-PFDOutAgeSexBCA[OutBorrow]

#Area and sex for population
Pop<-paste(c(input$Area,input$sex),collapse="")
PopAgeSexBCA_1<-PopAgeSexBCA[Pop]
PopGoal<-paste(c(input$Area,input$sex),collapse="")
PopAgeSexBCA_2<-PopAgeSexBCA_Goal[Pop]
PopBorrow<-paste(c(input$AreaBorrow,input$sex),collapse="")
PopAgeSexBCABorrow<-PopAgeSexBCA[PopBorrow]

##All years for comparisons
#Area and sex for migration
In0005<-paste(c(input$Area,input$sex,"In"),collapse="")
PFDInAgeSexBCA_0005<-PFDInAgeSexBCA0005[In]
Out0005<-paste(c(input$Area,input$sex,"Out"),collapse="")
PFDOutAgeSexBCA_0005<-PFDOutAgeSexBCA0005[Out]
In0510<-paste(c(input$Area,input$sex,"In"),collapse="")
PFDInAgeSexBCA_0510<-PFDInAgeSexBCA0510[In]
Out0510<-paste(c(input$Area,input$sex,"Out"),collapse="")
PFDOutAgeSexBCA_0510<-PFDOutAgeSexBCA0510[Out]
In1015<-paste(c(input$Area,input$sex,"In"),collapse="")
PFDInAgeSexBCA_1015<-PFDInAgeSexBCA1015[In]
Out1015<-paste(c(input$Area,input$sex,"Out"),collapse="")
PFDOutAgeSexBCA_1015<-PFDOutAgeSexBCA1015[Out]
#Area and sex for population
Pop0005<-paste(c(input$Area,input$sex),collapse="")
PopAgeSexBCA_0005<-PopAgeSexBCA0005[Pop]
Pop0510<-paste(c(input$Area,input$sex),collapse="")
PopAgeSexBCA_0510<-PopAgeSexBCA0510[Pop]
Pop1015<-paste(c(input$Area,input$sex),collapse="")
PopAgeSexBCA_1015<-PopAgeSexBCA1015[Pop]

##Calculations
if(input$numberorrate=="agespecificrates"){
In<-PFDInAgeSexBCA_1[2:19,]/PopAgeSexBCA_1[2:19,]}
if(input$numberorrate=="numbers"){
In<-PFDInAgeSexBCA_1[2:19,]}

if(input$numberorrate=="agespecificrates"){
Out<-PFDOutAgeSexBCA_1[2:19,]/PopAgeSexBCA_1[2:19,]}
if(input$numberorrate=="numbers"){
Out<-PFDOutAgeSexBCA_1[2:19,]}

Net<-In-Out

if(input$numberorrate=="agespecificrates"){
InGoal<-PFDInAgeSexBCA_2[2:19,]/PopAgeSexBCA_2[2:19,]}
if(input$numberorrate=="numbers"){
InGoal<-PFDInAgeSexBCA_2[2:19,]}

if(input$numberorrate=="agespecificrates"){
OutGoal<-PFDOutAgeSexBCA_2[2:19,]/PopAgeSexBCA_2[2:19,]}
if(input$numberorrate=="numbers"){
OutGoal<-PFDOutAgeSexBCA_2[2:19,]}

NetGoal<-InGoal-OutGoal

NetAdjustByIns<-Net+(sum(NetGoal)-sum(Net))*(In/sum(In))
ErrorNetAdjustByIns<-sum(abs(NetAdjustByIns-NetGoal))

NetAdjustByOuts<-Net+(sum(NetGoal)-sum(Net))*(Out/sum(Out))
ErrorNetAdjustByOuts<-sum(abs(NetAdjustByOuts-NetGoal))

NetAdjustByGross<-Net+(sum(NetGoal)-sum(Net))*((In+Out)/(sum(In)+sum(Out)))
ErrorNetAdjustByGross<-sum(abs(NetAdjustByGross-NetGoal))

if(input$numberorrate=="agespecificrates"){
InBorrowed<-PFDInAgeSexBCABorrow_1[2:19,]/PopAgeSexBCABorrow[2:19,]}
if(input$numberorrate=="numbers"){
InBorrowed<-PFDInAgeSexBCABorrow_1[2:19,]}

if(input$numberorrate=="agespecificrates"){
OutBorrowed<-PFDOutAgeSexBCABorrow_1[2:19,]/PopAgeSexBCABorrow[2:19,]}
if(input$numberorrate=="numbers"){
OutBorrowed<-PFDOutAgeSexBCABorrow_1[2:19,]}
NetAdjustByBorrowed<-Net+(sum(NetGoal)-sum(Net))*((InBorrowed+OutBorrowed)/(sum(InBorrowed)+sum(OutBorrowed)))
ErrorNetAdjustByBorrowed<-sum(abs(NetAdjustByBorrowed-NetGoal))

NetAdjustPlusMinus<-Net
for (i in 1:length(Net)){if(Net[i]>0){NetAdjustPlusMinus[i]<-((sum(abs(Net))+(sum(NetGoal)-sum(Net)))/sum(abs(Net)))*Net[i]}}
for (i in 1:length(Net)){if(Net[i]<0){NetAdjustPlusMinus[i]<-((sum(abs(Net))-(sum(NetGoal)-sum(Net)))/sum(abs(Net)))*Net[i]}}
ErrorNetAdjustPlusMinus<-sum(abs(NetAdjustPlusMinus-NetGoal))

NetAdjustUniform<-Net
for (i in 1:18) {NetAdjustUniform[i]<-Net[i]+(sum(NetGoal)-sum(Net))/18}
ErrorNetAdjustUniform<-sum(abs(NetAdjustUniform-NetGoal))

##Graphing
plot(Net,type="l",lwd=5,ylim=c(-sum(abs(NetGoal))/3,sum(abs(NetGoal))/3),ylab="Net Migration",xlab="",axes=F)
lines(NetGoal,col=2,lwd=5)
lines(NetAdjustByIns,col=3,lwd=3)
lines(NetAdjustByOuts,col=4,lwd=3)
lines(NetAdjustByGross,col=5,lwd=3)
lines(NetAdjustByBorrowed,col=6,lwd=3)
lines(NetAdjustPlusMinus,col="orange",lwd=3)
lines(NetAdjustUniform,col=8,lwd=3)
axis(side=1,at=1:18,las=2,labels=agegroups,cex.axis=0.9)
axis(side=2,cex.axis=0.9)
legend(10,sum(abs(NetGoal))/3, 
legend=c("Starting Profile", "Profile to Match", "With Starting In-Migration", "With Starting Out-Migration", "With Starting Gross Migration", "With Borrowed Gross Migration", "With Plus-Minus Method", "With Uniform"), 
col=c(1,2,3,4,5,6,"orange",8), 
lwd=c(5,5,3,3,3,3,3,3),cex=1)
title("Different Level Adjustment Weightings for Net Migration by Age")
mtext(paste(c("(",names(choiceVec)[choiceVec == input$Area],"'s ",PopDataFileInputYear," total population: ",PopAgeSexBCA_1[1,],")"),collapse=""),line=0,adj=.5)

adjustmentmethodlabel<-c("Starting In-Migration", "Starting Out-Migration", "Starting Gross Migration", "Borrowed Gross Migration", "Plus-Minus Method", "Uniform")

barplot(c(ErrorNetAdjustByIns,ErrorNetAdjustByOuts,ErrorNetAdjustByGross,ErrorNetAdjustByBorrowed,ErrorNetAdjustPlusMinus,ErrorNetAdjustUniform),names.arg=adjustmentmethodlabel,col=c(3,4,5,6,"orange",8),las=2)
title("Sum of Absolute Errors by Weighting Type")

},height=1000,width=1000)
		
}

shinyApp(ui = ui, server = server)
