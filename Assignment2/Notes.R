

## have ing trouble downloading a file 

if(!file.exists("exdata_data_NEI_data.zip")){
  fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileUrl,destfile="exdata_data_NEI_data.zip")
  unzip("exdata_data_NEI_data.zip")
} 

## C"T GET THIS TO WORK IN THE .Rmd file will use downloader library

```{r}
fileUrl<-"http://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
download.file(fileUrl,destfile="repdata_data_StormData.csv.bz2")

```


## i want something like this 
## from here 
## http://rstudio-pubs-static.s3.amazonaws.com/13913_3cff98331be44a76a72f26d713e4d44b.html
if(!file.exists("repdata_data_StormData.csv.bz2")){
  fileUrl<-"https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
  download.file(fileUrl,destfile="repdata_data_StormData.csv.bz2")
  bunzip2("repdata_data_StormData.csv.bz2")
} 

# for bunzip
library(R.utils)

## unzipping the file 
bunzip2("repdata_data_StormData.csv.bz2")

## read in the file 
d<-read.csv("")

##########################################################################
downloading the data and unzipping
#############################################################################

```{r}
##load the necessary librarys 
library(tools)  # md5sum
library(R.utils)  # bunzip2
library(downloader) # cross platform downloader 
dir() # a look at curreent directory
URL<-"https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
bz2.filename<-"repdata_data_StormData.csv.bz2"
download(URL, bz2.filename, mode = "wb") 
dir()
bunzip2(bz2.filename,remove=F) #unzip the file; Do not remove the file
dir()

```

```{r}
##load the necessary librarys 
library(tools)  # md5sum
library(R.utils)  # bunzip2
library(downloader) # cross platform downloader 
dir() # a look at curreent directory
URL<-"https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
bz2.filename<-"repdata_data_StormData.csv.bz2"
csv.filename<-"repdata_data_StormData.csv"

##if the zip file does not exist download file
if(!file.exists(bz2.filename)){
  download(URL, bz2.filename, mode = "wb")  
} 
dir() # a new bz2 file should be present 
##if the csv file does not exist unzip the file
if(!file.exists(csv.filename)){
  bunzip2(bz2.filename,remove=F) #unzip the file; Do not remove the zipped file
dir() # a new csv file should be present 

```



##########################################################################
Understanding the data
#############################################################################

## read the data 
d<-read.csv("repdata_data_StormData.csv",as.is=T)[,1:8] # jsut the 8 columns for speed 


> length(unique(d$EVTYPE))
[1] 985
> dim(d)
[1] 902297     37
> names(d)
[1] "STATE__"    "BGN_DATE"   "BGN_TIME"   "TIME_ZONE"  "COUNTY"     "COUNTYNAME" "STATE"     
[8] "EVTYPE"     "BGN_RANGE"  "BGN_AZI"    "BGN_LOCATI" "END_DATE"   "END_TIME"   "COUNTY_END"
[15] "COUNTYENDN" "END_RANGE"  "END_AZI"    "END_LOCATI" "LENGTH"     "WIDTH"      "F"         
[22] "MAG"        "FATALITIES" "INJURIES"   "PROPDMG"    "PROPDMGEXP" "CROPDMG"    "CROPDMGEXP"
[29] "WFO"        "STATEOFFIC" "ZONENAMES"  "LATITUDE"   "LONGITUDE"  "LATITUDE_E" "LONGITUDE_"
[36] "REMARKS"    "REFNUM"    
>
  
  
#############
categorising the column

