#' Anomaly Detection Using Seasonal Hybrid ESD Test 
#'
#' A technique for detecting anomalies in seasonal univariate time series where the input is a 
#' series of observations.
#' @name AnomalyDetectionVec
#' @param x Time series as a column data frame, list, or vector, where the column consists of 
#' the observations.
#' @param max_anoms Maximum number of anomalies that S-H-ESD will detect as a percentage of the
#' data.
#' @param direction Directionality of the anomalies to be detected. Options are: 
#' \code{'pos' | 'neg' | 'both'}.
#' @param alpha The level of statistical significance with which to accept or reject anomalies.  
#' @param period Defines the number of observations in a single period, and used during seasonal 
#' decomposition.
#' @param only_last Find and report anomalies only within the last period in the time series.
#' @param threshold Only report positive going anoms above the threshold specified. Options are: 
#' \code{'None' | 'med_max' | 'p95' | 'p99'}.
#' @param e_value Add an additional column to the anoms output containing the expected value.
#' @param longterm_period Defines the number of observations for which the trend can be considered 
#' flat. The value should be an integer multiple of the number of observations in a single period. 
#' This increases anom detection efficacy for time series that are greater than a month.
#' @param plot A flag indicating if a plot with both the time series and the estimated anoms,
#' indicated by circles, should also be returned.
#' @param y_log Apply log scaling to the y-axis. This helps with viewing plots that have extremely
#' large positive anomalies relative to the rest of the data.
#' @param xlabel X-axis label to be added to the output plot.
#' @param ylabel Y-axis label to be added to the output plot.
#' @details
#' \code{longterm_period} This option should be set when the input time series is longer than a month.
#' The option enables the approach described in Vallis, Hochenbaum, and Kejariwal (2014).\cr\cr
#' \code{threshold} Filter all negative anomalies and those anomalies whose magnitude is smaller 
#' than one of the specified thresholds which include: the median 
#' of the daily max values (med_max), the 95th percentile of the daily max values (p95), and the 
#' 99th percentile of the daily max values (p99).
#' @param title Title for the output plot.
#' @param verbose Enable debug messages 
#' @return The returned value is a list with the following components.
#' @return \item{anoms}{Data frame containing index, values, and optionally expected values.}
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
#' @examples
#' data(raw_data)
#' AnomalyDetectionVec(raw_data[,2], max_anoms=0.02, period=1440, direction='both', plot=TRUE)
#' # To detect only the anomalies in the last period, run the following:
#' AnomalyDetectionVec(raw_data[,2], max_anoms=0.02, period=1440, direction='both', 
#' only_last=TRUE, plot=TRUE)
#' @seealso \code{\link{AnomalyDetectionTs}}
#' @export
AnomalyDetectionVec = function(x, max_anoms=0.10, direction='pos', 
                               alpha=0.05, period=NULL, only_last=F, 
                               threshold='None', e_value=F, longterm_period=NULL, 
                               plot=F, y_log=F, xlabel='', ylabel='count', 
                               title=NULL, verbose=FALSE){
  
  # Check for supported inputs types and add timestamps
  if(is.data.frame(x) && ncol(x) == 1 && is.numeric(x[[1]])){
    x <- data.frame(timestamp=c(1:length(x[[1]])), count=x[[1]])
  } else if(is.vector(x) || is.list(x) && is.numeric(x)) {
    x <- data.frame(timestamp=c(1:length(x)), count=x)
  } else {
    stop("data must be a single data frame, list, or vector that holds numeric values.")
  }
  
  # Sanity check all input parameterss
  if(max_anoms > .49){
    stop(paste("max_anoms must be less than 50% of the data points (max_anoms =", round(max_anoms*length(x[[2]]), 0), " data_points =", length(x[[2]]),")."))
  }
  if(!direction %in% c('pos', 'neg', 'both')){
    stop("direction options are: pos | neg | both.")
  }
  if(!(0.01 <= alpha || alpha <= 0.1)){
    if(verbose) message("Warning: alpha is the statistical signifigance, and is usually between 0.01 and 0.1")
  }
  if(is.null(period)){
    stop("Period must be set to the number of data points in a single period")
  }
  if(!is.logical(only_last)){
    stop("only_last must be either TRUE (T) or FALSE (F)")
  }
  if(!threshold %in% c('None', 'med_max', 'p95', 'p99')){
    stop("threshold options are: None | med_max | p95 | p99.") 
  }
  if(!is.logical(e_value)){
    stop("e_value must be either TRUE (T) or FALSE (F)")
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
  
  num_obs <- length(x[[2]])
  
  if(max_anoms < 1/num_obs){
    max_anoms <- 1/num_obs
  }
  
  # -- Setup for longterm time series
  
  # If longterm is enabled, break the data into subset data frames and store in all_data,
  if(!is.null(longterm_period)){
    all_data <- vector(mode="list", length=ceiling(length(x[[1]])/(longterm_period))) 
    # Subset x into two week chunks
    for(j in seq(1,length(x[[1]]), by=longterm_period)){
      start_index <- x[[1]][j]
      end_index <- min((start_index + longterm_period - 1), num_obs)
      # if there is at least longterm_period left, subset it, otherwise subset last_index - longterm_period
      if((end_index - start_index + 1) == longterm_period){
        all_data[[ceiling(j/(longterm_period))]] <- subset(x, x[[1]] >= start_index & x[[1]] <= end_index)
      }else{
        all_data[[ceiling(j/(longterm_period))]] <- subset(x, x[[1]] > (num_obs-longterm_period) & x[[1]] <= num_obs)
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
      if(!is.null(longterm_period)){
        periodic_maxs <- tapply(all_data[[i]][[2]], c(0:(longterm_period-1))%/%period, FUN=max)
      }else{
        periodic_maxs <- tapply(all_data[[i]][[2]], c(0:(num_obs-1))%/%period, FUN=max)
      }
      
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
  
  # -- If only_last was set by the user, create subset of the data that represent the most recent period
  if(only_last){
    x_subset_single_period <- data.frame(timestamp=x[[1]][(num_obs-period+1):num_obs], count=x[[2]][(num_obs-period+1):num_obs])
    # Let's try and show 7 periods prior
    past_obs <- period*7
    # If we don't have that much data, then show what we have - the last period
    if(num_obs < past_obs){
      past_obs <- num_obs-period
    }
    
    # When plotting anoms for the last period only we only show the previous 7 periods of data
    x_subset_previous <- data.frame(timestamp=x[[1]][(num_obs-past_obs+1):(num_obs-period+1)], count=x[[2]][(num_obs-past_obs+1):(num_obs-period+1)])
    
    all_anoms <- subset(all_anoms, all_anoms[[1]] >= x_subset_single_period[[1]][1])
    num_obs <- length(x_subset_single_period[[2]])
  }
  
  # Calculate number of anomalies as a percentage
  anom_pct <- (length(all_anoms[[2]]) / num_obs) * 100
  
  # If there are no anoms, then let's exit
  if(anom_pct == 0){
    if(verbose) message("No anomalies detected.")
    return (list("anoms"=data.frame(), "plot"=NULL))
  }
  
  if(plot){
    # -- Build title for plots utilizing parameters set by user
    plot_title <-  paste(title, round(anom_pct, digits=2), "% Anomalies (alpha=", alpha, ", direction=", direction,")", sep="")
    if(!is.null(longterm_period)){
      plot_title <- paste(plot_title, ", longterm=T", sep="")
    }
    
    # -- Plot raw time series data
    color_name <- paste("\"", title, "\"", sep="")
    alpha <- 0.8
    if(only_last){    
      all_data <- rbind(x_subset_previous, x_subset_single_period)
      lines_at <- seq(1, length(all_data[[2]]), period)+min(all_data[[1]])
      xgraph <- ggplot2::ggplot(all_data, ggplot2::aes_string(x="timestamp", y="count")) + ggplot2::theme_bw() + ggplot2::theme(panel.grid.major = ggplot2::element_blank(), panel.grid.minor = ggplot2::element_blank(), text=ggplot2::element_text(size = 14))
      xgraph <- xgraph + ggplot2::geom_line(data=x_subset_previous, ggplot2::aes_string(colour=color_name), alpha=alpha*.33) + ggplot2::geom_line(data=x_subset_single_period, ggplot2::aes_string(color=color_name), alpha=alpha)    
      yrange <- get_range(all_data, index=2, y_log=y_log)
      xgraph <- xgraph + ggplot2::scale_x_continuous(breaks=lines_at, expand=c(0,0))
      xgraph <- xgraph + ggplot2::geom_vline(xintercept=lines_at, color="gray60")
      xgraph <- xgraph + ggplot2::labs(x=xlabel, y=ylabel, title=plot_title)    
    }else{
      num_periods <- num_obs/period
      lines_at <- seq(1, num_obs, period)

      # check to see that we don't have too many breaks
      inc <- 2
      while(num_periods > 14){
        num_periods <- num_obs/(period*inc)
        lines_at <- seq(1, num_obs, period*inc)
        inc <- inc + 1
      }
      xgraph <- ggplot2::ggplot(x, ggplot2::aes_string(x="timestamp", y="count")) + ggplot2::theme_bw() + ggplot2::theme(panel.grid.major = ggplot2::element_blank(), panel.grid.minor = ggplot2::element_blank(), text=ggplot2::element_text(size = 14))
      xgraph <- xgraph + ggplot2::geom_line(data=x, ggplot2::aes_string(colour=color_name), alpha=alpha)
      yrange <- get_range(x, index=2, y_log=y_log)
      xgraph <- xgraph + ggplot2::scale_x_continuous(breaks=lines_at, expand=c(0,0))
      xgraph <- xgraph + ggplot2::geom_vline(xintercept=lines_at, color="gray60")
      xgraph <- xgraph + ggplot2::labs(x=xlabel, y=ylabel, title=plot_title)
    }
    
    # Add anoms to the plot as circles.
    # We add zzz_ to the start of the name to ensure that the anoms are listed after the data sets.
    xgraph <- xgraph + ggplot2::geom_point(data=all_anoms, ggplot2::aes_string(color=paste("\"zzz_",title,"\"",sep="")), size = 3, shape = 1) 
    
    # Hide legend and timestamps
    xgraph <- xgraph + ggplot2::theme(axis.text.x=ggplot2::element_blank()) + ggplot2::theme(legend.position="none") 
    
    # Use log scaling if set by user
    xgraph <- xgraph + add_formatted_y(yrange, y_log=y_log)
  }
  
  # Store expected values if set by user
  if(e_value) {
    anoms <- data.frame(index=all_anoms[[1]], anoms=all_anoms[[2]], expected_value=subset(seasonal_plus_trend[[2]], seasonal_plus_trend[[1]] %in% all_anoms[[1]]))  
  } else {
    anoms <- data.frame(index=all_anoms[[1]], anoms=all_anoms[[2]])
  }
  
  # Lastly, return anoms and optionally the plot if requested by the user
  if(plot){
    return (list(anoms = anoms, plot = xgraph))
  } else {
    return (list(anoms = anoms, plot = NULL))
  }
}
