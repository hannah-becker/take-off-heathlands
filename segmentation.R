# segmentation

# requirements ----
library(terra)
library(snic)

# data ----
dirs <- list.dirs("~/takeoff/netdrive/DBU_tiles", recursive = FALSE) 


# segment ----

for (i in 1:length(dirs)){
  files <- list.files(dirs[i], pattern = ".tif", full.names = TRUE)
  for(j in 1:length(files)){
    img <- rast(files[j])[[1:7]] #channel 8 is NA
    if (class(try(
      if (unique(terra::global(img, fun = "anynotNA")$anynotNA)) { #don't care about the ones that're fully NA
        seeds <- snic_grid(img, spacing = 40)
        segmentation_snic <- snic(img, seeds)
        seg_snic <- snic_get_seg(segmentation_snic)
        seg_poly <- terra::as.polygons(seg_snic)
        # add template columns
        seg_poly$class <- ""
        seg_poly$shadow <- NA
        seg_poly$unsure <- NA
        outname <- paste0("temp_gpkg_storage/", gsub(".tif$", "_segments.gpkg", basename(files[j]))) #can't write these to netdrive for some reason
        writeVector(seg_poly, outname, overwrite = TRUE)
    })) == "try-error"){
      print(paste0("could not place seeds for tile at file index ", j, " in directory ", i)) & next
      } #some tiles have data but too little for seed placement at spacing = 40
  }
}


#seed placement error seems to have only affected the tile at index 70 in directory 2