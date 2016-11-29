#' Anomaly Detection Using Seasonal Hybrid ESD Test
#'
#' A technique for detecting anomalies in seasonal univariate time series where the input is a
#' series of <timestamp, count> pairs.
#' @name AnomalyDetectionTs
#' @param x Time series as a two column data frame where the first column consists of the
#' timestamps and the second column consists of the observations.
#' @param max_anoms Maximum number of anomalies that S-H-ESD will detect as a percentage of the
#' data.
#' @param direction Directionality of the anomalies to be detected. Options are:
#' \code{'pos' | 'neg' | 'both'}.
#' @param alpha The level of statistical significance with which to accept or reject anomalies.
#' @param only_last Find and report anomalies only within the last day or hr in the time series.
#' \code{NULL | 'day' | 'hr'}.
#' @param threshold Only report positive going anoms above the threshold specified. Options are:
#' \code{'None' | 'med_max' | 'p95' | 'p99'}.
#' @param e_value Add an additional column to the anoms output containing the expected value.
#' @param longterm Increase anom detection efficacy for time series that are greater than a month.
#' See Details below.
#' @param piecewise_median_period_weeks The piecewise median time window as described in Vallis, Hochenbaum, and Kejariwal (2014).
#' Defaults to 2.
#' @param plot A flag indicating if a plot with both the time series and the estimated anoms,
#' indicated by circles, should also be returned.
#' @param y_log Apply log scaling to the y-axis. This helps with viewing plots that have extremely
#' large positive anomalies relative to the rest of the data.
#' @param xlabel X-axis label to be added to the output plot.
#' @param ylabel Y-axis label to be added to the output plot.
#' @details
#' \code{longterm} This option should be set when the input time series is longer than a month.
#' The option enables the approach described in Vallis, Hochenbaum, and Kejariwal (2014).\cr\cr
#' \code{threshold} Filter all negative anomalies and those anomalies whose magnitude is smaller
#' than one of the specified thresholds which include: the median
#' of the daily max values (med_max), the 95th percentile of the daily max values (p95), and the
#' 99th percentile of the daily max values (p99).
#' @param title Title for the output plot.
#' @param verbose Enable debug messages.
#' @param na.rm Remove any NAs in timestamps.(default: FALSE) 
#' @return The returned value is a list with the following components.
#' @return \item{anoms}{Data frame containing timestamps, values, and optionally expected values.}
#' @return \item{plot}{A graphical object if plotting was requested by the user. The plot contains
#' the estimated anomalies annotated on the input time series.}
#' @return One can save \code{anoms} to a file in the following fashion:
#' \code{write.csv(<return list name>[["anoms"]], file=<filename>)}
#' @return One can save \code{plot} to a file in the following fashion:
#' \code{ggsave(<filename>, plot=<return list name>[["plot"]])}
#' @references Vallis, O., Hochenbaum, J. and Kejariwal, A., (2014) "A Novel Technique for
#' Long-Term Anomaly Detection in the Cloud", 6th USENIX, Philadelphia, PA.
#' @references Rosner, B., (May 1983), "Percentage Points for a Generalized ESD Many-Outlier Procedure"
#' , Technometrics, 25(2), pp. 165-172.
#'
#' @docType data
#' @keywords datasets
#' @name raw_data
#'
#' @examples
#' data(raw_data)
#' AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', plot=TRUE)
#' # To detect only the anomalies on the last day, run the following:
#' AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', only_last="day", plot=TRUE)
#' @seealso \code{\link{AnomalyDetectionVec}}
#' @export
#'
AnomalyDetectionTs <- function(x, max_anoms = 0.10, direction = 'pos',
                               alpha = 0.05, only_last = NULL, threshold = 'None',
                               e_value = FALSE, longterm = FALSE, piecewise_median_period_weeks = 2, plot = FALSE,
                               y_log = FALSE, xlabel = '', ylabel = 'count',
                               title = NULL, verbose=FALSE, na.rm = FALSE){

  # Check for supported inputs types
  if(!is.data.frame(x)){
    stop("data must be a single data frame.")
  } else {
    if(ncol(x) != 2 || !is.numeric(x[[2]])){
      stop("data must be a 2 column data.frame, with the first column being a set of timestamps, and the second coloumn being numeric values.")
    }
    # Format timestamps if necessary
    if (!(class(x[[1]])[1] == "POSIXlt")) {
      x <- format_timestamp(x)
    }
  }
  # Rename data frame columns if necessary
  if (any((names(x) == c("timestamp", "count")) == FALSE)) {
    colnames(x) <- c("timestamp", "count")
  }
  
  if(!is.logical(na.rm)){
    stop("na.rm must be either TRUE (T) or FALSE (F)")
  }
  
  # Deal with NAs in timestamps
  if(any(is.na(x$timestamp))){
    if(na.rm){
      x <- x[-which(is.na(x$timestamp)), ]
    } else {
      stop("timestamp contains NAs, please set na.rm to TRUE or remove the NAs manually.")
    }
  }

  # Sanity check all input parameters
  if(max_anoms > .49){
    stop(paste("max_anoms must be less than 50% of the data points (max_anoms =", round(max_anoms*length(x[[2]]), 0), " data_points =", length(x[[2]]),")."))
  } else if(max_anoms < 0){
    stop("max_anoms must be positive.")
  } else if(max_anoms == 0){
    warning("0 max_anoms results in max_outliers being 0.")
  }
  if(!direction %in% c('pos', 'neg', 'both')){
    stop("direction options are: pos | neg | both.")
  }
  if(!(0.01 <= alpha || alpha <= 0.1)){
    if(verbose) message("Warning: alpha is the statistical signifigance, and is usually between 0.01 and 0.1")
  }
  if(!is.null(only_last) && !only_last %in% c('day','hr')){
    stop("only_last must be either 'day' or 'hr'")
  }
  if(!threshold %in% c('None','med_max','p95','p99')){
    stop("threshold options are: None | med_max | p95 | p99.")
  }
  if(!is.logical(e_value)){
    stop("e_value must be either TRUE (T) or FALSE (F)")
  }
  if(!is.logical(longterm)){
    stop("longterm must be either TRUE (T) or FALSE (F)")
  }
  if(piecewise_median_period_weeks < 2){
    stop("piecewise_median_period_weeks must be at greater than 2 weeks")
  }
  if(!is.logical(plot)){
    stop("plot must be either TRUE (T) or FALSE (F)")
  }
  if(!is.logical(y_log)){
    stop("y_log must be either TRUE (T) or FALSE (F)")
  }
  if(!is.character(xlabel)){
    stop("xlabel must be a string")
  }
  if(!is.character(ylabel)){
    stop("ylabel must be a string")
  }
  if(!is.character(title) && !is.null(title)){
    stop("title must be a string")
  }
  if(is.null(title)){
    title <- ""
  } else {
    title <- paste(title, " : ", sep="")
  }

  # -- Main analysis: Perform S-H-ESD

  # Derive number of observations in a single day.
  # Although we derive this in S-H-ESD, we also need it to be minutley later on so we do it here first.
  gran <- get_gran(x, 1)

  if(gran == "day"){
    num_days_per_line <- 7
    if(is.character(only_last) &&  only_last == 'hr'){
      only_last <- 'day'
    }
  } else {
    num_days_per_line <- 1
  }

  # Aggregate data to minutely if secondly
  if(gran == "sec"){
    x <- format_timestamp(aggregate(x[2], format(x[1], "%Y-%m-%d %H:%M:00"), eval(parse(text="sum"))))
    gran <- "min"
  }

  period = switch(gran,
                  min = 1440,
                  hr = 24,
                  # if the data is daily, then we need to bump the period to weekly to get multiple examples
                  day = 7)
  num_obs <- length(x[[2]])

  if(max_anoms < 1/num_obs){
    max_anoms <- 1/num_obs
  }

  # -- Setup for longterm time series

  # If longterm is enabled, break the data into subset data frames and store in all_data
  if(longterm){
    # Pre-allocate list with size equal to the number of piecewise_median_period_weeks chunks in x + any left over chunk
    # handle edge cases for daily and single column data period lengths
    if(gran == "day"){
      # STL needs 2*period + 1 observations
      num_obs_in_period <- period*piecewise_median_period_weeks + 1
      num_days_in_period <- (7*piecewise_median_period_weeks) + 1
    } else {
      num_obs_in_period <- period*7*piecewise_median_period_weeks
      num_days_in_period <- (7*piecewise_median_period_weeks)
    }

    # Store last date in time series
    last_date <- x[[1]][num_obs]

    all_data <- vector(mode="list", length=ceiling(length(x[[1]])/(num_obs_in_period)))
    # Subset x into piecewise_median_period_weeks chunks
    for(j in seq(1,length(x[[1]]), by=num_obs_in_period)){
      start_date <- x[[1]][j]
      end_date <- min(start_date + lubridate::days(num_days_in_period), x[[1]][length(x[[1]])])
      # if there is at least 14 days left, subset it, otherwise subset last_date - 14days
      if(difftime(end_date, start_date, units = "days") == as.difftime(num_days_in_period, units="days")){
        all_data[[ceiling(j/(num_obs_in_period))]] <- subset(x, x[[1]] >= start_date & x[[1]] < end_date)
      }else{
        all_data[[ceiling(j/(num_obs_in_period))]] <- subset(x, x[[1]] > (last_date-lubridate::days(num_days_in_period)) & x[[1]] <= last_date)
      }
    }
  }else{
    # If longterm is not enabled, then just overwrite all_data list with x as the only item
    all_data <- list(x)
  }

  # Create empty data frames to store all anoms and seasonal+trend component from decomposition
  all_anoms <- data.frame(timestamp=numeric(0), count=numeric(0))
  seasonal_plus_trend <- data.frame(timestamp=numeric(0), count=numeric(0))

  # Detect anomalies on all data (either entire data in one-pass, or in 2 week blocks if longterm=TRUE)
  for(i in 1:length(all_data)) {

    anomaly_direction = switch(direction,
                               "pos" = data.frame(one_tail=TRUE, upper_tail=TRUE), # upper-tail only (positive going anomalies)
                               "neg" = data.frame(one_tail=TRUE, upper_tail=FALSE), # lower-tail only (negative going anomalies)
                               "both" = data.frame(one_tail=FALSE, upper_tail=TRUE)) # Both tails. Tail direction is not actually used.

    # detect_anoms actually performs the anomaly detection and returns the results in a list containing the anomalies
    # as well as the decomposed components of the time series for further analysis.
    s_h_esd_timestamps <- detect_anoms(all_data[[i]], k=max_anoms, alpha=alpha, num_obs_per_period=period, use_decomp=TRUE, use_esd=FALSE,
                                       one_tail=anomaly_direction$one_tail, upper_tail=anomaly_direction$upper_tail, verbose=verbose)

    # store decomposed components in local variable and overwrite s_h_esd_timestamps to contain only the anom timestamps
    data_decomp <- s_h_esd_timestamps$stl
    s_h_esd_timestamps <- s_h_esd_timestamps$anoms

    # -- Step 3: Use detected anomaly timestamps to extract the actual anomalies (timestamp and value) from the data
    if(!is.null(s_h_esd_timestamps)){
      anoms <- subset(all_data[[i]], (all_data[[i]][[1]] %in% s_h_esd_timestamps))
    } else {
      anoms <- data.frame(timestamp=numeric(0), count=numeric(0))
    }

    # Filter the anomalies using one of the thresholding functions if applicable
    if(threshold != "None"){
      # Calculate daily max values
      periodic_maxs <- tapply(x[[2]],as.Date(x[[1]]),FUN=max)

      # Calculate the threshold set by the user
      if(threshold == 'med_max'){
        thresh <- median(periodic_maxs)
      }else if (threshold == 'p95'){
        thresh <- quantile(periodic_maxs, .95)
      }else if (threshold == 'p99'){
        thresh <- quantile(periodic_maxs, .99)
      }
      # Remove any anoms below the threshold
      anoms <- subset(anoms, anoms[[2]] >= thresh)
    }
    all_anoms <- rbind(all_anoms, anoms)
    seasonal_plus_trend <- rbind(seasonal_plus_trend, data_decomp)
  }

  # Cleanup potential duplicates
  all_anoms <- all_anoms[!duplicated(all_anoms[[1]]), ]
  seasonal_plus_trend <- seasonal_plus_trend[!duplicated(seasonal_plus_trend[[1]]), ]

  # -- If only_last was set by the user, create subset of the data that represent the most recent day
  if(!is.null(only_last)){
    start_date <- x[[1]][num_obs]-lubridate::days(7)
    start_anoms <- x[[1]][num_obs]-lubridate::days(1)
    if(gran == "day"){
      #TODO: This might be better set up top at the gran check
      breaks <- 3*12
      num_days_per_line <- 7
    } else {
      if(only_last == 'day'){
        breaks <- 12
      }else{
        # We need to change start_date and start_anoms for the hourly only_last option
        start_date <- lubridate::floor_date(x[[1]][num_obs]-lubridate::days(2), "day")
        start_anoms <- x[[1]][num_obs]-lubridate::hours(1)
        breaks <- 3
      }
    }

    # subset the last days worth of data
    x_subset_single_day <- subset(x, (x[[1]] > start_anoms))
    # When plotting anoms for the last day only we only show the previous weeks data
    x_subset_week <- subset(x, ((x[[1]] <= start_anoms) & (x[[1]] > start_date)))
    all_anoms <- subset(all_anoms, all_anoms[[1]] >= x_subset_single_day[[1]][1])
    num_obs <- length(x_subset_single_day[[2]])
  }

  # Calculate number of anomalies as a percentage
  anom_pct <- (length(all_anoms[[2]]) / num_obs) * 100

  # If there are no anoms, then let's exit
  if(anom_pct == 0){
    if(verbose) message("No anomalies detected.")
    return (list("anoms"=data.frame(), "plot"=plot.new()))
  }

  if(plot){
    # -- Build title for plots utilizing parameters set by user
    plot_title <-  paste(title, round(anom_pct, digits=2), "% Anomalies (alpha=", alpha, ", direction=", direction,")", sep="")
    if(longterm){
      plot_title <- paste(plot_title, ", longterm=T", sep="")
    }

    # -- Plot raw time series data
    color_name <- paste("\"", title, "\"", sep="")
    alpha <- 0.8
    if(!is.null(only_last)){
      xgraph <- ggplot2::ggplot(x_subset_week, ggplot2::aes_string(x="timestamp", y="count")) + ggplot2::theme_bw() + ggplot2::theme(panel.grid.major = ggplot2::element_blank(), panel.grid.minor = ggplot2::element_blank(), text=ggplot2::element_text(size = 14))
      xgraph <- xgraph + ggplot2::geom_line(data=x_subset_week, ggplot2::aes_string(colour=color_name), alpha=alpha*.33) + ggplot2::geom_line(data=x_subset_single_day, ggplot2::aes_string(color=color_name), alpha=alpha)
      week_rng = get_range(x_subset_week, index=2, y_log=y_log)
      day_rng = get_range(x_subset_single_day, index=2, y_log=y_log)
      yrange = c(min(week_rng[1],day_rng[1]), max(week_rng[2],day_rng[2]))
      xgraph <- add_day_labels_datetime(xgraph, breaks=breaks, start=as.POSIXlt(min(x_subset_week[[1]]), tz="UTC"), end=as.POSIXlt(max(x_subset_single_day[[1]]), tz="UTC"), days_per_line=num_days_per_line)
      xgraph <- xgraph + ggplot2::labs(x=xlabel, y=ylabel, title=plot_title)
    }else{
      xgraph <- ggplot2::ggplot(x, ggplot2::aes_string(x="timestamp", y="count")) + ggplot2::theme_bw() + ggplot2::theme(panel.grid.major = ggplot2::element_line(colour = "gray60"), panel.grid.major.y = ggplot2::element_blank(), panel.grid.minor = ggplot2::element_blank(), text=ggplot2::element_text(size = 14))
      xgraph <- xgraph + ggplot2::geom_line(data=x, ggplot2::aes_string(colour=color_name), alpha=alpha)
      yrange <- get_range(x, index=2, y_log=y_log)
      xgraph <- xgraph + ggplot2::scale_x_datetime(labels=function(x) ifelse(as.POSIXlt(x, tz="UTC")$hour != 0,strftime(x, format="%kh", tz="UTC"), strftime(x, format="%b %e", tz="UTC")),
                                                  expand=c(0,0))
      xgraph <- xgraph + ggplot2::labs(x=xlabel, y=ylabel, title=plot_title)
    }

    # Add anoms to the plot as circles.
    # We add zzz_ to the start of the name to ensure that the anoms are listed after the data sets.
    xgraph <- xgraph + ggplot2::geom_point(data=all_anoms, ggplot2::aes_string(color=paste("\"zzz_",title,"\"",sep="")), size = 3, shape = 1)

    # Hide legend
    xgraph <- xgraph + ggplot2::theme(legend.position="none")

    # Use log scaling if set by user
    xgraph <- xgraph + add_formatted_y(yrange, y_log=y_log)

  }

  # Fix to make sure date-time is correct and that we retain hms at midnight
  all_anoms[[1]] <- format(all_anoms[[1]], format="%Y-%m-%d %H:%M:%S")
  
  # Store expected values if set by user
  if(e_value) {
    anoms <- data.frame(timestamp=all_anoms[[1]], anoms=all_anoms[[2]], 
                        expected_value=subset(seasonal_plus_trend[[2]], as.POSIXlt(seasonal_plus_trend[[1]], tz="UTC") %in% all_anoms[[1]]),
                        stringsAsFactors=FALSE)
  } else {
    anoms <- data.frame(timestamp=all_anoms[[1]], anoms=all_anoms[[2]], stringsAsFactors=FALSE)
  }

  # Make sure we're still a valid POSIXlt datetime.
  # TODO: Make sure we keep original datetime format and timezone.
  anoms$timestamp <- as.POSIXlt(anoms$timestamp, tz="UTC")

  # Lastly, return anoms and optionally the plot if requested by the user
  if(plot){
    return (list(anoms = anoms, plot = xgraph))
  } else {
    return (list(anoms = anoms, plot = plot.new()))
  }
}
