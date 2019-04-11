# species with images 

### 

if(FALSE) { # 1. Convert data from spark download into imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda
# imageDataBasisOfRecord = data.table::fread("C:/Users/ftw712/Desktop/image data/data/imageDataBasisOfRecord.csv") %>% as.data.frame()
library(dplyr)

# imageData = data.table::fread("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.csv") %>% as.data.frame()
load("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonInfo.rda")
taxonInfo = D
imageData = data.table::fread("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.csv") %>% as.data.frame()

if(TRUE) { # wade through GBIF license data and put into data.frame gbifLicenseData

gbifLicenseData = rbind(
c("",NA,NA,FALSE,FALSE),
c("http://creativecommons.org/licenses/by/4.0/", "CC BY 4.0", "CC BY", TRUE, TRUE),
c("http://creativecommons.org/licenses/by-nc/4.0/", "CC BY-NC 4.0", "CC BY-NC", FALSE, TRUE),
c("http://creativecommons.org/licenses/by-nc-sa/3.0/", "CC BY-NC-SA 3.0", "CC BY-NC-SA",FALSE, TRUE),
c("http://creativecommons.org/licenses/by-nc-nd/4.0/", "CC BY-NC-ND 4.0", "CC BY-NC-ND",FALSE, FALSE),
c("http://creativecommons.org/licenses/by-sa/4.0/", "CC BY-SA 4.0", "CC BY-SA",FALSE, TRUE),
c("http://creativecommons.org/publicdomain/zero/1.0/", "CC0 1.0", "CC0",TRUE, TRUE),
c("http://creativecommons.org/licenses/by-nc/3.0/", "CC BY-NC 3.0", "CC BY-NC",FALSE, TRUE),
c("[Copyright] Field Museum of Natural History - CC BY-NC","CC BY-NC", "CC BY-NC",FALSE,TRUE),
c("http://creativecommons.org/licenses/by-nc-sa/4.0/", "CC BY-NC-SA", "CC BY-NC-SA",FALSE, TRUE),
c("Partial images provided by this server are released under the Creative Commons cc-by-sa 3.0 (generic) licence [http://creativecommons.org/licenses/by-sa/3.0/de/]. Please credit images to BGBM following our citation guidelines [http://ww2.bgbm.org/Herbarium/cite.cfm]. If you would like to use images in a format or resolution which is not provided here, please contact us (d.roepert[at]bgbm.org).", "CC BY-SA 3.0", "CC BY-SA",FALSE,TRUE),
c("All Rights Reserved", NA, NA,FALSE, FALSE),
c("[Copyright] The Field Museum", NA, NA,FALSE, FALSE),
c("Attribution-ShareAlike (BY-SA) Creative Commons License and GNU Free Documentation License (GFDL)", "CC BY-SA", "CC BY-SA",FALSE,TRUE),
c("http://creativecommons.org/licenses/by-nc-nd/3.0/", "CC BY-NC-ND", "CC BY-NC-ND",FALSE, FALSE),
c("All rights reserved", NA, NA, FALSE, FALSE),
c("(c) Field Museum of Natural History - CC BY-NC", "CC BY-NC", "CC BY-NC", FALSE, TRUE),
c("Images of the Herbarium Hamburgense (HBG) specimens are released under the Creative Commons CC-BY-SA 4.0 License [https://creativecommons.org/licenses/by-sa/4.0/].", "CC BY-SA 4.0", "CC BY-SA", FALSE, TRUE),
c("http://creativecommons.org/licenses/by-sa/3.0/", "CC BY-SA 3.0", "CC BY-SA", FALSE, TRUE),
c("(c) The Field Museum", NA, NA, FALSE, FALSE),
c("all rights reserved", NA, NA, FALSE, FALSE),
c("http://creativecommons.org/licenses/by/3.0/", "CC BY 3.0", "CC BY", TRUE, TRUE),
c("http://creativecommons.org/licenses/by-nc-nd/2.5/", "CC BY-NC-ND 2.5", "CC BY-NC-ND", FALSE, FALSE),
c("The person who associated a work with this deed has dedicated the work to the public domain by waiving all of his or her rights to the work worldwide under copyright law, including all related and neighboring rights, to the extent allowed by law.  You can copy, modify, distribute and perform the work, even for commercial purposes, all without asking permission.", "CC0 1.0", "CC0", TRUE, TRUE),
c("http://creativecommons.org/licenses/by-nd/4.0/", "CC BY-ND 4.0", "CC BY-ND", FALSE, FALSE),
c("If you want to use any images ask author for permission", NA, NA,FALSE,FALSE),
c("https://creativecommons.org/licenses/by/4.0/deed.en", "CC BY 4.0","CC BY", TRUE,TRUE),
c("CC BY-NC-SA 3.0 DE", "CC BY-NC-SA 3.0", "CC BY-NC-SA", FALSE, TRUE),
c("http://creativecommons.org/publicdomain/mark/1.0/", "CC0 1.0", "CC0", TRUE, TRUE),
c("CC-BY-SA-NC 3.0 Australia", "CC BY-SA-NC 3.0", "CC BY-SA-NC", FALSE, TRUE),
c("http://en.wikipedia.org/wiki/Copyright", NA, NA, FALSE, FALSE),
c("All photographs and content. Copyright 2003-2011 Gary Cobb and David Mullin", NA, NA, FALSE, FALSE),
c("Creative Commons Attribution Non-Commercial Australia 3.0", "CC NC 3.0", "CC NC", FALSE, TRUE),
c("Images provided are released under the Creative Commons CC BY-SA 4.0 licence [http://creativecommons.org/licenses/by-sa/4.0/]. Please credit images to BRM following our citation guideline: Bartsch, I. (ed.) 2006+: AWI-Herbarium Marine Macroalgae. Image Id. - Published at Alfred-Wegener-Institut, Helmholtz-Zentrum fuer Polar- und Meeresforschung.", "CC BY-SA 4.0", "CC BY-SA", FALSE, TRUE),
c("Permission to use media on MorphoSource granted by copyright holder", "CC0 1.0", "CC0",TRUE, TRUE),
c("Photo: MLSSA (Anne Wilson - Heterodontus portusjacksoni), mlssa.asn.au", NA, NA, FALSE, FALSE),
c("A&M. Kapitany, australiansucculents.com.au", NA, NA, FALSE, FALSE),
c("Australian Museum", NA, NA, FALSE, FALSE),
c("Photo: Bruce Thomson, http://www.auswildlife.com", NA, NA, FALSE, FALSE),
c("CreativeCommons", NA, NA, FALSE, FALSE),
c("? MESA", NA, NA, FALSE, FALSE),
c("https://creativecommons.org/licenses/by-nc/3.0/au/", "CC BY-NC 3.0", "CC BY-NC", FALSE, TRUE),
c("Copyright Richard Hartland", NA, NA, FALSE, FALSE),
c("Copyright permission not set", NA, NA, TRUE, TRUE),
c("http://...", NA, NA, FALSE, FALSE)
) %>% as.data.frame()


colnames(gbifLicenseData) = c("verbatimLicense", "licenseVer", "license","canGoogleUse", "canOthersUse")
}

taxonInfo = taxonInfo %>% select(taxonkey,kingdom,class,phylum,order,family,genus,species,scientificName)

str(imageData)

imageData = imageData %>% mutate(verbatimLicense = license) %>% select(-license) %>% 
merge(gbifLicenseData,id="verbatimLicense",all.x=TRUE) %>% 
merge(taxonInfo,id="taxonkey") %>% unique()

save(imageData, file= "C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda")

}

