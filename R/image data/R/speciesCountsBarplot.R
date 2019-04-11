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
  
  D = D %>% mutate(class = fct_reorder(class,n))
  D$variable = factor(D$variable,levels=c("total","non-commercial use","commercial use"))
  
  library(ggplot2)
  library(scales)
  
  Title = "Number of species with >10 images available based on class and basis of record"
  subtitle = ""
  
  p1 = ggplot(D, aes(class,n,fill=basisofrecord)) + 
    geom_bar(stat = "identity", position = position_dodge(preserve = 'single')) + 
    scale_y_continuous(labels = scales::unit_format(unit = "k", scale = 1e-3),breaks=scales::pretty_breaks(6)) + 
    coord_flip() +
    theme_ipsum(grid="X") +
    theme(legend.position="bottom") +
    labs(title=Title,subtitle=subtitle) + 
    ylab("number of species") + 
    facet_wrap(~variable)
  
  return(p1)
} 

load("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda")

# important image cleaning for image counts. 
imageData = imageData %>% filter(!is.na(species)) %>% # very important keep only those with species rank 
  select(species,class,basisofrecord,countrycode,canOthersUse,canGoogleUse) %>% 
  filter(!countrycode == "") %>% unique() # get rid of extra license facet 

p1 = plotBarPlotSpeciesCount(imageData)


ggsave("C:/Users/ftw712/Desktop/image data/plots/classSpeBarplot.png",plot=p1,width=10,height=10,units="in")
ggsave("C:/Users/ftw712/Desktop/image data/plots/classSpeBarplot.pdf",plot=p1,width=10,height=10,device=cairo_pdf)

