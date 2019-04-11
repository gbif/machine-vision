# Opens imageData.rda file from proper directory and saves imageDataTaxonAndLicense.rda

getTaxonAndLicenseInfo = function(saveDir="",slice=NULL) {

  # data processing pipeline
  if(is.null(slice)) D = readRDS(saveDir %+% "imageData.rda")
  if(!is.null(slice)) D = readRDS(saveDir %+% "imageData.rda") %>% slice(slice)


  # fix two countries problem
  twoCountries = D$countryCode %>% map(~ length(.x) < 1) %>% flatten_lgl()

  D = D %>%
    filter(!twoCountries) %>% # remove those with more than one country
    unnest(countryCode) %>%
    gbifapi::addTaxonInfo(taxonKey) %>%
    filter(rank == "SPECIES") %>%
    unnest(license) %>%
    rename(verbatimLicense = license) %>%
    merge(gbifimagedata::getLicenseData(),id="verbatimLicense",all.x=TRUE) %>%
    gbifapi::addCountryName(countryCode)

  # group by license first
  D_total = D %>%
    group_by(friendlyName,friendlyKey,basisOfRecord,country) %>%
    summarise(imageCount=n()) %>%
    mutate(license = "total") %>%
    mutate(country = as.character(country))

  # license divisions
  D_commercial = D %>%
    filter(commercialUseAllowed) %>% # filter to only get commercial use allowed
    group_by(friendlyName,friendlyKey,basisOfRecord,country) %>%
    summarise(imageCount=n()) %>%
    mutate(license = "commercial use allowed") %>%
    mutate(country = as.character(country))

  D_noncommercial = D %>%
    filter(canOthersUse) %>% # filter both
    filter(!commercialUseAllowed) %>%
    group_by(friendlyName,friendlyKey,basisOfRecord,country) %>%
    summarise(imageCount=n()) %>%
    mutate(license = "only non-commercial use allowed") %>%
    mutate(country = as.character(country))

  # global stats for friendly taxon
  D_global_total = D %>% # filter to only get commercial use allowed
    group_by(friendlyName,friendlyKey,basisOfRecord) %>%
    summarise(imageCount=n()) %>%
    mutate(license = "total") %>%
    mutate(country = "world") %>%
    mutate(country = as.character(country))

  D_global_commercial = D %>% # filter to only get commercial use allowed
    filter(commercialUseAllowed) %>% # filter to only get commercial use allowed
    group_by(friendlyName,friendlyKey,basisOfRecord) %>%
    summarise(imageCount=n()) %>%
    mutate(license = "commercial use allowed") %>%
    mutate(country = "world") %>%
    mutate(country = as.character(country))

  D_global_noncommercial = D %>% # filter to only get commercial use allowed
    filter(canOthersUse) %>% # filter both
    filter(!commercialUseAllowed) %>%
    group_by(friendlyName,friendlyKey,basisOfRecord) %>%
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

  saveDir %+% "imageDataTaxonAndLicense.rda"
  saveRDS(D,file=saveDir %+% "imageDataTaxonAndLicense.rda") # and also save as a side effect
  return(D)
}


