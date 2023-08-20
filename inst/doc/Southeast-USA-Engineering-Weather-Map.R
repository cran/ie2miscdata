## ---- warning = FALSE, message = FALSE, out.width = "100%", out.height = "100%"----
install.load::load_package("ie2miscdata", "USA.state.boundaries", "data.table", "ggplot2", "sf", "spatstat.geom")
# load needed packages using the load_package function from the install.load package (it is assumed that you have already installed these packages)


data(weather_results)
# load the weather_results data (containing the site information for USA weather stations)

data(state_boundaries_wgs84)
# load the state_boundaries_wgs84 data from USA.state.boundaries (for the USA map)


## Weather Results

weather_results_map <- copy(weather_results)
# copy the weather_results using data.table

setnames(weather_results_map, 3:4, c("lat", "lon"))
# set the names of columns 3 and 4 using data.table

weather_results_map_sf <- st_as_sf(weather_results_map, coords = c("lon", "lat"), crs = "+proj=longlat +datum=NAD83")
# set the initial projection to longlat using sf

weather_results_map_sf_projected <- st_transform(weather_results_map_sf, "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0")
# transform the coordinates to match those of the USA_state_boundaries_map data from USA.state.boundaries.data (formerly in USA.state.boundaries)


## Southeast region

# subset all southeastern states from state_boundaries_wgs84
southeast <- subset(state_boundaries_wgs84, NAME %in% c("Kentucky", "Florida", "North Carolina", "South Carolina", "Alabama", "Mississippi", "Louisiana", "Georgia", "Virginia", "Tennessee"))
# Source 1

southeast_projected <- st_transform(southeast, "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0")
# transform the coordinates to match those of the USA_state_boundaries_map data from USA.state.boundaries.data (formerly in USA.state.boundaries)


# As different methods using sf failed to subset the weather map points within the Southeastern USA, the weather results geometry was subsetted so that spatstat.geom could be used to determine this information

weather_results_map_dt <- as.data.table(st_coordinates(weather_results_map_sf_projected))
# transform the coordinates only to a data.table

setnames(weather_results_map_dt, c("X", "Y"), c("lon", "lat"))
# set the names of columns X and Y using data.table


southeast_owin <- spatstat.geom::as.owin(southeast_projected)
# transform to Window



inside_southeast <- which(spatstat.geom::inside.owin(weather_results_map_dt$lon, weather_results_map_dt$lat, southeast_owin))
# determine which locations are within the borders of the Southeastern USA
# Source 2


weather_results_keep <- weather_results[inside_southeast, ]
# keep only the locations within the Southeastern USA

weather_results_map_keep <- copy(weather_results_keep)
# create a data.table copy of the sites that are kept

setnames(weather_results_map_keep, 3:4, c("lat", "lon"))
# set the names of columns 3 and 4 using data.table

weather_results_map_keep_sf <- st_as_sf(weather_results_map_keep, coords = c("lon", "lat"), crs = "+proj=longlat +datum=WGS84 +ellps=WGS84")
# set the projection to longlat using sf

# plot the map using ggplot2
p <- ggplot() + geom_sf(data = southeast, colour = "black", fill = "white")
p <- p + geom_sf(data = weather_results_map_keep_sf, colour = "#3591d1")
p <- p + labs(x = "", y = "", title = "Southeast USA Engineering Weather Sites Map")
print(p)

