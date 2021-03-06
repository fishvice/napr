# Multpelt

nap_biology_from_mar <- function(con, cruise, sttype) {

  # NOTE: Function not yet complete

  con <- mar::connect_mar()
  st <-
    mar::lesa_stodvar(con) %>%
    dplyr::filter(leidangur %in% cruise)

  prefix <-
    st %>%
    select(cruise = leidangur,
           # should replace skip with vessel
           skip,
           station = stod,
           year = ar) %>%
    collect(n = Inf) %>%
    mutate(country = "IS",
           vessel = skip,
           sttype = sttype,
           dummy = -999) %>%
    select(country, skip, cruise, station, sttype, year)


  IDS <-
    st %>%
    select(synis_id) %>%
    dplyr::collect(n = Inf) %>%
    dplyr::pull(synis_id)

  kv <-
    mar::lesa_kvarnir(con) %>%
    dplyr::filter(synis_id %in% IDS) %>%
    dplyr::collect(n = Inf) %>%
    dplyr::select(synis_id:slaegt, lifur, magi)

  # a security blanket
  kv2 <-
    kv %>%
    dplyr::select(synis_id:kynthroski) %>%
    dplyr::group_by(synis_id, tegund, kyn, kynthroski, lengd) %>%
    dplyr::summarise(n.kvarnir = dplyr::n())

  biology <-
    mar::lesa_lengdir(con) %>%
    dplyr::filter(synis_id %in% IDS) %>%
    dplyr::collect(n = Inf) %>%
    dplyr::select(synis_id, tegund, kyn, kynthroski, lengd, fjoldi) %>%
    # a security blanket
    dplyr::group_by(synis_id, tegund, kyn, kynthroski, lengd) %>%
    dplyr::summarise(n.lengdir = sum(fjoldi)) %>%
    dplyr::ungroup() %>%
    dplyr::full_join(kv2) %>%
    dplyr::mutate(n = ifelse(is.na(n.kvarnir), n.lengdir, n.lengdir - n.kvarnir)) %>%
    # quickfix
    dplyr::filter(n > 0) %>%
    dplyr::select(-c(n.kvarnir, n.lengdir)) %>%
    dplyr::filter(n != 0) %>%
    tidyr::uncount(n) %>%
    dplyr::mutate(id = 3) %>%
    dplyr::bind_rows(kv %>%
                mutate(id = 1)) %>%
    select(species = tegund,
           length = lengd,
           weight = oslaegt,
           ageotolith = aldur,
           sex = kyn,
           maturation = kynthroski,
           stomachwt = magi) %>%
    mutate(dummy = -999)

  biology <-
    prefix %>%
    dplyr::left_join(biology)


  return(biology)

}


