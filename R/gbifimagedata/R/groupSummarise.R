
groupSummarise = function(D,minNumSpeciesWithImages=1) {

groupingVar= c("friendlyName","friendlyKey","basisOfRecord","country","license")

D = D %>%
  group_by_(.dots=groupingVar) %>%
  summarise(numSpeciesWithImages = n()) %>%
  filter(numSpeciesWithImages >= !!minNumSpeciesWithImages)

return(D)
}
