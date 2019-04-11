saveData = function(D,saveDir="",fileName="imageData.rda") {

  if(!fs::dir_exists(saveDir)) {
    fs::dir_create(saveDir) # create if does not exist
  }

  saveRDS(D,file= saveDir %+% fileName) # save the file
  return(D) # return the data to pass to next part
}
