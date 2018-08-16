#' @export
nap_catch <- function(con, convert = TRUE) {
  q <- nap_tbl(con, "catch")

  if(convert) {
    # nothing here yet, possible convert towspeed
    q <- q
  }

  return(q)
}
