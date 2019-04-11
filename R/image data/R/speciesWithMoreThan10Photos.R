

library(highcharter)
library(dplyr)
library(forcats)

load("C:/Users/ftw712/Desktop/image data/data/imageDataTaxonInfo.rda")
str(D)


D = D %>% filter(kingdom == "Fungi") %>% 
  mutate(species = as.factor(species)) %>%
  mutate(species = fct_reorder(species, count)) %>% 
  arrange(-count) %>%
  filter(count > 10)


  # group_by(canGoogleUse) %>%
  # summarise(sum(count))


# PD$plotCat = factor(PD$plotCat, level =c("flowers","mosses and ferns","tree","algea","other"))
# color = c("#dddddd","#777777","#509E2F","#D66F27","#C2938D")
# # algea flowers mosses and ferns other tree
hc = highchart() %>%
  hc_add_series(D, "bar",hcaes(x=species,y=log10(count),group = canGoogleUse))
                               
                               # , group = plotCat))

                
                  # hcaes(x=species,y=counts, group = plotCat),
  # color = color)

hc 
  # showInLegend=c(TRUE,TRUE,TRUE,TRUE,TRUE),
  # visible = c(TRUE,TRUE,TRUE,TRUE,TRUE))
# %>%
# hc_yAxis(title = list(text = "number of occurrence records")) %>%
# hc_xAxis(title = list(text = "index of species"))