> a<-unique(d$EVTYPE)
> length(a)
[1] 985
> a[1:10]
[1] "TORNADO"                   "TSTM WIND"                 "HAIL"                     
[4] "FREEZING RAIN"             "SNOW"                      "ICE STORM/FLASH FLOOD"    
[7] "SNOW/ICE"                  "WINTER STORM"              "HURRICANE OPAL/HIGH WINDS"
[10] "THUNDERSTORM WINDS"       
> grep("WIND",a[1:10],ignore.case=T)
[1]  2  9 10
> grepl("WIND",a[1:10],ignore.case=T)
[1] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE
> sum(grepl("WIND",a[1:10],ignore.case=T))
[1] 3
> grepl("WIND"," Wind ",ignore.case=T)
[1] TRUE
> sum(grepl("WIND",a,ignore.case=T))
[1] 234
> sum(grepl("TORNADO",a,ignore.case=T))
[1] 15
> sum(grepl("RAIN",a,ignore.case=T))
[1] 77
> sum(grepl("HURRICANE",a,ignore.case=T))
[1] 10
> sum(grepl("SNOW",a,ignore.case=T))
[1] 132
> sum(grepl("HAIL",a,ignore.case=T))
[1] 47
> sum(grepl("DUST",a,ignore.case=T))
[1] 11
> sum(grepl("SMOKE",a,ignore.case=T))
[1] 2
> sum(grepl("SUMMARY",a,ignore.case=T))
[1] 67
> sum(grepl("SEAS",a,ignore.case=T))
[1] 24
> sum(grepl("ICE",a,ignore.case=T))
[1] 36
> sum(grepl("WAVE",a,ignore.case=T))
[1] 9
> sum(grepl("RIVER",a,ignore.case=T))
[1] 5
> sum(grepl("FLOOD",a,ignore.case=T))
[1] 112
> sum(grepl("STORM",a,ignore.case=T))
[1] 128
> a[1:10]
[1] "TORNADO"                   "TSTM WIND"                 "HAIL"                     
[4] "FREEZING RAIN"             "SNOW"                      "ICE STORM/FLASH FLOOD"    
[7] "SNOW/ICE"                  "WINTER STORM"              "HURRICANE OPAL/HIGH WINDS"
[10] "THUNDERSTORM WINDS"       
> a[111:120]
[1] "HIGH SURF"               "BLOWING DUST"            "URBAN/SMALL"            
[4] "WILD FIRES"              "HIGH"                    "URBAN/SMALL FLOODING"   
[7] "WATER SPOUT"             "HIGH WINDS DUST STORM"   "WINTER STORM HIGH WINDS"
[10] "LOCAL FLOOD"            
> sum(grepl("STORM",a[111:120],ignore.case=T))
[1] 2
> sum(grepl("WIND",a[111:120],ignore.case=T))
[1] 2
>

  
#####################################################
want to concentrate on these 

> sum(grepl("WIND",a,ignore.case=T))
[1] 234

> sum(grepl("SNOW",a,ignore.case=T))
[1] 132

> sum(grepl("FLOOD",a,ignore.case=T))
[1] 112
> sum(grepl("STORM",a,ignore.case=T))
[1] 128
> sum(grepl("RAIN",a,ignore.case=T))
[1] 77
> sum(grepl("SUMMARY",a,ignore.case=T))
[1] 67
> sum(grepl("HAIL",a,ignore.case=T))
[1] 47

b<-a
b<-gsub("WIND","WIND",b,ignore.case=T)


> b<-gsub(".*WIND.*","WIND",b,ignore.case=T)
> length(b)
[1] 985
> length(unique(b)
         + )
