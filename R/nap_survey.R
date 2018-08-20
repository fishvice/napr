#' @export
nap_survey <- function(con) {
  nap_tbl(con, "survey") %>%
    mutate(survey = str_trim(survey))
}
