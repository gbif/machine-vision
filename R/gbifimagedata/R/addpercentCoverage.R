addPercentCoverage = function(D,Step=1000,maxPages=2,globalOnly=FALSE) {

  # this part could probably be moved to another processing step.
    # D = D %>%
    # group_by(friendlyName,friendlyKey,basisOfRecord,country,license) %>%
    # summarise(numSpeciesWithImages = n()) %>%
    # filter(numSpeciesWithImages >= !!minNumSpeciesWithImages)

  if(!globalOnly) {

  uniqueCountries = D$country %>%
    na.omit() %>%
    unique() %>%
    magrittr::extract(.!="world") # remove world from uniqueCountries

  taxonkey = D$friendlyKey %>% unique()
  countryCode = countrycode::countrycode(uniqueCountries,"country.name", "iso2c", nomatch = NA)

  totalSpeciesInCountry = countryCode %>%
    map(~gbifapi::getFacetedSpeciesCountByCountry(taxonKey = taxonkey, country = .x,Step=Step,maxPages=maxPages)) %>%
    flatten_dbl()

  countryCountTable = tibble(taxonkey,uniqueCountries,countryCode,totalSpeciesInCountry) %>%
    select(country = uniqueCountries,totalSpeciesInCountry)

  D = merge(D,countryCountTable,id="country",all.x=TRUE) # merge with country table

  D = D %>%
    mutate(percentCoverage=(numSpeciesWithImages/totalSpeciesInCountry)*100)
  } else {
  D = D %>%
    mutate(totalSpeciesInCountry = NA) %>%
    mutate(percentCoverage = NA) %>%
    filter(country=="world")
  }

  return(D)
}
