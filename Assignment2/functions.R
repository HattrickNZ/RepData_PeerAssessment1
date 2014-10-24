

## categorise<-function that
## accepts a *list* of strings that need sorting into *categories* 
## In this example list will be the column EVTYPE in question
## Is this example categories wll be define below
categorise<-function (list,categories){
  for (i in categories){
    pattern<-paste(".*",i,".*",sep="")
    print(paste("Finding this pattern: " ,pattern,", and replacing it with this: ",i,".",sep=""))
    list<-gsub(pattern,i,list,ignore.case=T)
  }
  list  ## return the categorised list
}

############################
##EXAMPLE OF IT BEING RUN
#> list
#[1] "TORNADO"                   "TSTM WIND"                 "HAIL"                     
#[4] "FREEZING RAIN"             "SNOW"                      "ICE STORM/FLASH FLOOD"    
#[7] "SNOW/ICE"                  "WINTER STORM"              "HURRICANE OPAL/HIGH WINDS"
#[10] "THUNDERSTORM WINDS"       
#> cat
#[1] "WIND"  "SNOW"  "FLOOD" "STORM" "RAIN"  "HAIL" 
#> categorise(list,cat)
#[1] "TORNADO" "WIND"    "HAIL"    "RAIN"    "SNOW"    "FLOOD"   "SNOW"    "STORM"   "WIND"   
#[10] "WIND"
############################



#list would be a hole column in the dataframe with value that need replacing
# pattern would be an aray pattern e.g "h"
# replacement would be array replacement e.g. 10^2
# pattern and replacement would be of the same length with pattern[1] being replaced by 
# replacement[1] ...and so on

FindAndReplace<-function (list,pattern,replacement){
  for (i in 1:length(pattern)){
    #print(i)
    print(paste("i:",i," Finding this: " ,pattern[i],", and replacing with this: ",replacement[i],".",sep=""))
    
    list[list==pattern[i]] <- replacement[i]
  }
  list  ## return the list  with replacements 
}


## Function doAll 
## do the whole operation to get it to the format that I want 
## this was very quickly put together from the .RMD file 
## this will give me the tidy dataset that I want 

doAll<-function(){
  
  ##Declare url and filenames
  URL<-"https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
  bz2.filename<-"repdata_data_StormData.csv.bz2"
  csv.filename<-"repdata_data_StormData.csv"
  
  # read in the csv file, just the 7 columns for efficiency
  d<-read.csv(csv.filename,as.is=T)[,c(8,23,24,25,26,27,28)] 
  
  cat<-c("WIND","SNOW","FLOOD","STORM","RAIN","HAIL","SUMMARY","ICE","COLD","HOT","HURRICANE","TORNADO","SURF","DRY","WARM","LIGHTNING","DAM","PRECIPITATION","TEMPERATURE","LAND","FREEZ","FIRE","VOLCANIC","WATER","WINT","CLOUD","SHOWER","HEAT","TIDE","URBAN","STREAM","RECORD","SEA","MARINE","ROAD","WET")
  
  d$EVTYPE<-categorise(d$EVTYPE,cat) ## the output below explains what the function is doing 
  
  d$EVTYPE[!(d$EVTYPE %in% cat)] <- "Other"
  
  pattern1<-unique(d$PROPDMGEXP)
  pattern2<-unique(d$CROPDMGEXP)
  pattern<-unique(append(pattern1,pattern2))
  pattern # these are the unique values that I will want to replace with the values in replacement below
  
  replacement<-c(1, -1, 1, 1, 1, 1, 100, 1000, 10000, 1e+05, 1e+06, 1e+07, 1e+08, 
                 1e+09, 100, 100, 1000, 1000, 1e+06, 1e+06)
  
  d$PROPDMGEXP<-FindAndReplace(d$PROPDMGEXP,pattern,replacement) # output below expains what this function is doing 
  d$CROPDMGEXP<-FindAndReplace(d$CROPDMGEXP,pattern,replacement)  # output below expains what this function is doing
  
  d$PROPDMGEXP<-as.numeric(d$PROPDMGEXP) # convert column to numeric 
  d$CROPDMGEXP<-as.numeric(d$CROPDMGEXP)
  
  
  d$PROP_COST<-d$PROPDMG * d$PROPDMGEXP  # creat new columns
  d$CROP_COST<-d$CROPDMG * d$CROPDMGEXP
  d$PROP_CROP_COST<-d$PROP_COST+d$CROP_COST
  
  d # check to see if the values look right 
  
}
  
  