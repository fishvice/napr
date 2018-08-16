#' @export
nap_logbook <- function(con, convert = TRUE) {
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

  return(q)
}
