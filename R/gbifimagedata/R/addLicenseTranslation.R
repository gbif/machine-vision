# adds license and taxonmic information to imageData.rda. saves imageDataTaxonAndLicense.rda

addLicenseTranslation = function(D,Rank="SPECIES") {

  # fix two countries problem
  twoCountries = D$countryCode %>% map(~ length(.x) < 1) %>% flatten_lgl()

  D = D %>%
    filter(!twoCountries) %>% # remove those with more than one country
    unnest(countryCode) %>% # list to rows
    unnest(license) %>%
    rename(verbatimLicense = license) %>%
    merge(gbifimagedata::getLicenseData(),id="verbatimLicense",all.x=TRUE) %>%
    gbifapi::addCountryName(countryCode)

  # filter(rank == !!Rank) %>% # get the images at the rank of SPECIES or GENUS
  # gbifapi::addTaxonInfo(taxonKey) %>% # expensive step might want to to in previous step
  return(D)
}
