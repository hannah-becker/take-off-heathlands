# segmentation
library(terra)
library(snic)


#imgfile <- commandArgs(trailingOnly=TRUE)
#imgfile <- "~/takeoff/netdrive/DBU_tiles/Weisshaus/Weisshaus_03_tile_3.tif"

dirs <- list.dirs("~/takeoff/netdrive/DBU_tiles", recursive = FALSE) 

for (i in 1:length(dirs)){
  files <- list.files(dirs[i], pattern = ".tif", full.names = TRUE)
  for(j in 1:length(files)){
    img <- rast(files[j])[[1:7]] #channel 8 is NA
    seeds <- snic_grid(img, spacing = 40)
    segmentation_snic <- snic(img, seeds)
    seg_snic <- snic_get_seg(segmentation_snic)
    seg_poly <- terra::as.polygons(seg_snic)
    # add template columns
    seg_poly$class <- ""
    seg_poly$shadow <- NA
    seg_poly$unsure <- NA
    outname <- gsub(".tif$", "_segments.gpkg", files[j])
    writeVector(seg_poly, outname, overwrite = TRUE)
  }
}







