#' @export
nap_acoustic <- function(con, convert = TRUE, create_date = FALSE) {
  q <- nap_tbl(con, "acoustic")
  return(q)
}
