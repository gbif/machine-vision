# get the occurrence image data. Could probably be turned into a download

getImageData = function(friendlyName = "Frogs",friendlyKey = "952",Step=10,maxPages=2) {

  totalCount = GET("http://api.gbif.org/v1/occurrence/search?media_type=StillImage&taxon_key=" %+% friendlyKey) %>%
    content() %>%
    pluck("count")

  print("total occurrences: " %+% totalCount)
  if(totalCount > 200000) warn("results might not be accurate over 200 000 limit")



  url = "http://api.gbif.org/v1/occurrence/search?media_type=StillImage&taxon_key=" %+% friendlyKey
  occList = gbifapi::page_api(url=url,pluck="results",Step=Step,maxPages=maxPages,verbose=TRUE) # page through api using gbifapi package

  print(length(occList))

  # grab information about the occurrence
  publisher = occList %>%
    map(~ .x$publishingOrgKey) %>%
    flatten_chr()

  occKey = occList %>%
    map(~ .x$key) %>%
    flatten_dbl()

  countryCode = occList %>%
    map(~ .x$countryCode)
    # %>%
    # map(~ flatten_chr(.x)) # get just the first one for sanity
     # countryCode should be a list column. Do not flatten.

  taxonKey = occList %>%
    map(~ .x$taxonKey) %>%
    flatten_chr()

  basisOfRecord = occList %>%
    map(~ .x$basisOfRecord) %>%
    flatten_chr()

  numImages = occList %>%
    map(~ length(.x$media)) %>%
    flatten_dbl()

  rank = occList %>%
    map(~ .x$taxonRank) %>%
    flatten_chr()

  taxonomicStatus = occList %>%
    map(~ .x$taxonomicStatus) %>%
    flatten_chr()

  # Get the license of the photo
  # licenseList = occKey %>% map(~ GET("https://api.gbif.org/v1/occurrence/" %+% .x) %>% content()) %>%
  licenseList = occList %>%
    map(~ .x$media) %>%
    map(~ flatten(.x)) %>%
    map(~ tibble::enframe(.x)) %>%
    map(~ .x %>% filter(name=="license") %>% pull(value) %>% flatten_chr())

  imageData = tibble::tibble(
    occKey=occKey,
    numImages=numImages,
    friendlyKey=friendlyKey,
    friendlyName=friendlyName,
    taxonKey=taxonKey,
    rank = rank,
    taxonomicStatus = taxonomicStatus,
    basisOfRecord=basisOfRecord,
    license=licenseList,
    publisher=publisher,
    countryCode=countryCode)

  return(imageData)
}
