get_range <- function(dfs, index = 2, y_log = F) {
  vals <- dfs[[index]]
  if(y_log) vals <- vals[vals > 0]
  vrange = range(vals, na.rm=TRUE)
  vmin = vrange[1]
  vmax = vrange[2]
  return(c(vmin, vmax))
}

add_formatted_y <- function(yrange, y_log = FALSE, expand = TRUE, digits = 1) {
  ymin <- yrange[1]
  ymax <- yrange[2]
  
  if (expand) {
    ymax <- ymax + (ymax - ymin) * .2
  }
  
  if(abs(ymax) > 1000000) {
    divisor <- 1000000
    unit <- "M"
  }
  else if(abs(ymax) > 1000) {
    divisor <- 1000
    unit <- "k"
  }
  else {
    divisor <- 1
    unit <- ""
  }
  
  if(y_log){
    transform = "log10"
  }
  else {
    transform = "identity"
  }
  
  return (ggplot2::scale_y_continuous(breaks=seq(ymin, ymax, length.out=6), limits=c(ymin, ymax), labels=function(x) paste(round(x/divisor, digits=digits),unit,sep=""), trans = transform))
  
}

add_day_labels_datetime <- function(tsplot, breaks = 6, start = NULL, end = NULL, 
                                    days_per_line = 1) {
  if (is.null(start)) {
    start <- min(tsplot$data[[1]])
  }
  
  if (is.null(end)) {
    end <- max(tsplot$data[[1]])
  }
  
  start_breaks <- start
  attributes(start_breaks)$tzone <- "UTC"
  
  lines_start <- trunc.POSIXt(start_breaks, units = "days")
  attributes(lines_start)$tzone <- "UTC"
  
  lines_at <- seq(lines_start, end, as.difftime(days_per_line, units = "days"))
  lines_at <- lines_at[lines_at > start & lines_at < end]
  
  minor_breaks <- seq(trunc.POSIXt(start_breaks, units="days"), end, 
                      as.difftime(breaks, units = "hours"))
  minor_breaks <- minor_breaks[minor_breaks > start & minor_breaks <= end]
  
  if (start$min == 0) {
    minor_breaks <- as.POSIXct(c(start, minor_breaks))
  }
  
  outplot <- tsplot + ggplot2::scale_x_datetime(breaks = minor_breaks,
                                               labels = function(x) ifelse(as.POSIXlt(x, tz = "UTC")$hour != 0,strftime(x, format="%kh", tz="UTC"), strftime(x, format="%b %e", tz="UTC")), 
                                               expand = c(0, 0))
  
  if (length(lines_at) > 0) {
    outplot <- outplot + ggplot2::geom_vline(xintercept = as.numeric(lines_at), color = "gray60")  
  }
  
  return(outplot)
}

