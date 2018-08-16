#' @export
nap_connect <- function(username, password) {

  drv <- DBI::dbDriver("Oracle")
  host <- "oracle.hav.fo"
  port <- 1521
  xe <- "xe"

  connect.string <- paste(
    "(DESCRIPTION=",
    "(ADDRESS=(PROTOCOL=tcp)(HOST=", host, ")(PORT=", port, "))",
    "(CONNECT_DATA=(SERVICE_NAME=", xe, ")))", sep = "")

  con <- ROracle::dbConnect(drv, username = username, password = password,
                            dbname = connect.string)

  return(con)
}

