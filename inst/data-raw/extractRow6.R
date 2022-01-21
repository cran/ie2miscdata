#' Extract relevant information from Engineering Weather Data file
#'
#' @param file Engineering Weather Data text file
#'
#' @return data.frame
#'
#'
#' @source
#' \enumerate{
#'    \item r - How can I check if a file is empty? - Stack Overflow answered by Konrad Rudolph and edited by Geekuna Matata on Apr 23 2014. See \url{https://stackoverflow.com/questions/23254002/how-can-i-check-if-a-file-is-empty}.
#'    \item r - Better error message for stopifnot? - Stack Overflow answered by Andrie on Dec 1 2011. See \url{https://stackoverflow.com/questions/8343509/better-error-message-for-stopifnot}.
#' }
#'
#' @import stringi
#' @import reader
#'
#' @export
extractRow6 <- function (file) {

if (file.info(file)$size == 0) {

  stop("Your file is empty. Please try again with a different file.")
# Sources 1 & 2 / only process non-empty files and provide a stop warning if the input file is empty

  } else {

	RDatatmp <- n.readLines(file, n = 10, header = FALSE) # Source 1 / read 10 lines of each file & there is no header

	RDatatmp <- RDatatmp[6]

	RDatatmp <- stri_trim_both(RDatatmp) # trim the left and right
     }
     }