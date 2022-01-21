#' Extract relevant information from Engineering Weather Data file
#'
#' @param file Engineering Weather Data text file
#'
#' @return data.table
#'
#'
#' @source
#' \enumerate{
#'    \item r - How can I check if a file is empty? - Stack Overflow answered by Konrad Rudolph and edited by Geekuna Matata on Apr 23 2014. See \url{https://stackoverflow.com/questions/23254002/how-can-i-check-if-a-file-is-empty}.
#'    \item r - Better error message for stopifnot? - Stack Overflow answered by Andrie on Dec 1 2011. See \url{https://stackoverflow.com/questions/8343509/better-error-message-for-stopifnot}.
#' }
#'
#' @import data.table
#' @import stringi
#' @import mgsub
#'
#' @export
extractWeather <- function (file) {

if (file.info(file)$size == 0) {

  stop("Your file is empty. Please try again with a different file.")
# Sources 1 & 2 / only process non-empty files and provide a stop warning if the input file is empty

  } else {

	RDatatmp <- fread(file)

	RDatatmpnamed <- as.character(names(RDatatmp)[1])
     RDatatmpnamed <- data.frame(as.character(names(RDatatmp)[1]))
     names(RDatatmpnamed) <- "Site name"

     if (ncol(RDatatmp) == 8) {

     RDatatmp[, 2 := NULL, with = FALSE]

     }

     RDatatmphead <- RDatatmp[1:2, c(1, 2), with = FALSE]
     RDatatmptail <- RDatatmp[2, 3:4, with = FALSE]

     RDatatmpuse <- data.table(V1 = RDatatmpnamed, V2 = gsub("WMO No. ", "\\1\\2", RDatatmphead[1, 2, with = FALSE][1]), V3 = gsub("Latitude = ", "\\1\\2", RDatatmphead[1, 1, with = FALSE][1]), V4 = gsub("Longitude = ", "\\1\\2", RDatatmphead[2, 1, with = FALSE][1]), V5 = gsub("Elevation = ", "\\1\\2", RDatatmphead[2, 2, with = FALSE][1]), V6 = RDatatmptail[, 1, with = FALSE], V7 = RDatatmptail[, 2, with = FALSE])
     RDatatmpuse$V4 <- gsub("Longitude =", "\\1\\2", RDatatmphead[2, 1, with = FALSE][1])
     setnames(RDatatmpuse, c("Site name", "WMO No.", "lat", "lon", "elevation", "Design Value", "Mean Coincident Dry Bulb Temperature"))

     RDatatmpuse <- RDatatmpuse[, lapply(.SD, stri_trim_both, pattern = "\\P{Wspace}")] # trim the left and right

     RDatatmpuse[, "elevation" := tolower(RDatatmpuse$"elevation")]
     pats <- c("elevation =", "feet")
     RDatatmpuse[, "elevation" := mgsub(RDatatmpuse$"elevation", pats, "", fixed = FALSE)]

    }
    }