if(FALSE) { # 2. Breakdown by taxon grouping basis of record and license  

library(dplyr)
library(forcats)
library(tidyr)
library(hrbrthemes)
library(extrafont)
loadfonts(quiet = TRUE)

plotBarPlotTaxonmy = function(imageData,group_var,Title,subtitle) {
group_var = enquo(group_var)

D1 = imageData %>% filter(as.logical(as.character(canGoogleUse))) %>% 
group_by(!!group_var,basisofrecord) %>%
summarise(imageCount = sum(count)) %>% 
mutate(variable="commercial use")

D2 = imageData %>% group_by(!!group_var,basisofrecord) %>%
summarise(imageCount = sum(count)) %>% 
mutate(variable="total")

D3 = imageData %>% filter(as.logical(as.character(canOthersUse))) %>% 
group_by(!!group_var,basisofrecord) %>%
summarise(imageCount = sum(count)) %>% 
mutate(variable="non-commercial use")

D = rbind(D1,D2,D3) %>% as.data.frame()
D = D %>% filter(imageCount > 5e4) %>% 
filter(!is.na(!!group_var)) %>%
filter(!basisofrecord == "UNKNOWN") %>%
filter(!basisofrecord == "FOSSIL_SPECIMEN") %>%
filter(!basisofrecord == "MACHINE_OBSERVATION")

D = D %>% mutate(!!group_var := fct_reorder(!!group_var, imageCount))
D$variable = factor(D$variable,levels=c("total","non-commercial use","commercial use"))

library(ggplot2)
library(scales)

p1 = ggplot(D, aes(!!group_var,imageCount,fill=basisofrecord)) + 
labs(title=Title,subtitle=subtitle) + 
geom_bar(stat = "identity", position = position_dodge(preserve = 'single')) + 
coord_flip() + 
scale_y_continuous(labels = scales::unit_format(unit = "k", scale = 1e-3),breaks=scales::pretty_breaks(5)) + 
theme_ipsum(grid="X") +
theme(legend.position="bottom") + 
ylab("number of images") + 
facet_wrap(~variable)

return(p1)
}


library(roperators)

load("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda")

str(imageData)

# kingdom
Title = "Images available based on kingdom and basis of record"
subtitle = "Plants are at the top but most are prepared museum specimens"

p1 = plotBarPlotTaxonmy(imageData,kingdom,Title,subtitle)
ggsave("C:/Users/ftw712/Desktop/image data/plots/kingdomBORBarplot.png",plot=p1,width=10,height=10,units="in")
ggsave("C:/Users/ftw712/Desktop/image data/plots/kingdomBORBarplot.pdf",plot=p1,width=10,height=10,device=cairo_pdf)

# class 
Title = "Images available based on class and basis of record"
subtitle = "Flowering plants, Insects, but interstingly not birds (no eBird images)"

p1 = plotBarPlotTaxonmy(imageData,class,Title,subtitle)
ggsave("C:/Users/ftw712/Desktop/image data/plots/classBORBarplot.png",plot=p1,width=10,height=10,units="in")
ggsave("C:/Users/ftw712/Desktop/image data/plots/classBORBarplot.pdf",plot=p1,width=10,height=10,device=cairo_pdf)

# phylum
Title = "Images available based on phylum and basis of record"
subtitle = "similar story to the class breakdown"

p1 = plotBarPlotTaxonmy(imageData,phylum,Title,subtitle)
ggsave("C:/Users/ftw712/Desktop/image data/plots/phylumBORBarplot.png",plot=p1,width=10,height=10,units="in")
ggsave("C:/Users/ftw712/Desktop/image data/plots/phylumBORBarplot.pdf",plot=p1,width=10,height=10,device=cairo_pdf)

}

