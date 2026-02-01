# tile files

#requirements ----
library(terra)

# data ----
imgfile <- "data/Authausen_03.tif"
img <- rast(imgfile)

# tiling ----
dim <- dim(img)[1:2] #check dimension, excluding channel count
tileGrid <- c(ceiling(dim[1]/6000), ceiling(dim[2]/6000)) #check how many tiles no larger than 6000px in either direction we can get (to do: check maximum feasible tile size on other laptops as well)
tileExtent <- ceiling(dim/tileGrid)

filename <- gsub(".tif", "_tile_.tif", imgfile)
makeTiles(img, tileExtent, na.rm = TRUE, filename)


#files are in several folders sorted by location
dirs <- list.dirs("../testing-grounds", recursive = FALSE)


for(i in 1:length(dirs)){
  files <- list.files(dirs[i], pattern = ".tif", full.names = TRUE)
  for(j in 1:length(files)){
    img <- rast(files[j])
    dim <- dim(img)[1:2] #check dimension, excluding channel count
    tileGrid <- c(ceiling(dim[1]/6000), ceiling(dim[2]/6000)) #check how many tiles no larger than 6000px in either direction we can get (to do: check maximum feasible tile size on other laptops as well)
    tileExtent <- ceiling(dim/tileGrid)
    filename <- gsub(".tif", "_tile_.tif", files[j])
    makeTiles(img, tileExtent, na.rm = TRUE, filename)
  }
}




