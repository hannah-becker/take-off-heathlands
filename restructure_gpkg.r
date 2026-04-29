# requirements ----
library(terra)


dirs <- list.dirs("~/takeoff/netdrive/DBU_tiles", recursive = FALSE) 


for (i in 1:length(dirs)){
  files <- list.files(dirs[i], pattern = ".gpkg", full.names = TRUE)
  for(j in 1:length(files)){
    seg_poly <- rast(j)
    seg_poly$shadow <- FALSE
    seg_poly$overexposed <- FALSE
    seg_poly$confidence <- rep(10)
    outname <- paste0("temp_gpkg_storage/", j)
      writeVector(seg_poly, outname, overwrite = TRUE)
  }
}

