[1] 752
> b<-gsub(".*SNOW.*","WIND",b,ignore.case=T)
> length(unique(b))
[1] 636
> b<-gsub(".*FLOOD.*","WIND",b,ignore.case=T)
> length(unique(b))
[1] 537
> b<-gsub(".*STORM.*","WIND",b,ignore.case=T)
> length(unique(b))
[1] 500
> b<-gsub(".*RAIN.*","WIND",b,ignore.case=T)
> length(unique(b))
[1] 459
> b<-gsub(".*HAIL.*","WIND",b,ignore.case=T)
> length(unique(b))
[1] 428
> b<-gsub(".*SUMMARY.*","WIND",b,ignore.case=T)
> length(unique(b))
[1] 361
> b<-gsub(".*ICE.*","ICE",b,ignore.case=T)
> length(unique(b))
[1] 351
> b<-gsub(".*COLD.*","COLD",b,ignore.case=T)
> length(unique(b))
[1] 324
> b<-gsub(".*HOT.*","COLD",b,ignore.case=T)
> length(unique(b))
[1] 317
> b<-gsub(".*HURRICANE.*","HURRICANE",b,ignore.case=T)
> length(unique(b))
[1] 309
> b<-gsub(".*TORNADO.*","TORNADO",b,ignore.case=T)
> length(unique(b))
[1] 297
> b<-gsub(".*SURF.*","SURF",b,ignore.case=T)
> length(unique(b))
[1] 286
> b<-gsub(".*DRY.*","DRY",b,ignore.case=T)
> length(unique(b))
[1] 265
> b<-gsub(".*WARM.*","WARM",b,ignore.case=T)
> length(unique(b))
[1] 251
> b<-gsub(".*LOW.*","LOW",b,ignore.case=T)
> length(unique(b))
[1] 243
> b<-gsub(".*LIGHTNING.*","LIGHTNING",b,ignore.case=T)
> length(unique(b))
[1] 237
> b<-gsub(".*DAM.*","DAM",b,ignore.case=T)
> length(unique(b))
[1] 234

######################
Now I have got this 
#######################

> sum(grepl("ICE",a,ignore.case=T))
[1] 36
> sum(grepl("ICE",b,ignore.case=T))
[1] 11
> sum(grepl("SURF",b,ignore.case=T))
[1] 12
> sum(grepl("HURRICANE",b,ignore.case=T))
[1] 9
> sum(grepl("TORNADO",b,ignore.case=T))
[1] 14
> sum(grepl("WET",b,ignore.case=T))
[1] 14
> sum(grepl("SMOKE",b,ignore.case=T))
[1] 2
> sum(grepl("TIDE",b,ignore.case=T))
[1] 5
> sum(grepl("HOT",b,ignore.case=T))
[1] 7
> sum(grepl("COLD",b,ignore.case=T))
[1] 28
> sum(grepl("DRY",b,ignore.case=T))
[1] 25

### should have use b here 

> sum(grepl("record high",a,ignore.case=T))
[1] 4
> sum(grepl("record low",a,ignore.case=T))
[1] 2
> sum(grepl("dust",a,ignore.case=T))
[1] 11
> sum(grepl("drowning",a,ignore.case=T))
[1] 1
> sum(grepl("smoke",a,ignore.case=T))
[1] 2
> sum(grepl("DAM",a,ignore.case=T))
[1] 14
> sum(grepl("FIRE",a,ignore.case=T))
[1] 11
> sum(grepl("TIDE",a,ignore.case=T))
[1] 7
> sum(grepl("WARM",a,ignore.case=T))
[1] 17
> sum(grepl("PRECIPITATION",a,ignore.case=T))
[1] 9
> sum(grepl("LOW",a,ignore.case=T))
[1] 23
> sum(grepl("Unusual",a,ignore.case=T))
[1] 5
> sum(grepl("lightning",a,ignore.case=T))
[1] 17
> sum(grepl("freeze",a,ignore.case=T))
[1] 11
>

  
cat<-=c("WIND","SNOW","FLOOD","STORM","RAIN","HAIL")


for (i in cat){
  print(i)
  }

## accept a list of strings that need sorting into categories 

categorise<-function (list,categories){
  for (i in cat){
    pattern<-paste(".*",i,".*",sep="")
    ##print(pattern)
    list<-gsub(pattern,i,list,ignore.case=T)
    ##print(list)
    
  }
  list  ## return the categorised list
}

function categorise(list,categories){
  "test"
}




######################################################
Okay this is the function I want to create the categories 
######################################################

