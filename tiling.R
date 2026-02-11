# tile files

# requirements ----
library(terra)


#files are in several folders sorted by location
dirs <- list.dirs("~/takeoff/netdrive/DBU_labeling", recursive = FALSE)
index <- read.csv("./aux-files/tile_index_heathlands.csv")[[1]]

#loop over files in directories and check against needed heathland files index, then tile

#system.time(
  for(i in 1:length(dirs)){
  files <- list.files(dirs[i], pattern = ".tif", full.names = TRUE)
  for(j in 1:length(files)){
    if(basename(files[j]) %in% index){
    img <- rast(files[j])
    dim <- dim(img)[1:2] #check dimension, excluding channel count
    tileGrid <- c(ceiling(dim[1]/4096), ceiling(dim[2]/4096)) #check how many tiles no larger than 20000px in either direction we can get (to do: check maximum feasible tile size on other laptops as well)
    tileExtent <- ceiling(dim/tileGrid)
    filename <- gsub("DBU_labeling", "DBU_tiles", gsub(".tif", "_tile_.tif", files[j]))
    makeTiles(img, tileExtent, na.rm = TRUE, extend = FALSE, filename)
    }
  }
}
#)
#8192
#files are automatically LZW compressed. gdal="COMPRESS=NONE" to turn off
