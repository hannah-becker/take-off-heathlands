# requirements ----
library(sf)


dirs <- list.dirs("~/takeoff/netdrive/DBU_tiles", recursive = FALSE) 


for (i in 1:length(dirs)){
  files <- list.files(dirs[i], pattern = "segments.gpkg", full.names = TRUE)
  for(j in 1:length(files)){
    seg_poly <- read_sf(files[j])[, c(1:3, 5)] #remove unsure category
    seg_poly$shadow <- FALSE
    seg_poly$overexposed <- FALSE
    seg_poly$confidence <- rep(10)
    outname <- paste0("temp_gpkg_storage/", files[j])
      writeVector(seg_poly, outname, overwrite = TRUE)
  }
}

















