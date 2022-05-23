##########
#R CODE FOR NET MIGRATION ADJUSTMENT COMPARISONS, USING ALASKA PFD-BASED MIGRATION DATA
#
#EDDIE HUNSINGER, SEPTEMBER 2019
#https://edyhsgr.github.io/eddieh/
#
#IF YOU WOULD LIKE TO USE, SHARE OR REPRODUCE THIS CODE, BE SURE TO CITE THE SOURCE
#
#EXAMPLE DATA IS LINKED, SO YOU SHOULD BE ABLE TO SIMPLY COPY ALL AND PASTE INTO R
#
#THERE IS NO WARRANTY FOR THIS CODE
#THIS CODE HAS NOT BEEN TESTED AT ALL-- PLEASE LET ME KNOW IF YOU FIND ANY PROBLEMS (edyhsgr@gmail.com)
##########

##Data inputs
#Migration
PFDInAgeSexBCA<-read.table("http://www.demog.berkeley.edu/~eddieh/AKMigration/PFDInMigrationByAgeBySexBCA_2010to2015",header=TRUE,sep=",")
PFDOutAgeSexBCA<-read.table("http://www.demog.berkeley.edu/~eddieh/AKMigration/PFDOutMigrationByAgeBySexBCA_2010to2015",header=TRUE,sep=",")
PFDInAgeSexBCA_Goal<-read.table("http://www.demog.berkeley.edu/~eddieh/AKMigration/PFDInMigrationByAgeBySexBCA_2005to2010",header=TRUE,sep=",")
PFDOutAgeSexBCA_Goal<-read.table("http://www.demog.berkeley.edu/~eddieh/AKMigration/PFDOutMigrationByAgeBySexBCA_2005to2010",header=TRUE,sep=",")
PopAgeSexBCA<-read.table("http://www.demog.berkeley.edu/~eddieh/AKMigration/PopByAgeBySexBCA_072012",header=TRUE,sep=",")
PopAgeSexBCA_Goal<-read.table("http://www.demog.berkeley.edu/~eddieh/AKMigration/PopByAgeBySexBCA_072007",header=TRUE,sep=",")

##Calculations
In<-PFDInAgeSexBCA$JuneauTotalIn[2:19]
Out<-PFDOutAgeSexBCA$JuneauTotalOut[2:19]
Net<-In-Out

InGoal<-PFDInAgeSexBCA_Goal$JuneauTotalIn[2:19]
OutGoal<-PFDOutAgeSexBCA_Goal$JuneauTotalOut[2:19]
NetGoal<-InGoal-OutGoal

NetAdjustByIns<-Net+(sum(NetGoal)-sum(Net))*(In/sum(In))
ErrorNetAdjustByIns<-sum(abs(NetAdjustByIns-NetGoal))

NetAdjustByOuts<-Net+(sum(NetGoal)-sum(Net))*(Out/sum(Out))
ErrorNetAdjustByOuts<-sum(abs(NetAdjustByOuts-NetGoal))

NetAdjustByGross<-Net+(sum(NetGoal)-sum(Net))*((In+Out)/(sum(In)+sum(Out)))
ErrorNetAdjustByGross<-sum(abs(NetAdjustByGross-NetGoal))

InBorrowed<-PFDInAgeSexBCA$AnchorageTotalIn[2:19]
OutBorrowed<-PFDOutAgeSexBCA$AnchorageTotalOut[2:19]
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
agegroups <- c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80-84", "85+")
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
legend=c("Starting Profile", "Profile to Match", "Starting In-Migration", "Starting Out-Migration", "Starting Gross Migration", "Borrowed Gross Migration", "Plus-Minus Method", "Uniform"), 
col=c(1,2,3,4,5,6,"orange",8), 
lwd=c(5,5,3,3,3,3,3,3),cex=.9)
title("Different Level Adjustment Weightings for Net Migration by Age")
mtext(paste(c("(Juneau's 2012 total population: ",PopAgeSexBCA$JuneauTotal[1],")"),collapse=""),line=0,adj=.5)
Sys.sleep(3)

adjustmentmethodlabel<-c("Starting In-Migration", "Starting Out-Migration", "Starting Gross Migration", "Borrowed Gross Migration", "Plus-Minus Method", "Uniform")
barplot(c(ErrorNetAdjustByIns,ErrorNetAdjustByOuts,ErrorNetAdjustByGross,ErrorNetAdjustByBorrowed,ErrorNetAdjustPlusMinus,ErrorNetAdjustUniform),names.arg=adjustmentmethodlabel,col=c(3,4,5,6,"orange",8),las=2)
title("Sum of Absolute Errors by Weighting Type")
Sys.sleep(3)