## categorise<-function that
## accepts a *list* of strings that need sorting into *categories* 
categorise<-function (list,categories){
  for (i in cat){
    pattern<-paste(".*",i,".*",sep="")
    list<-gsub(pattern,i,list,ignore.case=T)
  }
  list  ## return the categorised list
}


lapply(sort(table(z2)),sum)  ## useful for looking at the sorted categories 

####################################################
How do i assign to all the others that I cannot categorise 
#####################################################

> q<-c("A","B","C") ## list
> w<-c("B","D","E") ## cat
> e<-q %in% w
> e
[1] FALSE  TRUE FALSE
q[q %in% w] <- "Other" 


########### this is what I want 
> q<-c("A","B","C") ## list
> w<-c("B","D","E") ## cat
> q
[1] "A" "B" "C"
> w
[1] "B" "D" "E"
> q[q %in% w] <- "Other" 
> q
[1] "A"     "Other" "C"    
> 
  
################### TRY ING TO APPLY IT 
  > length(z2)
[1] 985
> length(unique(z2)
         + )
[1] 126
> length(cat)
[1] 36
> z2[z2 %in% cat] <- "Other"
> length(unique(z2)
         + )
[1] 90


################## NEED TO USE THE NOT OPERATOR 

> q<-c("A","B","C") ## list
> w<-c("B","D","E") ## cat
> q[q !%in% w] <- "Other"
Error: unexpected '!' in "q[q !"
> q[!(q %in% w)] <- "Other"
> q
[1] "Other" "B"     "Other"
>


  ################################################
  WORKS GETTING MY CATEGORIES from 985 values down to 37 categories
################### APPLYING IT AND IT WORKS 
cat<-c("WIND","SNOW","FLOOD","STORM","RAIN","HAIL","SUMMARY","ICE","COLD","HOT","HURRICANE","TORNADO","SURF","DRY","WARM","LIGHTNING","DAM","PRECIPITATION","TEMPERATURE","LAND","FREEZ","FIRE","VOLCANIC","WATER","WINT","CLOUD","SHOWER","HEAT","TIDE","URBAN","STREAM","RECORD","SEA","MARINE","ROAD","WET")  
> cat
[1] "CLOUD"         "COLD"          "DAM"           "DRY"           "FIRE"         
[6] "FLOOD"         "FREEZ"         "HAIL"          "HEAT"          "HOT"          
[11] "HURRICANE"     "ICE"           "LAND"          "LIGHTNING"     "MARINE"       
[16] "PRECIPITATION" "RAIN"          "RECORD"        "ROAD"          "SEA"          
[21] "SHOWER"        "SNOW"          "STORM"         "STREAM"        "SUMMARY"      
[26] "SURF"          "TEMPERATURE"   "TIDE"          "TORNADO"       "URBAN"        
[31] "VOLCANIC"      "WARM"          "WATER"         "WET"           "WIND"         
[36] "WINT"         
> length(unique(z))
[1] 985
> z2<-categorise(z,cat)
> length(unique(z2))
[1] 126
> z2[!(z2 %in% cat)]<- "Other"
> length(unique(z2))
[1] 37

#####################
Applying this to a df
#######################
> cat
[1] "CLOUD"         "COLD"          "DAM"           "DRY"           "FIRE"         
[6] "FLOOD"         "FREEZ"         "HAIL"          "HEAT"          "HOT"          
[11] "HURRICANE"     "ICE"           "LAND"          "LIGHTNING"     "MARINE"       
[16] "PRECIPITATION" "RAIN"          "RECORD"        "ROAD"          "SEA"          
[21] "SHOWER"        "SNOW"          "STORM"         "STREAM"        "SUMMARY"      
[26] "SURF"          "TEMPERATURE"   "TIDE"          "TORNADO"       "URBAN"        
[31] "VOLCANIC"      "WARM"          "WATER"         "WET"           "WIND"         
[36] "WINT"         
> categorise<-function (list,categories){
  +     for (i in cat){
    +         pattern<-paste(".*",i,".*",sep="")
    +         list<-gsub(pattern,i,list,ignore.case=T)
    +     }
  +     list  ## return the categorised list
  + }
