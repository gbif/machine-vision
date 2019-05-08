This script supplements a GBIF DWCA download with image data.

Two additional columns are added to the multimedia extension:

1. A column containing a path to a 320×320px JPEG image, which is added to the ZIP archive.
2. A column containing a path to a 64×64px JPEG image, also in the archive, for use as a thumbnail.

This is very close to the usual DWCA files shared by GBIF, but keeping that close compatibility
is probably too limiting.

**This are very rough scripts, just to help us define an export format.**
(And writing them in R or Python would have been a much better idea…)
