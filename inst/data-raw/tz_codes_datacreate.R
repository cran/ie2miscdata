# source 1
# r - Convert column classes in data.table - Stack Overflow answered by Matt Dowle on Dec 27 2013. See \url{https://stackoverflow.com/questions/7813578/convert-column-classes-in-data-table}.

# Data source \url{https://help.waterdata.usgs.gov/code/tz_query?fmt=html}
# National Water Information System: Help System Time Zone Codes

install.load::load_package("data.table", "rvest") # load needed packages

tz_codes <- read_html("https://help.waterdata.usgs.gov/code/tz_query?fmt=html")
# or 
# tz_codes <- read_html("./data-raw/tz_codes.html")
tz_codes <- html_table(html_nodes(tz_codes, "table"), fill = TRUE)
tz_codes <- tz_codes[[1]]
tz_codes <- setDT(tz_codes)

save(tz_codes, file = "./data/tz_codes.RData")
