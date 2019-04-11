# make table of potential datasets 

# 1. Step One get species counts
if(FALSE) { # create speciesCountsClassCountry.rda
library(dplyr)
library(countrycode)
library(forcats)
library(purrr)
library(roperators)

load("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda")

#  number of species with 10 or more images 
D = imageData %>% 
  group_by(class,basisofrecord,countrycode) %>%
  count(class) %>%
  mutate(variable="total") %>%
  as.data.frame()

D = D %>% filter(!is.na(class)) %>%
  arrange(-n) %>%
  filter(n > 20) %>% 
  filter(!basisofrecord == "UNKNOWN") %>%
  filter(!basisofrecord == "FOSSIL_SPECIMEN") %>%
  filter(!basisofrecord == "MACHINE_OBSERVATION") %>%
  filter(!basisofrecord == "LIVING_SPECIMEN")

# add extra information and reorder dataframe
D = D %>% mutate(taxonKey = class %>% map_chr(~ rgbif::name_lookup(query=.x, rank="class", limit = 20)$data$nubKey[1])) %>% 
  mutate(basis_of_record = basisofrecord) %>%
  mutate(country = countrycode) 


addFacetedSpeciesCount = function(.data,L,Step=1000,maxPages=100,verbose=TRUE) {
  
  L = .data %>% select(attr(.data,"var")) %>% purrr::transpose() # get a list to pass to faceter
  
  f = function(...) { # anonymous function to be run with page while
    x = list(...) # get Step and Page variables passed in by pageWhile
    prefix = "http://api.gbif.org/v1/occurrence/search?limit=0&facet=speciesKey"
    gbifapi::gbifapi(prefix %+% gbifapi::faceter(x[[3]][[1]]) %+% "&" %+% gbifapi::pagerFacet(x$Step,x$Page))$facets[[1]]$counts
  }
  
  speciesCount = c()
  for(i in 1:length(L)) {
    print(L[[i]])
    CL = gbifapi::pageWhile(FUN=f,Step=Step,maxPages=maxPages,verbose=verbose,L[[i]])
    print(head(CL))
    # if(class(CL) == "try-error") { speciesCount[i] = NA; next
    # }
    speciesCount[i] = CL %>% purrr::map_chr(~ .x$name) %>% length()
  }
  
  d = cbind(as.data.frame(.data),data.frame(speciesCount))
  
  return(d)
}

D = D %>% filter(!country == "") %>% select(taxonKey,country) %>% unique() %>%
  na.omit() %>%
  group_by(taxonKey,country) %>% 
  addFacetedSpeciesCount(Step = 1000,maxPages=200)

speciesCountsClassCountry = D
save(speciesCountsClassCountry,file="C:/Users/ftw712/Desktop/image data/data/speciesCountsClassCountry.rda") 

}

if(FALSE) { # 2. Step Two clean and make table 
library(dplyr)
library(countrycode)
library(purrr)
library(roperators)

load("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda")

imageData = imageData %>% filter(!is.na(species)) %>% # very important keep only those with species rank 
select(species,class,basisofrecord,countrycode,canOthersUse,canGoogleUse) %>% 
filter(!countrycode == "") %>% unique() # get rid of extra license facet 

#  number of species with 10 or more images 
D1 = imageData %>% 
  select(class,basisofrecord,countrycode) %>%
  unique() %>% # filter out extra facets
  group_by(class,basisofrecord,countrycode) %>% 
  count(class) %>%
  mutate(variable="total") %>%
  as.data.frame()

D2 = imageData %>% 
  filter(as.logical(as.character(canOthersUse))) %>%
  group_by(class,basisofrecord,countrycode) %>% 
  count(class) %>%
  mutate(variable="non-commercial") %>%
  as.data.frame()

D3 = imageData %>% 
  filter(as.logical(as.character(canGoogleUse))) %>%
  group_by(class,basisofrecord,countrycode) %>% 
  count(class) %>%
  mutate(variable="open commercial") %>%
  as.data.frame()

imageData = rbind(D1,D2,D3) # merge all data together 
imageData = imageData %>% rename(license = variable,totalSpeciesWith10Images=n)

imageData = imageData %>% filter(!is.na(class)) %>%
  arrange(-totalSpeciesWith10Images) %>%
  filter(totalSpeciesWith10Images > 20) %>% 
  filter(!basisofrecord == "UNKNOWN") %>%
  filter(!basisofrecord == "FOSSIL_SPECIMEN") %>%
  filter(!basisofrecord == "MACHINE_OBSERVATION") %>%
  filter(!basisofrecord == "LIVING_SPECIMEN") %>%
  filter(!countrycode == "") 

# add extra information and reorder dataframe
D1 = imageData %>% mutate(taxonKey = class %>% map_chr(~ rgbif::name_lookup(query=.x, rank="class", limit = 20)$data$nubKey[1])) %>% 
  mutate(basis_of_record = basisofrecord) %>%
  mutate(country = countrycode) 

load("C:/Users/ftw712/Desktop/image data/data/speciesCountsClassCountry.rda")

D1 = tidyr::unite(D1, "id", c("taxonKey","country"),remove=FALSE)
D = tidyr::unite(D, "id", c("taxonKey","country"),remove=TRUE)

D = merge(D1,D,id="id")

D = D %>% mutate(percentCoverage = (totalSpeciesWith10Images/speciesCount)*100) %>%
  arrange(-percentCoverage) %>%
  rename(countryCode=country,totalSpeciesInCountry=speciesCount) %>%
  mutate(country = countrycode::countrycode(countryCode, "iso2c", "country.name")) %>%
  select(percentCoverage,basisofrecord,country,class,totalSpeciesInCountry,totalSpeciesWith10Images,license) 

str(D)

write.table(D,file="C:/Users/ftw712/Desktop/percentCoverageTable.csv",quote=FALSE,row.names=FALSE,sep=",")
save(D,file="C:/Users/ftw712/Desktop/image data/data/percentCoverageCountryClassTable.rda")

D = D %>% mutate(percentCoverage = round(percentCoverage,2))

library(DT)
caption = 'Table: This is a table of taxonomic class and percentage image-coverage by country.
The data was downloaded in Dec 2018.'

widget = datatable(D, filter = 'top', caption=caption, options = list(pageLength = 60))

htmlwidgets::saveWidget(widget,file="C:/Users/ftw712/Desktop/percentCoverageTable.html")

}