> d_5cols$EVTYPE<-categorise(d_5cols$EVTYPE,cat)
> unique(d_5cols$EVTYPE)
[1] "TORNADO"               "WIND"                  "HAIL"                 
[4] "FREEZ"                 "SNOW"                  "FLOOD"                
[7] "ICE"                   "STORM"                 "HURRICANE"            
[10] "COLD"                  "RAIN"                  "LIGHTNING"            
[13] "DENSE FOG"             "RIP CURRENT"           "CLOUD"                
[16] "HEAT"                  "LIGHTING"              "FUNNEL"               
[19] "WATER"                 "BLIZZARD"              "BLIZZARD WEATHER"     
[22] "TIDE"                  "RECORD"                "AVALANCHE"            
[25] "MARINE"                "SEA"                   "SEVERE TURBULENCE"    
[28] "DAM"                   "APACHE COUNTY"         "SLEET"                
[31] "DUST DEVIL"            "SURF"                  "HEAVY PRECIPATATION"  
[34] "BLOWING DUST"          "URBAN"                 "FIRE"                 
[37] "HIGH"                  "MUDSLIDES"             "DRY"                  
[40] "MICROBURST"            "DOWNBURST"             "GUSTNADO AND"         
[43] "WET"                   "GLAZE"                 "WINT"                 
[46] "DROUGHT"               "PRECIPITATION"         "WAYTERSPOUT"          
[49] "STREAM"                "MUD SLIDE"             "LIGNTNING"            
[52] "FROST"                 "MUD SLIDES"            "GUSTNADO"             
[55] "GROUND BLIZZARD"       "FOG"                   "COASTAL SURGE"        
[58] "HIGH WAVES"            "TORNDAO"               "AVALANCE"             
[61] "OTHER"                 "MUDSLIDE"              "ROAD"                 
[64] "HEAVY MIX"             "RIP CURRENTS"          "SOUTHEAST"            
[67] "SHOWER"                "BEACH EROSIN"          "TEMPERATURE"          
[70] "HYPOTHERMIA"           "MUD/ROCK SLIDE"        "EARLY FROST"          
[73] "FLASH FLOOODING"       "TSTMW"                 "FUNNELS"              
[76] "LAND"                  "EXCESSIVE"             "?"                    
[79] "HOT"                   "MILD PATTERN"          "SAHARAN DUST"         
[82] "HEAVY SWELLS"          "Other"                 "Dust Devil"           
[85] "Beach Erosion"         "Early Frost"           "Mudslide"             
[88] "Glaze"                 "MIXED PRECIP"          "Mudslides"            
[91] "SUMMARY"               "Microburst"            "No Severe Weather"    
[94] "Saharan Dust"          "VOLCANIC"              "NONE"                 
[97] "TSTM WND"              "Frost"                 "Hypothermia/Exposure" 
[100] "HYPOTHERMIA/EXPOSURE"  "TYPHOON"               "HIGH SWELLS"          
[103] "HIGH  SWELLS"          "BEACH EROSION"         "WARM"                 
[106] "COASTAL EROSION"       "SEICHE"                "TSTM"                 
[109] "HYPERTHERMIA/EXPOSURE" "ROCK SLIDE"            "PATCHY DENSE FOG"     
[112] "TROPICAL DEPRESSION"   "COOL SPELL"            "FIRST FROST"          
[115] "VOG"                   "REMNANTS OF FLOYD"     "DRIEST MONTH"         
[118] "RED FLAG CRITERIA"     "WND"                   "SMOKE"                
[121] "ROGUE WAVE"            "DUST DEVEL"            "NORTHERN LIGHTS"      
[124] "DROWNING"              "TSUNAMI"               "DENSE SMOKE"          
> d_5cols$EVTYPE[!(d_5cols$EVTYPE %in% cat)] <- "Other"
> unique(d_5cols$EVTYPE)
[1] "TORNADO"       "WIND"          "HAIL"          "FREEZ"         "SNOW"         
[6] "FLOOD"         "ICE"           "STORM"         "HURRICANE"     "COLD"         
[11] "RAIN"          "LIGHTNING"     "Other"         "CLOUD"         "HEAT"         
[16] "WATER"         "TIDE"          "RECORD"        "MARINE"        "SEA"          
[21] "DAM"           "SURF"          "URBAN"         "FIRE"          "DRY"          
[26] "WET"           "WINT"          "PRECIPITATION" "STREAM"        "ROAD"         
[31] "SHOWER"        "TEMPERATURE"   "LAND"          "HOT"           "SUMMARY"      
[36] "VOLCANIC"      "WARM"         
> 


