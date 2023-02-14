# ie2miscdata 1.0.3 (13 February 2023)

* Changed the R version to >= 3.5.0 due to "WARNING: Added dependency on R >= 3.5.0 because serialized objects in serialize/load version 3 cannot be read in older versions of R." during the build process.
* Removed `lubridate` from Imports
* Removed `rgdal` (being retired in 2023) and `sp` from Suggests and also modified the version numbers for `USA.state.boundaries` and `ggplot2`
* Added `spelling`, `reader`, `sf`, and `rvest` to Suggests
* Received an e-mail issue from Prof Brian Ripley on 12 February 2023 regarding the changes in `USA.state.boundaries` which impact the vignettes created in this package. The vignettes have thus been modified.
* Changed an instance of http to https in all of the vignettes


# ie2miscdata 1.0.2 (20 January 2022)

* Fixed the issues with the 1.0.1 version
* Changed `states2k` to `USA.state.boundaries` in DESCRIPTION Suggests and throughout the package
* Removed the | file LICENSE statement from the DESCRIPTION file as it was not needed
* Revised the vignettes


# ie2miscdata 1.0.1

* Changed `USGSstates2k` to `states2k` in DESCRIPTION Suggests
* Updated DESCRIPTION Description
* Changed all documentation with inside.org to rdocumentation.org


# ie2miscdata 1.0.0

* Initial release
