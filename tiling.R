# tile files

# requirements ----
library(terra)


#files are in several folders sorted by location
dirs <- list.dirs("../test", recursive = FALSE)
index <- read.csv("./aux-files/tile_index_heathlands.csv")[[1]]

#loop over files in directories and check against needed heathland files index, then tile

system.time(
  for(i in 1:length(dirs)){
  files <- list.files(dirs[i], pattern = ".tif", full.names = TRUE)
  for(j in 1:length(files)){
    if(basename(files[j]) %in% index){
    img <- rast(files[j])
    dim <- dim(img)[1:2] #check dimension, excluding channel count
    tileGrid <- c(ceiling(dim[1]/10000), ceiling(dim[2]/10000)) #check how many tiles no larger than 10000px in either direction we can get (to do: check maximum feasible tile size on other laptops as well)
    tileExtent <- ceiling(dim/tileGrid)
    filename <- gsub(".tif", "_tile_.tif", files[j])
    makeTiles(img, tileExtent, na.rm = TRUE, extend = FALSE, filename)
    }
  }
}
)

#figure out if extend = TRUE would be sensible. Would we rather have no labeling duplication issues for edge-of-tile pixels or every single pixel for not easily divisible parent tile column/row counts?
#files are automatically LZW compressed. gdal="COMPRESS=NONE" to turn off
