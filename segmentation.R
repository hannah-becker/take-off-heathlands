# segmentation
library(terra)
library(snic)


imgfile <- commandArgs(trailingOnly=TRUE)

outname = gsub(".tif$", "_segments.gpkg", imgfile)
  
print(imgfile)
img = rast(imgfile)

seeds = snic_grid(img, spacing = 40)
segmentation_snic = snic(img, seeds)
seg_snic = snic_get_seg(segmentation_snic)
seg_poly = terra::as.polygons(seg_snic)

# add template columns
seg_poly$class = ""
seg_poly$shadow = NA
seg_poly$unsure = NA



writeVector(seg_poly, outname, overwrite = TRUE)




