#' Timezone (tz) codes
#'
#' A table containing the worldwide timezones and UTC offsets.
#'
#'
#'
#' @format A data.table data frame with 54 rows and 7 variables:
#' \describe{
#' \item{Tz Cd}{Timezone Code}
#' \item{Tz Nm}{Timezone Name}
#' \item{Tz Ds}{Timezone Location}
#' \item{Tz Utc Offset Tm}{Timezone UTC Offset}
#' \item{Tz Dst Cd}{Timezone Daylight Savings Code}
#' \item{Tz Dst Nm}{Timezone Daylight Savings Name}
#' \item{Tz Dst Utc Offset Tm}{Timezone Daylight Savings UTC Offset}
#' }
#'
#'
#' @references
#' This data is from National Water Information System: Help System Time Zone Codes. See \url{http://help.waterdata.usgs.gov/code/tz_query?fmt=html}.
#'
#'
#' @docType data
#' @name tz_codes
#' @usage tz_codes
#' @examples
#' tz_codes
NULL
