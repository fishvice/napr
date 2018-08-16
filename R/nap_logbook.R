#' @export
nap_logbook <- function(con, convert = TRUE, create_date = FALSE) {
  q <- nap_tbl(con, "logbook")

  if(convert) {
    q <-
      q %>%
      dplyr::mutate(lon = as.numeric(lon),
                    lat = as.numeric(lat),
                    day = as.numeric(day),
                    hour = as.numeric(hour),
                    min = as.numeric(min))
  }

  if(create_date) {
    q <-
      q %>%
      dplyr::mutate(date = to_date(ifelse(day <= 31 & month <= 12,
                                          concat(concat(concat(concat(year, '-'), month), '-'), day),
                                          "1958-24-12"),
                                   'yyyy-mm-dd'))
  }

  return(q)
}
