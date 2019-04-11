summariseTable = function(D,minNumImages=1) {

  # D = D %>% filter(numImages >= !!minNumImages) # get the minimum number of images

  # group by license first
  D_total = D %>%
    group_by(taxonKey,friendlyName,friendlyKey,basisOfRecord,country) %>%
    summarise(imageCount=n()) %>%
    mutate(license = "total") %>%
    mutate(country = as.character(country))

  # license divisions
  D_commercial = D %>%
    filter(commercialUseAllowed) %>% # filter to only get commercial use allowed
    group_by(taxonKey,friendlyName,friendlyKey,basisOfRecord,country) %>%
    summarise(imageCount=n()) %>%
    mutate(license = "commercial use allowed") %>%
    mutate(country = as.character(country))

  D_noncommercial = D %>%
    filter(canOthersUse) %>% # filter both
    filter(!commercialUseAllowed) %>%
    group_by(taxonKey,friendlyName,friendlyKey,basisOfRecord,country) %>%
    summarise(imageCount=n()) %>%
    mutate(license = "only non-commercial use allowed") %>%
    mutate(country = as.character(country))

  # global stats for friendly taxon
  D_global_total = D %>% # filter to only get commercial use allowed
    group_by(taxonKey,friendlyName,friendlyKey,basisOfRecord) %>%
    summarise(imageCount=n()) %>%
    mutate(license = "total") %>%
    mutate(country = "world") %>%
    mutate(country = as.character(country))

  D_global_commercial = D %>% # filter to only get commercial use allowed
    filter(commercialUseAllowed) %>% # filter to only get commercial use allowed
    group_by(taxonKey,friendlyName,friendlyKey,basisOfRecord) %>%
    summarise(imageCount=n()) %>%
    mutate(license = "commercial use allowed") %>%
    mutate(country = "world") %>%
    mutate(country = as.character(country))

  D_global_noncommercial = D %>% #
    filter(canOthersUse) %>% # filter both
    filter(!commercialUseAllowed) %>%
    group_by(taxonKey,friendlyName,friendlyKey,basisOfRecord) %>%
    summarise(imageCount=n()) %>%
    mutate(country = "world") %>%
    mutate(license = "only non-commercial use allowed") %>%
    mutate(country = as.character(country))


  D = rbind(
    D_total,
    D_commercial,
    D_noncommercial,
    D_global_total,
    D_global_commercial,
    D_global_noncommercial
  )

  return(D)
}