# process imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda imageData --> speciesCounts
# speciesCountsClassBasisOfRecordCountryCodeLicense.rda
if(FALSE) { 

library(dplyr)
library(purrr)
library(roperators)

load("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda")

imageData = imageData %>% filter(!is.na(species)) %>% # very important keep only those with species rank 
  select(species,class,basisofrecord,countrycode,canOthersUse,canGoogleUse) %>% 
  filter(!countrycode == "") %>% 
  unique()

nonCommercial = imageData %>% 
  filter(as.logical(as.character(canOthersUse))) %>%
  group_by(class,basisofrecord,countrycode) %>% 
  count(class) %>%
  mutate(license="non-commercial") %>%
  as.data.frame()

commercial = imageData %>% 
  filter(as.logical(as.character(canGoogleUse))) %>%
  group_by(class,basisofrecord,countrycode) %>% 
  count(class) %>%
  mutate(license="open commercial") %>%
  as.data.frame()

total = imageData %>% 
  group_by(class,basisofrecord,countrycode) %>% 
  count(class) %>%
  mutate(license="total") %>%
  as.data.frame()
  
imageData = rbind(total,commercial,nonCommercial) # combine 

# clean up 
imageData = imageData %>% 
  rename(totalSpeciesWith10Images=n) %>% 
  filter(!is.na(class)) %>%
  arrange(-totalSpeciesWith10Images) %>%
  filter(totalSpeciesWith10Images > 20) %>% 
  filter(!basisofrecord == "UNKNOWN") %>%
  filter(!basisofrecord == "FOSSIL_SPECIMEN") %>%
  filter(!basisofrecord == "MACHINE_OBSERVATION") %>%
  filter(!basisofrecord == "LIVING_SPECIMEN") %>%
  filter(!countrycode == "") 
  
speciesCounts = imageData

str(speciesCounts)

save(speciesCounts,file="C:/Users/ftw712/Desktop/image data/data/speciesCountsClassBasisOfRecordCountryCodeLicense.rda")
}


if(FALSE) { 
library(dplyr)
library(purrr)
library(roperators)

load("C:/Users/ftw712/Desktop/image data/data/speciesCountsClassBasisOfRecordCountryCodeLicense.rda")

# add extra information and reorder dataframe
speciesCounts = speciesCounts %>% mutate(taxonKey = class %>% map_chr(~ rgbif::name_lookup(query=.x, rank="class", limit = 20)$data$nubKey[1])) %>% 
  mutate(basis_of_record = basisofrecord) %>%
  mutate(country = countrycode) 

load("C:/Users/ftw712/Desktop/image data/data/speciesCountsClassCountry.rda") # occ counts from countries

speciesCounts = tidyr::unite(speciesCounts, "id", c("taxonKey","country"),remove=FALSE)
D = tidyr::unite(D, "id", c("taxonKey","country"),remove=TRUE)

D = merge(speciesCounts,D,id="id")

D = D %>% mutate(percentCoverage = (totalSpeciesWith10Images/speciesCount)*100) %>%
  arrange(-percentCoverage) %>%
  rename(countryCode=country,totalSpeciesInCountry=speciesCount) %>%
  mutate(country = countrycode::countrycode(countryCode, "iso2c", "country.name")) %>%
  select(percentCoverage,basisofrecord,country,class,totalSpeciesInCountry,totalSpeciesWith10Images,license) 

write.table(D,file="C:/Users/ftw712/Desktop/percentCoverageTable.csv",quote=FALSE,row.names=FALSE,sep=",")
save(D,file="C:/Users/ftw712/Desktop/image data/data/percentCoverageCountryClassTable.rda")

D = D %>% mutate(percentCoverage = round(percentCoverage,2))

library(DT)
caption = 'Table: This is a table of taxonomic class and percentage image-coverage by country.
The data was downloaded in Dec 2018.'

widget = datatable(D, filter = 'top', caption=caption, options = list(pageLength = 60))

htmlwidgets::saveWidget(widget,file="C:/Users/ftw712/Desktop/percentCoverageTable.html")

}
  
if(FALSE) { # email table processing 
library(dplyr)  
library(roperators)

D = data.table::fread("C:/Users/ftw712/Desktop/image data/data/percentCoverageTable.csv") %>%
as.data.frame()

D = D %>% 
filter(basisofrecord == "HUMAN_OBSERVATION") %>%
filter(license == "non-commercial")

D = head(D,25)

cat(round(D$percentCoverage,1) %+% " % of " %+% D$country %+% " " %+% D$class %+% 
" recorded as human observation have 10 or more images (non-commercial license)" %+% "\n" )
}




  
  
  
  
  
  