loadData = function(D=NULL,saveDir="",fileName="imageData.rda") {
  D = readRDS(file= saveDir %+% fileName) # save the file
  return(D) # return the data to pass to next part
}