######################################
Columns of interest 
######################################

> d_all<-read.csv("repdata_data_StormData.csv",as.is=T)
> dim(d_all)
[1] 902297     37
> names(d_all)
[1] "STATE__"    "BGN_DATE"   "BGN_TIME"   "TIME_ZONE"  "COUNTY"     "COUNTYNAME" "STATE"     
[8] "EVTYPE"     "BGN_RANGE"  "BGN_AZI"    "BGN_LOCATI" "END_DATE"   "END_TIME"   "COUNTY_END"
[15] "COUNTYENDN" "END_RANGE"  "END_AZI"    "END_LOCATI" "LENGTH"     "WIDTH"      "F"         
[22] "MAG"        "FATALITIES" "INJURIES"   "PROPDMG"    "PROPDMGEXP" "CROPDMG"    "CROPDMGEXP"
[29] "WFO"        "STATEOFFIC" "ZONENAMES"  "LATITUDE"   "LONGITUDE"  "LATITUDE_E" "LONGITUDE_"
[36] "REMARKS"    "REFNUM"


8,23,24,25,27
"EVTYPE","FATALITIES","INJURIES","PROPDMG","CROPDMG" 


8,23,24,25,26,27,28
"FATALITIES" "INJURIES"   "PROPDMG"    "PROPDMGEXP" "CROPDMG"    "CROPDMGEXP"

> head(d_5cols)
EVTYPE FATALITIES INJURIES PROPDMG CROPDMG
1 TORNADO          0       15    25.0       0
2 TORNADO          0        0     2.5       0
3 TORNADO          0        2    25.0       0
4 TORNADO          0        2     2.5       0
5 TORNADO          0        2     2.5       0
6 TORNADO          0        6     2.5       0




Injurys<-tapply(d_5cols$INJURIES,d_5cols$EVTYPE,sum)

> plot(Injurys,xaxt="n")
> axis(1,labels=names(Injurys))
Error in axis(1, labels = names(Injurys)) : 
  'labels' is supplied and not 'at'
> axis(1,at=pretty(c(0:length(Injurys))),labels=names(Injurys))
Error in axis(1, at = pretty(c(0:length(Injurys))), labels = names(Injurys)) : 
  'at' and 'labels' lengths differ, 5 != 37
> axis(1,at=1:37,labels=names(Injurys))



#######################################
WORKS Plotting the graph 
#######################################
> plot(Injurys,xaxt="n")
> axis(1,at=1:37,labels=names(Injurys),las=2)




##########################################################
Answering the economic question
##########################################################

"","-","?","+","0","1","2","3","4","5","6","7","8","B","h","H","K","m","M"

1,-1,1,+1,1,1,10^2,10^3,4,10^5,10^6,10^7,10^8,10^9,10^2,10^2,10^3,10^6,10^6

### pattern
> exp  
[1] ""  "-" "?" "+" "0" "1" "2" "3" "4" "5" "6" "7" "8" "B" "h" "H" "K" "m" "M"
## replacement
> expv
[1]  1e+00 -1e+00  1e+00  1e+00  1e+00  1e+00  1e+02  1e+03  4e+00  1e+05  1e+06  1e+07  1e+08
[14]  1e+09  1e+02  1e+02  1e+03  1e+06  1e+06
####
x is the list 

