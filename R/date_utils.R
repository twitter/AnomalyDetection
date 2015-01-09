format_timestamp <- function(indf, index = 1) {
  if (class(indf[[index]])[1] == "POSIXlt") {
    return(indf)
  }
  if (stringr::str_detect(indf[[index]][1], "^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2} \\+\\d{4}$")) {
    indf[[index]] <- strptime(indf[[index]], format="%Y-%m-%d %H:%M:%S", tz="UTC")
  }
  else if (stringr::str_detect(indf[[index]][1], "^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}$")) {
    indf[[index]] <- strptime(indf[[index]], format="%Y-%m-%d %H:%M:%S", tz="UTC")
  }
  else if (stringr::str_detect(indf[[index]][1], "^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}$")) {
    indf[[index]] <- strptime(indf[[index]], format="%Y-%m-%d %H:%M", tz="UTC")
  }
  else if (stringr::str_detect(indf[[index]][1], "^\\d{2}/\\d{2}/\\d{2}$")) {
    indf[[index]] <- strptime(indf[[index]], format="%m/%d/%y", tz="UTC")
  }
  else if (stringr::str_detect(indf[[index]][1], "^\\d{2}/\\d{2}/\\d{4}$")) {
    indf[[index]] <- strptime(indf[[index]], format="%m/%d/%Y", tz="UTC")
  }
  else if (stringr::str_detect(indf[[index]][1], "^\\d{4}\\d{2}\\d{2}$")) {
    indf[[index]] <- strptime(indf[[index]], format="%Y%m%d", tz="UTC")
  }
  else if (stringr::str_detect(indf[[index]][1], "^\\d{4}/\\d{2}/\\d{2}/\\d{2}$")) {
    indf[[index]] <- strptime(indf[[index]], format="%Y/%m/%d/%H", tz="UTC")
  }
  else if (stringr::str_detect(indf[[index]][1], "^\\d{10}$")) {
    # Handle Unix seconds in milliseconds
    indf[[index]] <- as.POSIXlt(indf[[index]], origin="1970-01-01", tz="UTC")
  }
  
  return(indf)
}

get_gran = function(tsdf, index=1) {
  n = length(tsdf[[index]])
  # We calculate the granularity from the time difference between the last 2 entries (sorted)
  gran = round(difftime(max(tsdf[[index]]), sort(tsdf[[index]], partial = n-1)[n-1], 
                        units = "secs"))
  
  if (gran >= 86400) {
    return("day")
  }
  else if (gran >= 3600) {
    return("hr")
  }
  else if (gran >= 60) {
    return("min")
  }
  else if (gran >= 1) {
    return("sec")
  }
  else {
    return("ms")
  }
}
