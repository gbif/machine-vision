# Table of percent coverage

library(DT)
library(dplyr)

load("C:/Users/ftw712/Desktop/image data/data/percentCoverageCountryClassTable.rda")

D = D %>% mutate(percentCoverage = round(percentCoverage,2))

widget = datatable(D, options = list(pageLength = 60))

htmlwidgets::saveWidget(widget,file="C:/Users/ftw712/Desktop/percentCoverageTable.html")
