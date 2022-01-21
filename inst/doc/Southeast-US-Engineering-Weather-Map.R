## ---- warning = FALSE, message = FALSE, out.width = "100%", out.height = "100%"----
install.load::load_package("ie2miscdata", "USA.state.boundaries", "data.table", "spatstat", "sp", "rgdal", "ggplot2", "spatstat.geom", "maptools")
# load needed packages using the load_package function from the install.load package (it is assumed that you have already installed these packages)


data(weather_results) # load the weather_results data (containing the site information for US weather stations)
data(USA_state_boundaries_map) # load the USA_state_boundaries_map data (for the US map)

weather_results_map <- copy(weather_results) # copy the weather_results using data.table
setnames(weather_results_map, 3:4, c("lat", "lon")) # set the names of columns 3 and 4 using data.table


# subset the southeastern states
southeast <- subset(USA_state_boundaries_map, NAME %in% c("Kentucky", "Florida", "North Carolina", "South Carolina", "Alabama", "Mississippi", "Louisiana", "Georgia", "Virginia", "Tennessee")) # Source 7 / subset for Southeast states only


# Source 1 - 6 begins
# set coordinates and projection
class(weather_results_map)
coordinates(weather_results_map) <- ~ lon + lat
class(weather_results_map)

proj4string(weather_results_map) <- CRS("+proj=longlat +datum=NAD83")

weather_results_map <- spTransform(weather_results_map, CRS(proj4string(USA_state_boundaries_map)))

weather_results_map <- data.frame(weather_results_map)


# Switch to x/y from lat/lon
# change variable names
names(weather_results_map)[names(weather_results_map) == "lon"] <- "x"
names(weather_results_map)[names(weather_results_map) == "lat"] <- "y"


southeast_regions <- slot(southeast, "polygons")


southeast_regions <- lapply(southeast_regions, function(x) { SpatialPolygons(list(x)) })
southeast_windows <- lapply(southeast_regions, as.owin)
southeast_h <- hyperframe(window = southeast_windows)
southeast_h <- cbind.hyperframe(southeast_h, southeast@data)

southeast_owin <- as.owin(southeast)


# determine which locations are within the borders of the Southeastern US
inside_southeast <- which(inside.owin(weather_results_map$x, weather_results_map$y, southeast_owin)) # Source 7

weather_results_keep <- weather_results[inside_southeast, ]

line1 <- "Design wet bulb temperatures - 1% exceedance values"

# create a data.table copy of the sites that are kept
weather_results_map_keep <- copy(weather_results_keep)
setnames(weather_results_map_keep, 3:4, c("lat", "lon"))


# set coordinates and projection for the locations contained within the Southeastern US
class(weather_results_map_keep)
coordinates(weather_results_map_keep) <- ~ lon + lat
class(weather_results_map_keep)

proj4string(weather_results_map_keep) <- CRS("+proj=longlat +datum=NAD83")

weather_results_map_keep <- spTransform(weather_results_map_keep, CRS(proj4string(USA_state_boundaries_map)))

weather_results_map_keep <- data.frame(weather_results_map_keep)


# Switch to x/y from lat/lon
# change variable names
names(weather_results_map_keep)[names(weather_results_map_keep) == "lon"] <- "x"
names(weather_results_map_keep)[names(weather_results_map_keep) == "lat"] <- "y"


# plot the map using ggplot2
colorsnow <- c("Weather Data Sites" = "#3591d1")

p <- ggplot() + geom_polygon(data = southeast, aes(x = long, y = lat, group = group), colour = "black", fill = "white")
p <- p + geom_point(data = weather_results_map_keep, aes(x = x, y = y, color = "Weather Data Sites"))
p <- p + labs(x = "", y = "", title = "Southeast US Engineering Weather Sites Map")
p <- p + scale_colour_manual(values = colorsnow, labels = c("Weather Data Sites"), name = "Legend")
p <- p + theme(axis.ticks.y = element_blank(), axis.text.y = element_blank(), # get rid of x ticks/text
          axis.ticks.x = element_blank(), axis.text.x = element_blank(), # get rid of y ticks/text
          plot.title = element_text(lineheight = 0.8, face = "bold", vjust = 1), # make title bold and add space
          panel.grid.major = element_blank(), # Source 3 / get rid of major grid
          panel.grid.minor = element_blank()) # Source 3 / get rid of minor grid
print(p)
# Source 1 - 6 ends