### need to alter this to find "" and replace with 1e+00, fin "-" and replace with -1e+00 
# for e.g. 
list <- d_7cols$PROPDMGEXP


FindAndReplace<-function (list,exp,expv){
  for (i in 1:length(exp)){
    ##print(i)
    ##print(exp[i])
    
    ##pattern<-paste(".*",i,".*",sep="")
    list<-gsub(exp[i],expv[i],list,ignore.case=T)
  }
  list  ## return the categorised list
}


gsub(pattern, replacement, x, ignore.case = FALSE, perl = FALSE,
     fixed = FALSE, useBytes = FALSE)

for (i in 1:length(exp)){
  print(i)
  print(exp[i])
  print(expv[i])
}



#####################
Might have to use this 
replace replaces the values in x with indices given in list by those given in values. 
If necessary, the values in values are recycled.

replace(x, list, values)


#########################
One way is this way, could make a loop

d_7cols$PROPDMGEXP[d_7cols$PROPDMGEXP==exp[1]] <- expv[1]
...
d_7cols$PROPDMGEXP[d_7cols$PROPDMGEXP==exp[19]] <- expv[19]

#list would be a hole column in the dataframe with value that need replacing
# pattern would be an aray pattern e.g "h"
# replacement would be array replacement e.g. 10^2
# pattern and replacement would be of the same length with pattern[1] being replaced by 
# replacement[1] ...and so on

FindAndReplace<-function (list,pattern,replacement){
  for (i in 1:length(pattern)){
    #print(i)
    print(paste("i:",i," Finding this: " ,pattern[i],", and replacing with this: ",replacement[i],".\n",sep=""))
      
    list[list==pattern[i]] <- replacement[i]
  }
  list  ## return the list  with replacements 
}

###############################################
#Use these variables 

> dput(df_p)
c("", "-", "?", "+", "0", "1", "2", "3", "4", "5", "6", "7", 
  "8", "B", "h", "H", "k", "K", "m", "M")
> dput(repl)
c(1, -1, 1, 1, 1, 1, 100, 1000, 10000, 1e+05, 1e+06, 1e+07, 1e+08, 
  1e+09, 100, 100, 1000, 1000, 1e+06, 1e+06)
>
  
  
################################################################
## Columns need to be numeric to multipy by each other 
  
  
  > class(c(1))
[1] "numeric"
> class(c("1"))
[1] "character"
> c("1")*c(1)
Error in c("1") * c(1) : non-numeric argument to binary operator
> q<-c("1")
> w<-c(1)
> q*w
Error in q * w : non-numeric argument to binary operator
> str(d_7cols)
'data.frame':  902297 obs. of  7 variables:
  $ EVTYPE    : chr  "TORNADO" "TORNADO" "TORNADO" "TORNADO" ...
$ FATALITIES: num  0 0 0 0 0 0 0 0 1 0 ...
$ INJURIES  : num  15 0 2 2 2 6 1 0 14 0 ...
$ PROPDMG   : num  25 2.5 25 2.5 2.5 2.5 2.5 2.5 25 25 ...
$ PROPDMGEXP: chr  "1000" "1000" "1000" "1000" ...
$ CROPDMG   : num  0 0 0 0 0 0 0 0 0 0 ...
$ CROPDMGEXP: chr  "1" "1" "1" "1" ...
> calss(q)
Error: could not find function "calss"
> class(q)
[1] "character"
> class(w)
[1] "numeric"
> q<-as.numeric(q)
> class(q)
[1] "numeric"
> class(w)
[1] "numeric"
> q
[1] 1
> w
[1] 1
> q*w
[1] 1