if(FALSE) { # 3.  What are the major groups with species with >10 images? 

library(dplyr)
library(countrycode)
library(hrbrthemes)
library(extrafont)
library(forcats)
library(purrr)
loadfonts(quiet = TRUE)


plotBarPlotSpeciesCount = function(imageData) {
str(imageData)

#  number of species with 10 or more images 
D1 = imageData %>% 
group_by(class,basisofrecord) %>% 
count(class) %>%
mutate(variable="total") %>%
as.data.frame()

D2 = imageData %>% 
filter(as.logical(as.character(canOthersUse))) %>%
group_by(class,basisofrecord) %>% 
count(class) %>%
mutate(variable="non-commercial use") %>%
as.data.frame()

D3 = imageData %>% 
filter(as.logical(as.character(canGoogleUse))) %>%
group_by(class,basisofrecord) %>% 
count(class) %>%
mutate(variable="commercial use") %>%
as.data.frame()

D = rbind(D1,D2,D3)

D = D %>% filter(!is.na(class)) %>%
arrange(-n) %>%
filter(n > 1000) %>% 
filter(!basisofrecord == "UNKNOWN") %>%
filter(!basisofrecord == "FOSSIL_SPECIMEN") %>%
filter(!basisofrecord == "MACHINE_OBSERVATION") %>%
filter(!basisofrecord == "LIVING_SPECIMEN")

D = D %>% mutate(class = fct_reorder(class,n))
D$variable = factor(D$variable,levels=c("total","non-commercial use","commercial use"))

library(ggplot2)
library(scales)

Title = "Number of species with >10 images available based on class and basis of record"
subtitle = "There are many groups with 1000s of species with >10 images, but which groups have the best coverage?"

p1 = ggplot(D, aes(class,n,fill=basisofrecord)) + 
geom_bar(stat = "identity", position = position_dodge(preserve = 'single')) + 
scale_y_continuous(labels = scales::unit_format(unit = "k", scale = 1e-3),breaks=scales::pretty_breaks(5)) + 
coord_flip() +
theme_ipsum(grid="X") +
theme(legend.position="bottom") +
labs(title=Title,subtitle=subtitle) + 
ylab("number of species") + 
facet_wrap(~variable)

return(p1)
} 

load("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda")

p1 = plotBarPlotSpeciesCount(imageData)


ggsave("C:/Users/ftw712/Desktop/image data/plots/classSpeBarplot.png",plot=p1,width=10,height=10,units="in")
ggsave("C:/Users/ftw712/Desktop/image data/plots/classSpeBarplot.pdf",plot=p1,width=10,height=10,device=cairo_pdf)

}

