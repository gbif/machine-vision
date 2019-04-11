
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
    scale_y_continuous(labels = scales::unit_format(unit = "M", scale = 1e-6),breaks=scales::pretty_breaks(5)) + 
    theme_ipsum(grid="X") +
    theme(legend.position="bottom") + 
    ylab("number of images") + 
    facet_wrap(~variable)
  
  return(p1)
}  

load("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonKeyBasisOfRecordCountryCodeLicense.rda")

str(imageData)

# kingdom
Title = "Images counts based on kingdom, basis of record, and license"
subtitle = "Total image counts for each kingdom"

p1 = plotBarPlotTaxonmy(imageData,kingdom,Title,subtitle)
ggsave("C:/Users/ftw712/Desktop/image data/plots/kingdomBORBarplot.png",plot=p1,width=10,height=10,units="in")
ggsave("C:/Users/ftw712/Desktop/image data/plots/kingdomBORBarplot.pdf",plot=p1,width=10,height=10,device=cairo_pdf)

# class 
Title = "Images counts based on class, basis of record, and license"
subtitle = "Total image counts for each class"

p1 = plotBarPlotTaxonmy(imageData,class,Title,subtitle)
ggsave("C:/Users/ftw712/Desktop/image data/plots/classBORBarplot.png",plot=p1,width=10,height=10,units="in")
ggsave("C:/Users/ftw712/Desktop/image data/plots/classBORBarplot.pdf",plot=p1,width=10,height=10,device=cairo_pdf)

# phylum
Title = "Images available based on phylum and basis of record"
subtitle = "similar story to the class breakdown"

p1 = plotBarPlotTaxonmy(imageData,phylum,Title,subtitle)
ggsave("C:/Users/ftw712/Desktop/image data/plots/phylumBORBarplot.png",plot=p1,width=10,height=10,units="in")
ggsave("C:/Users/ftw712/Desktop/image data/plots/phylumBORBarplot.pdf",plot=p1,width=10,height=10,device=cairo_pdf)



  