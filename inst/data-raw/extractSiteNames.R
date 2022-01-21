#' Extract relevant information from Engineering Weather Data file
#'
#' @param file Engineering Weather Data text file
#'
#' @return data.table
#'
#' @source
#' \enumerate{
#'    \item r - How can I check if a file is empty? - Stack Overflow answered by Konrad Rudolph and edited by Geekuna Matata on Apr 23 2014. See \url{https://stackoverflow.com/questions/23254002/how-can-i-check-if-a-file-is-empty}.
#'    \item r - Better error message for stopifnot? - Stack Overflow answered by Andrie on Dec 1 2011. See \url{https://stackoverflow.com/questions/8343509/better-error-message-for-stopifnot}.
#'    \item RDocumentation: n.readLines {reader}. See \url{http://www.rdocumentation.org/packages/reader/versions/1.0.5/topics/n.readLines}.
#'    \item r - concatenating rows of a data frame - Stack Overflow answered and edited by adibender on Dec 19 2012. See \url{https://stackoverflow.com/questions/13944078/concatenating-rows-of-a-data-frame/13944315}.
#' }
#'
#' @import reader
#' @import stringi
#'
extractSiteNames <- function (file) {

if (file.info(file)$size == 0) {

  stop("Your file is empty. Please try again with a different file.")
# Sources 1 & 2 / only process non-empty files and provide a stop warning if the input file is empty

  } else {

     RDatatmp <- n.readLines(file, n = 5, header = FALSE) # Source 3 / read 5 lines of each file & there is no header

	RDatatmp <- paste(RDatatmp[1:5], collapse = " ") # Source 4

     RDatatmp <- stri_split_fixed(RDatatmp, pattern = "Latitude", n = 2)[[1]][1]

     }
     }
