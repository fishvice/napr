#' @export
nap_tbl <- function(con, tbl) {
  dplyr::tbl(con, toupper(tbl)) %>%
    dplyr::select_all(tolower)
}