if(FALSE) { # 4.  percent coverage by class 
library(dplyr)
library(countrycode)
library(hrbrthemes)
library(extrafont)
library(forcats)
library(purrr)
loadfonts(quiet = TRUE)

plotBarPlotPercentCoverage = function(imageData) { # only works right now for class

str(imageData)

#  number of species with 10 or more images 
D1 = imageData %>% 
group_by(class,basisofrecord) %>% 
count(class) %>%
mutate(variable="total") %>%
as.data.frame()

D2 = imageData %>% 
filter(as.logical(as.character(canOthersUse))) %>%
group_by(class,basisofrecord) %>% 
count(class) %>%
mutate(variable="non-commercial use") %>%
as.data.frame()

D3 = imageData %>% 
filter(as.logical(as.character(canGoogleUse))) %>%
group_by(class,basisofrecord) %>% 
count(class) %>%
mutate(variable="commercial use") %>%
as.data.frame()

D = rbind(D1,D2,D3)

D = D %>% filter(!is.na(class)) %>%
arrange(-n) %>%
filter(n > 1000) %>% 
filter(!basisofrecord == "UNKNOWN") %>%
filter(!basisofrecord == "FOSSIL_SPECIMEN") %>%
filter(!basisofrecord == "MACHINE_OBSERVATION") %>%
filter(!basisofrecord == "LIVING_SPECIMEN")

# add extra information and reorder dataframe
D = D %>% mutate(classkey = class %>% map_chr(~ rgbif::name_lookup(query=.x, rank="class", limit = 20)$data$nubKey[1])) %>% 
gbifapi::addTaxonSpeciesCount(classkey) %>%
mutate(percentCoverage = (n/speciesCount)) 

D = D %>% mutate(class = fct_reorder(class,percentCoverage))
D$variable = factor(D$variable,levels=c("total","non-commercial use","commercial use"))

library(ggplot2)
library(scales)

Title = "Percent coverage of species with >10 images"
subtitle = "This graph shows global coverage is poor for most groups, so regional breakdowns probably necessary"

p1 = ggplot(D, aes(class,percentCoverage,fill=basisofrecord)) + 
geom_bar(stat = "identity", position = position_dodge(preserve = 'single')) + 
scale_y_continuous(labels = scales::percent,breaks=scales::pretty_breaks(5)) + 
coord_flip() +
theme_ipsum(grid="X") +
theme(legend.position="bottom") +
labs(title=Title,subtitle=subtitle) + 
ylab("percentage of species in group with >10 images (num. sp. >10 img/total num. sp. in class)") + 
facet_wrap(~variable)

return(p1)
}

# Groups with >10 or more species percentage coverage
load("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda")

p1 = plotBarPlotPercentCoverage(imageData)

ggsave("C:/Users/ftw712/Desktop/image data/plots/percentageCoverageBarplot.png",plot=p1,width=10,height=10,units="in")
ggsave("C:/Users/ftw712/Desktop/image data/plots/percentageCoverageBarplot.pdf",plot=p1,width=10,height=10,device=cairo_pdf)

}