##Calculations (with age specific rates)
In<-PFDInAgeSexBCA$JuneauTotalIn[2:19]/PopAgeSexBCA$JuneauTotal[2:19]
Out<-PFDOutAgeSexBCA$JuneauTotalOut[2:19]/PopAgeSexBCA$JuneauTotal[2:19]
Net<-In-Out

InGoal<-PFDInAgeSexBCA_Goal$JuneauTotalIn[2:19]/PopAgeSexBCA_Goal$JuneauTotal[2:19]
OutGoal<-PFDOutAgeSexBCA_Goal$JuneauTotalOut[2:19]/PopAgeSexBCA_Goal$JuneauTotal[2:19]
NetGoal<-InGoal-OutGoal

NetAdjustByIns<-Net+(sum(NetGoal)-sum(Net))*(In/sum(In))
ErrorNetAdjustByIns<-sum(abs(NetAdjustByIns-NetGoal))

NetAdjustByOuts<-Net+(sum(NetGoal)-sum(Net))*(Out/sum(Out))
ErrorNetAdjustByOuts<-sum(abs(NetAdjustByOuts-NetGoal))

NetAdjustByGross<-Net+(sum(NetGoal)-sum(Net))*((In+Out)/(sum(In)+sum(Out)))
ErrorNetAdjustByGross<-sum(abs(NetAdjustByGross-NetGoal))

InBorrowed<-PFDInAgeSexBCA$AnchorageTotalIn[2:19]/PopAgeSexBCA$AnchorageTotal[2:19]
OutBorrowed<-PFDOutAgeSexBCA$AnchorageTotalOut[2:19]/PopAgeSexBCA$AnchorageTotal[2:19]
NetAdjustByBorrowed<-Net+(sum(NetGoal)-sum(Net))*((InBorrowed+OutBorrowed)/(sum(InBorrowed)+sum(OutBorrowed)))
ErrorNetAdjustByBorrowed<-sum(abs(NetAdjustByBorrowed-NetGoal))

NetAdjustPlusMinus<-Net
for (i in 1:length(Net)){if(Net[i]>0){NetAdjustPlusMinus[i]<-((sum(abs(Net))+(sum(NetGoal)-sum(Net)))/sum(abs(Net)))*Net[i]}}
for (i in 1:length(Net)){if(Net[i]<0){NetAdjustPlusMinus[i]<-((sum(abs(Net))-(sum(NetGoal)-sum(Net)))/sum(abs(Net)))*Net[i]}}
ErrorNetAdjustPlusMinus<-sum(abs(NetAdjustPlusMinus-NetGoal))

NetAdjustUniform<-Net
for (i in 1:18) {NetAdjustUniform[i]<-Net[i]+(sum(NetGoal)-sum(Net))/18}
ErrorNetAdjustUniform<-sum(abs(NetAdjustUniform-NetGoal))

##Graphing (with age specific rates)
agegroups <- c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80-84", "85+")
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
legend=c("Starting Profile", "Profile to Match", "Starting In-Migration", "Starting Out-Migration", "Starting Gross Migration", "Borrowed Gross Migration", "Plus-Minus Method", "Uniform"), 
col=c(1,2,3,4,5,6,"orange",8), 
lwd=c(5,5,3,3,3,3,3,3),cex=.9)
title("Different Level Adjustment Weightings for Net Migration by Age")
mtext(paste(c("(Juneau's 2012 total population: ",PopAgeSexBCA$JuneauTotal[1],")"),collapse=""),line=0,adj=.5)
Sys.sleep(3)

adjustmentmethodlabel<-c("Starting In-Migration", "Starting Out-Migration", "Starting Gross Migration", "Borrowed Gross Migration", "Plus-Minus Method", "Uniform")
barplot(c(ErrorNetAdjustByIns,ErrorNetAdjustByOuts,ErrorNetAdjustByGross,ErrorNetAdjustByBorrowed,ErrorNetAdjustPlusMinus,ErrorNetAdjustUniform),names.arg=adjustmentmethodlabel,col=c(3,4,5,6,"orange",8),las=2)
title("Sum of Absolute Errors by Weighting Type")
Sys.sleep(3)

