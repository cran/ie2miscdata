# ie2miscdata

R data package provides various data sets [USGS Parameter codes with fixed values, USGS global time zone codes, and US Air Force Global Engineering Weather Data] created by Irucka Embry while he was a Cherokee Nation Technology Solutions (CNTS) United States Geological Survey (USGS) Contractor and/or USGS employee.


# Installation

```R
install.packages("ie2miscdata")
```


# Package Contents
This package currently contains 70 datasets:

* `pmcode_* (68 data sets)`: Parameter codes with fixed values from Table 26 (USGS)
* `tz_codes`: Global time zone codes and offsets (USGS)
* `weather_results`: Global Engineering Weather Data (US Air Force)


# Examples (see an example using the weather_results data set in the vignette)
```R
library(install.load)
load_package("iemiscdata", "data.table")
# load needed packages using the load_package function from the install.load
# package (it is assumed that you have already installed these packages)


head(tz_codes) # first 6 rows

tail(weather_results) # last 6 rows


# USGS Sampling Method (Codes)
head(pmcode_82398, 20) # first 20 rows


# USGS Sampler Type, (Codes)
tail(pmcode_84164, 10) # last 10 rows
```



# Disclaimer

This software is in the public domain because it contains materials that originally came from the U.S. Geological Survey, an agency of the United States Department of Interior. For more information, see the official [USGS copyright policy](http://www.usgs.gov/visual-id/credit_usgs.html#copyright)

Although this software program has been used by the U.S. Geological Survey (USGS), no warranty, expressed or implied, is made by the USGS or the U.S. Government as to the accuracy and functioning of the program and related program material nor shall the fact of distribution constitute any such warranty, and no responsibility is assumed by the USGS in connection therewith.

This software is provided "AS IS."
