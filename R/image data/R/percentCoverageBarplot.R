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
    select(class,basisofrecord,countrycode) %>%
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
  subtitle = "This graph shows global coverage is poor for most groups, so regional breakdowns are probably necessary"
  
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

imageData = imageData %>% filter(!is.na(species)) %>% # very important keep only those with species rank
  select(species,class,basisofrecord,countrycode,canOthersUse,canGoogleUse) %>%
  filter(!countrycode == "") %>% unique() # get rid of extra license facet

p1 = plotBarPlotPercentCoverage(imageData)

ggsave("C:/Users/ftw712/Desktop/image data/plots/percentageCoverageBarplot.png",plot=p1,width=10,height=10,units="in")
ggsave("C:/Users/ftw712/Desktop/image data/plots/percentageCoverageBarplot.pdf",plot=p1,width=10,height=10,device=cairo_pdf)


