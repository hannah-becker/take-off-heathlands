# TakeOff Image Labeling
Workflow for the labeling campaign of drone images of heathlands


## Segment the image

Run the script `segmentation.R` with you image like this:

```
Rscript segmentation.R schiessplatz.tif

```

This will automatically create a `schiessplatz_segments.gpkg` in the same directory as the input image.

## Label the segments in QGIS

### Setup

Load the image and the segments into QGIS. Apply the `label_style.qml` to the vector layer.

This automatically creates a drop down menu for the `class` column with standardised class names. 

This also configures the visualization of the layer such that if you assign classes the polygon dissapears so you don't have to bother with it again. You can still switch on the polygons you assigned classes at the Layers Tab (Tickboxes).

### Labelling

Turn on the layer editing mode (Pencil). Select polygons and use the "Modify the attributes of all selected features" Tool to assign a class.
There are also two tickboxes for "shadow" and "unsure" for the respective cases.



