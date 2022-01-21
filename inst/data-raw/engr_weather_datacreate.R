# source 1
# r - Convert column classes in data.table - Stack Overflow answered by Matt Dowle on Dec 27 2013. See \url{https://stackoverflow.com/questions/7813578/convert-column-classes-in-data-table}.

# source 2
# r - Combine/merge lists by elements names - Stack Overflow answered and edited by flodele on Aug 30 2013. See \url{https://stackoverflow.com/questions/18538977/combine-merge-lists-by-elements-names}.

# source 3
# r - Exporting data of inequal length to CSV - Stack Overflow answered by cory on Sep 17 2014. See \url{https://stackoverflow.com/questions/25899013/exporting-data-of-inequal-length-to-csv/25899712}.

# source 4
# r - Convert column classes in data.table - Stack Overflow answered by Matt Dowle on Dec 27 2013. See \url{https://stackoverflow.com/questions/7813578/convert-column-classes-in-data-table}.


# Reference
# This data is from the ENGINEERING WEATHER DATA PRODUCTS (EWD) CD-ROM, version 1.0, 23 December 1999. CD-ROM provided by the National Climatic Data Center Climate Services Division. See \url{https://www.ncei.noaa.gov/nespls/olstore.prodspecific?prodnum=5005}.



install.load::load_package("data.table", "stringi", "mgsub") # load needed packages


## Using Tabula first
# ./tabpdf2csv.sh
# 2nd part
# tabula -p 1 -a 385.7785714285714,239.33571428571426,438.23571428571427,524.5714285714286 -o $f.csv $f

engr1 <- list.files("./engineering_weather_data", "*.csv$", full.names = TRUE)
engr1name <- basename(file_path_sans_ext(engr1))
engr1name <- mgsub(engr1name, ".pdf", "")


engr2 <- list.files("./engineering_weather_data/eng_weather_data", "*.csv$", full.names = TRUE)
engr2name <- basename(file_path_sans_ext(engr2))
engr2name <- mgsub(engr2name, ".pdf", "")

eng1 <- setNames(lapply(engr1, fread), engr1name) # Source 1
eng2 <- setNames(lapply(engr2, fread), engr2name) # Source 1

# Source 2 begins
l <- list(eng1, eng2)
keys <- unique(unlist(lapply(l, names)))
eng <- setNames(do.call(mapply, c(FUN = c, lapply(l, `[`, keys))), keys)
# Source 2 ends

sapply(names(eng), function(x) write.csv(eng[[x]], file = paste0(x, ".csv"), row.names = FALSE)) # Source 3


# read the created csv files back in
engr3 <- list.files("./engineering_weather_data/csv", "*.csv$", full.names = TRUE)


## Process the results created by both tabula and pdf2text
source("./data-raw/extractWeather.R")
weatherfiles <- list.files(path = "./engineering_weather_data/csv", pattern <- "*.csv$", full.names = TRUE)

getinfo <- lapply(weatherfiles, extractWeather)
weather_results <- rbindlist(getinfo)

weather_results[, "Site name" := gsub("\\.+", " ", weather_results$"Site name")]
setkeyv(weather_results, "Site name")

source("./data-raw/extractSiteNames.R")
listsitenames <- list.files(path = "engineering_weather_data/txt", pattern <- "*.txt$", full.names = TRUE)
sitenames <- lapply(listsitenames, extractSiteNames)
sitenamess <- data.table(as.character((t(rbind(sitenames)))))
setnames(sitenamess, "Site name")
setkeyv(sitenamess, "Site name")


source("./data-raw/extractRow6.R")
row6 <- lapply(listsitenames, extractRow6)
row6s <- data.table(as.character((t(rbind(row6)))))
row6s[, V1 := ifelse(nchar(row6s[[1]]) == 2, row6s[[1]], "")]

sitenamess[, "Site name" := paste(sitenamess$"Site name", row6s$V1, sep = "")]

weather_results[, "Site name" := sitenamess$"Site name"]

# changing column to integer class
# obtain the name of the column based on the column number
change_class1 <- c("WMO No.", "elevation", "Design Value", "Mean Coincident Dry Bulb Temperature")
for (col in change_class1) set(weather_results, j = col, value = as.integer(weather_results[[col]])) # Source 4

setkeyv(weather_results, "Site name")

latss <- grep(" S", weather_results$"lat")
weather_results[latss, lats := -1]
weather_results[, lat := stri_split_fixed(weather_results$"lat", pattern = " ", n = 2, simplify = TRUE)[, 1]]

longs <- grep(" W", weather_results$"lon")
weather_results[longs, long := -1]
weather_results[, lon := stri_split_fixed(weather_results$"lon", pattern = " ", n = 2, simplify = TRUE)[, 1]]

# changing column to numeric class
# obtain the name of the column based on the column number
change_class2 <- c("lat", "lon")
for (col in change_class2) set(weather_results, j = col, value = as.numeric(weather_results[[col]])) # Source 4

weather_results[!is.na(lats), lat := lat * lats]
weather_results[!is.na(long), lon := lon * long]

weather_results[, "lats" := NULL, with = FALSE]
weather_results[, "long" := NULL, with = FALSE]

setnames(weather_results, 3:7, c("Latitude", "Longitude", "Elevation (feet)", "Design Value (degrees F)", "Mean Coincident Dry Bulb Temperature (degrees F)"))

save(weather_results, file = "./data/weather_results.RData")
