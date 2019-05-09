# run the standard analysis

runStandard = function(friendlyName,friendlyKey,useSaved=FALSE) {

  saveDir = "C:/Users/ftw712/Desktop/image data friendly taxa/data/" %+% friendlyName %+% "/"

  if(!useSaved) {
  D = getImageData(friendlyName=friendlyName,friendlyKey=friendlyKey,Step=100,maxPages=2000) %>%
    saveData(saveDir,fileName="imageData.rda") %>% # save the data from the most expensive step
    loadData(saveDir=saveDir,fileName="imageData.rda") %>% # load that data from disk
    filter(taxonomicStatus == "ACCEPTED") %>% # get only ACCEPTED species
    filter(rank == "SPECIES") %>% # only get for Rank SPECIES
    addLicenseTranslation() %>%
    summariseTable() %>%
    filter(imageCount >= 1) %>% # only get species with more than n images
    groupSummarise() %>%
    filter(country == "world") %>%
    addPercentCoverage(globalOnly=TRUE) %>%
    addWorldPercentage() %>% # adds through a different api
    print() %>%
    select(totalSpeciesWorld = totalSpeciesInCountry,numWithImages = numSpeciesWithImages,basisOfRecord,license,percentCoverage) %>%
    arrange(-percentCoverage,license)
  }

  if(useSaved) {
  D = loadData(saveDir=saveDir,fileName="imageData.rda") %>% # load that data from disk
      filter(taxonomicStatus == "ACCEPTED") %>% # get only ACCEPTED species
      filter(rank == "SPECIES") %>% # only get for Rank SPECIES
      addLicenseTranslation() %>%
      summariseTable() %>%
      filter(imageCount >= 1) %>% # only get species with more than n images
      groupSummarise() %>%
      filter(country == "world") %>%
      addPercentCoverage(globalOnly=TRUE) %>%
      addWorldPercentage() %>% # adds through a different api
      print() %>%
      select(totalSpeciesWorld = totalSpeciesInCountry,numWithImages = numSpeciesWithImages,basisOfRecord,license,percentCoverage) %>%
      arrange(-percentCoverage,license)
  }


  return(D)
}