> head(d_7cols)
EVTYPE FATALITIES INJURIES PROPDMG PROPDMGEXP CROPDMG CROPDMGEXP
1 TORNADO          0       15    25.0       1000       0          1
2 TORNADO          0        0     2.5       1000       0          1
3 TORNADO          0        2    25.0       1000       0          1
4 TORNADO          0        2     2.5       1000       0          1
5 TORNADO          0        2     2.5       1000       0          1
6 TORNADO          0        6     2.5       1000       0          1
> d_7cols$PROPDMGEXP<-as.numeric(d_7cols$PROPDMGEXP)
> head(d_7cols)
EVTYPE FATALITIES INJURIES PROPDMG PROPDMGEXP CROPDMG CROPDMGEXP
1 TORNADO          0       15    25.0       1000       0          1
2 TORNADO          0        0     2.5       1000       0          1
3 TORNADO          0        2    25.0       1000       0          1
4 TORNADO          0        2     2.5       1000       0          1
5 TORNADO          0        2     2.5       1000       0          1
6 TORNADO          0        6     2.5       1000       0          1
> unique(d_7cols$PROPDMGEXP)
[1]  1e+03  1e+06  1e+00  1e+09  1e+05  1e+04  1e+02  1e+07 -1e+00  1e+08
> sort(unique(d_7cols$PROPDMGEXP))
[1] -1e+00  1e+00  1e+02  1e+03  1e+04  1e+05  1e+06  1e+07  1e+08  1e+09
> d_7cols$CROPDMGEXP<-as.numeric(d_7cols$CROPDMGEXP)
> str(d_7cols)
'data.frame':  902297 obs. of  7 variables:
  $ EVTYPE    : chr  "TORNADO" "TORNADO" "TORNADO" "TORNADO" ...
$ FATALITIES: num  0 0 0 0 0 0 0 0 1 0 ...
$ INJURIES  : num  15 0 2 2 2 6 1 0 14 0 ...
$ PROPDMG   : num  25 2.5 25 2.5 2.5 2.5 2.5 2.5 25 25 ...
$ PROPDMGEXP: num  1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 ...
$ CROPDMG   : num  0 0 0 0 0 0 0 0 0 0 ...
$ CROPDMGEXP: num  1 1 1 1 1 1 1 1 1 1 ...
>

  > d_7cols$PROP_COST<-d_7cols$PROPDMG * d_7cols$PROPDMGEXP
> head(d_7cols)
EVTYPE FATALITIES INJURIES PROPDMG PROPDMGEXP CROPDMG CROPDMGEXP PROP_COST
1 TORNADO          0       15    25.0       1000       0          1     25000
2 TORNADO          0        0     2.5       1000       0          1      2500
3 TORNADO          0        2    25.0       1000       0          1     25000
4 TORNADO          0        2     2.5       1000       0          1      2500
5 TORNADO          0        2     2.5       1000       0          1      2500
6 TORNADO          0        6     2.5       1000       0          1      2500
> d_7cols$CROP_COST<-d_7cols$CROPDMG * d_7cols$CROPDMGEXP
> head(d_7cols)
EVTYPE FATALITIES INJURIES PROPDMG PROPDMGEXP CROPDMG CROPDMGEXP PROP_COST CROP_COST
1 TORNADO          0       15    25.0       1000       0          1     25000         0
2 TORNADO          0        0     2.5       1000       0          1      2500         0
3 TORNADO          0        2    25.0       1000       0          1     25000         0
4 TORNADO          0        2     2.5       1000       0          1      2500         0
5 TORNADO          0        2     2.5       1000       0          1      2500         0
6 TORNADO          0        6     2.5       1000       0          1      2500         0
>

  
  
  ##################################
Working on the plot 

> par("mai")
[1] 1.360000 1.093333 1.093333 0.560000

> par(mai=c(2,1,1,1)) ## use this so the x-axis looks good 
> par("mai")

## add decreasing = T 
Fatalities<-sort(tapply(d$FATALITIES,d$EVTYPE,sum),decreasing=T)

axis(2, at=c(min(Fatalities),max(Fatalities)), col.axis="red", las=2)



