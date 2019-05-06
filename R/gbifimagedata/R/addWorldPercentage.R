
# add the world percentage

addWorldPercentage = function(D,Rank="SPECIES") {

  friendlyKey = D$friendlyKey %>% unique()

  worldCount = httr::GET("http://api.gbif.org/v1/species/search?rank=" %+% Rank %+% "&status=ACCEPTED&highertaxon_key=" %+% friendlyKey) %>%
    httr::content() %>%
    pluck("count")

  D = D %>%
    mutate(totalSpeciesInCountry = replace(totalSpeciesInCountry,country == "world", !!worldCount)) %>%
    mutate(percentCoverage = (numSpeciesWithImages/totalSpeciesInCountry)*100) %>%
    ungroup()

  return(D)
}