if(FALSE) { # 5. Percent coverage of top classes with species with more 

library(dplyr)
library(countrycode)
library(hrbrthemes)
library(extrafont)
library(forcats)
library(purrr)
library(roperators)
loadfonts(quiet = TRUE)

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

if(FALSE) { # 5. Percent coverage of top class continued 

library(dplyr)
library(countrycode)
library(purrr)
library(roperators)

load("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda")

#  number of species with 10 or more images 
D1 = imageData %>% 
group_by(class,basisofrecord,countrycode) %>% 
count(class) %>%
mutate(variable="total") %>%
as.data.frame()

D2 = imageData %>% 
filter(as.logical(as.character(canOthersUse))) %>%
group_by(class,basisofrecord,countrycode) %>% 
count(class) %>%
mutate(variable="non-commercial use") %>%
as.data.frame()

D3 = imageData %>% 
filter(as.logical(as.character(canGoogleUse))) %>%
group_by(class,basisofrecord,countrycode) %>% 
count(class) %>%
mutate(variable="commercial use") %>%
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
}

if(FALSE) { # nice groups work 
library(purrr)
library(dplyr)

# nice plants and animals 
load("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda")
imageData = imageData %>% filter(!is.na(species)) # very important keep only those with species rank 

# common group name  Sci Groups
niceGroups = rbind(
c("mushroom-like fungi", "Basidiomycota"),
c("mushroom-like fungi", "Agaricomycetes"),
c("mushroom-like fungi", "Sordariomycetes"),
c("birds", "Aves"),
c("butterflies", "Lepidoptera"),
c("spiders", "Arachnida"),
c("reptiles", "Reptilia"),
c("frogs", "Amphibia"),
c("dragonflies", "Odonata"),
c("flowers", "Magnoliophyta"),
c("mosses", "Lycopodiopsida"),
c("conifers", "Pinopsida"),
c("mammals", "Mammalia"),
c("sharks", "Elasmobranchii"),
c("snails", "Gastropoda"),
c("clam-like molluscs", "Bivalvia")
) %>% as.data.frame() %>% setNames(c("commonName","sciName"))

niceGroups = niceGroups %>% 
mutate(taxonkey = sciName %>% map_chr(~ rgbif::name_lookup(query=.x, limit = 20)$data$nubKey[1])) 
} 



if(FALSE) { # Part I of Tims question getting the number of species per country based on country 
# Tim question about ants...
# https://www.gbif.org/occurrence/gallery?taxon_key=4342
# Do you have any tools that could summarise if we would have many species of suitably licensed images of Ants in it for an "Ant overlay"?

library(dplyr)
library(countrycode)
library(forcats)
library(purrr)
library(roperators)

load("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda")

#  number of species with 10 or more images 
D = imageData %>% 
group_by(family,basisofrecord,countrycode) %>%
count(family) %>%
mutate(variable="total") %>%
filter(family == "Formicidae") %>% #only get ants 
as.data.frame()

D = D %>% filter(!is.na(family)) %>%
arrange(-n) %>%
filter(!basisofrecord == "UNKNOWN") %>%
filter(!basisofrecord == "FOSSIL_SPECIMEN") %>%
filter(!basisofrecord == "MACHINE_OBSERVATION") %>%
filter(!basisofrecord == "LIVING_SPECIMEN")
# filter(n > 20) %>% 

# add extra information and reorder dataframe
D = D %>% mutate(taxonKey = family %>% map_chr(~ rgbif::name_lookup(query=.x, rank="family", limit = 20)$data$nubKey[1])) %>% 
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

speciesCountsFormicidaeCountry = D
# save(speciesCountsFormicidaeCountry,file="C:/Users/ftw712/Desktop/image data/data/speciesCountsFormicidaeCountry.rda") 

}


# if(FALSE) { # Part II of Tims question. # group by family instead of class and get only ants 
library(dplyr)
library(countrycode)
library(purrr)
library(roperators)

load("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda")

imageData = imageData %>% filter(!is.na(species)) %>% # very important keep only those with species rank 
select(species,family,basisofrecord,countrycode,canOthersUse,canGoogleUse) %>% 
filter(family == "Formicidae") %>% # get only ants as per Tims request
filter(!countrycode == "") %>% unique() # get rid of extra license facet 

#  number of species with 10 or more images 
D1 = imageData %>% 
  select(family,basisofrecord,countrycode) %>%
  group_by(family,basisofrecord,countrycode) %>% 
  count(family) %>%
  mutate(variable="total") %>%
  as.data.frame()
  # unique() %>% # filter out extra facets
  
D2 = imageData %>% 
  filter(as.logical(as.character(canOthersUse))) %>%
  group_by(family,basisofrecord,countrycode) %>% 
  count(family) %>%
  mutate(variable="non-commercial") %>%
  as.data.frame()
  
D3 = imageData %>% 
  filter(as.logical(as.character(canGoogleUse))) %>%
  group_by(family,basisofrecord,countrycode) %>% 
  count(family) %>%
  mutate(variable="open commercial") %>%
  as.data.frame()

imageData = rbind(D1,D2,D3) # merge all data together 
imageData = imageData %>% rename(license = variable,totalSpeciesWith10Images=n)

imageData = imageData %>% filter(!is.na(family)) %>%
  arrange(-totalSpeciesWith10Images) %>%
  filter(!basisofrecord == "UNKNOWN") %>%
  filter(!basisofrecord == "FOSSIL_SPECIMEN") %>%
  filter(!basisofrecord == "MACHINE_OBSERVATION") %>%
  filter(!basisofrecord == "LIVING_SPECIMEN") %>%
  filter(totalSpeciesWith10Images > 5) %>% 
  filter(!countrycode == "") 

# imageData
  
# add extra information and reorder dataframe
D1 = imageData %>% mutate(taxonKey = family %>% map_chr(~ rgbif::name_lookup(query=.x, rank="family", limit = 20)$data$nubKey[1])) %>% 
  mutate(basis_of_record = basisofrecord) %>%
  mutate(country = countrycode) 

load("C:/Users/ftw712/Desktop/image data/data/speciesCountsFormicidaeCountry.rda")
D = speciesCountsFormicidaeCountry

D1 = tidyr::unite(D1, "id", c("taxonKey","country"),remove=FALSE)
D = tidyr::unite(D, "id", c("taxonKey","country"),remove=TRUE)

D = merge(D1,D,id="id")

D = D %>% mutate(percentCoverage = (totalSpeciesWith10Images/speciesCount)*100) %>%
  arrange(-percentCoverage) %>%
  rename(countryCode=country,totalSpeciesInCountry=speciesCount) %>%
  mutate(country = countrycode::countrycode(countryCode, "iso2c", "country.name")) %>%
  select(percentCoverage,basisofrecord,country,family,totalSpeciesInCountry,totalSpeciesWith10Images,license) 

D %>% filter(license == "total")
# }

if(FALSE) { # Get global ant stats for Tim 

library(dplyr)
library(countrycode)
library(purrr)
library(roperators)

load("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda")

imageData = imageData %>% filter(!is.na(species)) %>% # very important keep only those with species rank 
select(species,family,basisofrecord,countrycode,canOthersUse,canGoogleUse) %>% 
filter(family == "Formicidae") %>% # get only ants as per Tims request
filter(!countrycode == "") %>% unique() # get rid of extra license facet 



#  number of species with 10 or more images 
D1 = imageData %>%
  filter(as.logical(as.character(canGoogleUse))) %>%   
  select(family,basisofrecord) %>%
  group_by(family,basisofrecord) %>% 
  count(family) %>%
  mutate(variable="total") %>%
  as.data.frame()
  # unique() %>% # filter out extra facets

D1

}

  # filter(as.logical(as.character(canOthersUse))) %>%

There are alot of ant species with more than 10 images, but many of them are preserved specimens. 

non-commercial license on images
family      basisofrecord	numSpecies>10Images 
Formicidae    FOSSIL_SPECIMEN   29    
Formicidae  HUMAN_OBSERVATION  256    
Formicidae PRESERVED_SPECIMEN 4573    
Formicidae            UNKNOWN   23    

There are not so many images available for commercial license. 

commercial license on images
family      basisofrecord  numSpecies>10Images
Formicidae    FOSSIL_SPECIMEN  3    
Formicidae  HUMAN_OBSERVATION 41    
Formicidae PRESERVED_SPECIMEN  5    

Regionally, 

72% United States ants have 10 or more images (PRESERVED_SPECIMEN)
68% Madagascar ants have 10 or more images (PRESERVED_SPECIMEN)




# 72.0000000 PRESERVED_SPECIMEN                    United States

# D$basisofrecord
  
# D %>% 
# filter(basisofrecord == "HUMAN_OBSERVATION") %>% 
# select(percentCoverage,country,totalSpeciesInCountry,totalSpeciesWith10Images)

