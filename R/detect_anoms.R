detect_anoms <- function(data, k = 0.49, alpha = 0.05, num_obs_per_period = NULL,
                         use_decomp = TRUE, use_esd = FALSE, one_tail = TRUE,
                         upper_tail = TRUE, verbose = FALSE) {
 # Detects anomalies in a time series using S-H-ESD.
 #
 # Args:
 #	 data: Time series to perform anomaly detection on.
 #	 k: Maximum number of anomalies that S-H-ESD will detect as a percentage of the data.
 #	 alpha: The level of statistical significance with which to accept or reject anomalies.
 #	 num_obs_per_period: Defines the number of observations in a single period, and used during seasonal decomposition.
 #	 use_decomp: Use seasonal decomposition during anomaly detection.
 #	 use_esd: Uses regular ESD instead of hybrid-ESD. Note hybrid-ESD is more statistically robust.
 #	 one_tail: If TRUE only positive or negative going anomalies are detected depending on if upper_tail is TRUE or FALSE.
 #	 upper_tail: If TRUE and one_tail is also TRUE, detect only positive going (right-tailed) anomalies. If FALSE and one_tail is TRUE, only detect negative (left-tailed) anomalies.
 #	 verbose: Additionally printing for debugging.
 # Returns:
 #   A list containing the anomalies (anoms) and decomposition components (stl).

    if(is.null(num_obs_per_period)){
        stop("must supply period length for time series decomposition")
    }

    num_obs <- nrow(data)

    # Check to make sure we have at least two periods worth of data for anomaly context
    if(num_obs < num_obs_per_period * 2){
        stop("Anom detection needs at least 2 periods worth of data")
    }

    # Check if our timestamps are posix
    posix_timestamp <- if (class(data[[1L]])[1L] == "POSIXlt") TRUE else FALSE

    # Handle NAs
    if (length(rle(is.na(c(NA,data[[2L]],NA)))$values)>3){
      stop("Data contains non-leading NAs. We suggest replacing NAs with interpolated values (see na.approx in Zoo package).")
    } else {
      data <- na.omit(data)
    }
    
    # -- Step 1: Decompose data. This returns a univarite remainder which will be used for anomaly detection. Optionally, we might NOT decompose.
    data_decomp <- stl(ts(data[[2L]], frequency = num_obs_per_period),
                       s.window = "periodic", robust = TRUE)
    
    # Remove the seasonal component, and the median of the data to create the univariate remainder
    data <- data.frame(timestamp = data[[1L]], count = (data[[2L]]-data_decomp$time.series[,"seasonal"]-median(data[[2L]])))
    
    # Store the smoothed seasonal component, plus the trend component for use in determining the "expected values" option
    data_decomp <- data.frame(timestamp=data[[1L]], count=(as.numeric(trunc(data_decomp$time.series[,"trend"]+data_decomp$time.series[,"seasonal"]))))

    if(posix_timestamp){
        data_decomp <- format_timestamp(data_decomp)
    }
    # Maximum number of outliers that S-H-ESD can detect (e.g. 49% of data)
    max_outliers <- trunc(num_obs*k)

    if(max_outliers == 0){
      stop(paste0("With longterm=TRUE, AnomalyDetection splits the data into 2 week periods by default. You have ", num_obs, " observations in a period, which is too few. Set a higher piecewise_median_period_weeks."))
    }

    func_ma <- match.fun(median)
    func_sigma <- match.fun(mad)

    ## Define values and vectors.
    n <- length(data[[2L]])
    if (posix_timestamp){
        R_idx <- as.POSIXlt(data[[1L]][1L:max_outliers], tz = "UTC")
    } else {
        R_idx <- 1L:max_outliers
    }

    num_anoms <- 0L

    # Compute test statistic until r=max_outliers values have been
    # removed from the sample.
    for (i in 1L:max_outliers){
        if(verbose) message(paste(i,"/", max_outliers,"completed"))

        if(one_tail){
            if(upper_tail){
                ares <- data[[2L]] - func_ma(data[[2L]])
            } else {
                ares <- func_ma(data[[2L]]) - data[[2L]]
            }
        } else {
            ares = abs(data[[2L]] - func_ma(data[[2L]]))
        }

        # protect against constant time series
        data_sigma <- func_sigma(data[[2L]])
        if(is.na(data_sigma) || data_sigma == 0) 
            break

        ares <- ares/data_sigma
        R <- max(ares)

        temp_max_idx <- which(ares == R)[1L]

        R_idx[i] <- data[[1L]][temp_max_idx]

        data <- data[-which(data[[1L]] == R_idx[i]), ]

        ## Compute critical value.
        if(one_tail){
            p <- 1 - alpha/(n-i+1)
        } else {
            p <- 1 - alpha/(2*(n-i+1))
        }

        t <- qt(p,(n-i-1L))
        lam <- t*(n-i) / sqrt((n-i-1+t**2)*(n-i+1))

        if(R > lam)
            num_anoms <- i
    }
    
    if(num_anoms > 0) {
      R_idx <- R_idx[1L:num_anoms]
    } else {
      R_idx = NULL
    }
      
    return(list(anoms = R_idx, stl = data_decomp))
}
