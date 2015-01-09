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
  
    if(is.null(num_obs_per_period)) {
        stop("must supply period length for time series decomposition")
    }
    
    num_obs <- nrow(data)

    # Check to make sure we have at least two periods worth of data for anomaly context
    if(num_obs < num_obs_per_period * 2) {
        stop("Anom detection needs at least 2 periods worth of data")
    }

    # Check if our timestamps are posix
    posix_timestamp <- if (class(data[[1]])[1] == "POSIXlt") TRUE else FALSE

    # -- Step 1: Decompose data. This returns a univarite remainder which will be used for anomaly detection. Optionally, we might NOT decompose.
    data_decomp <- stl(ts(data[[2]], frequency=num_obs_per_period), s.window="periodic", robust=TRUE)
    
    data <- data.frame(timestamp=data[[1]], count=(data[[2]]-data_decomp$time.series[,"seasonal"]-median(data[[2]])))
    data_decomp <- data.frame(timestamp=data[[1]], count=(as.numeric(trunc(data_decomp$time.series[,"trend"]+data_decomp$time.series[,"seasonal"]))))
    if(posix_timestamp){
        data_decomp <- format_timestamp(data_decomp)
    }
    # Maximum number of outliers that S-H-ESD can detect (i.e. 49% of data)
    max_outliers <- trunc(num_obs*k)

    dataNAs <- sum(is.na(data[[2]]))
    if (dataNAs > 0) {
        if (any(is.na(data[[2]][-(1:dataNAs)]))) 
            stop("Data contains non-leading NAs")
        else
            data[[2]][1:dataNAs] <- 1
    }

    func_ma <- match.fun(median)
    func_sigma <- match.fun(mad)

    ## Define values and vectors.
    n <- length(data[[2]])
    lam <- c(1:max_outliers)
    R <- c(1:max_outliers)
    if (posix_timestamp) {
        R_idx <- as.POSIXlt(data[[1]][1:max_outliers], tz = "UTC")
    } else {
        R_idx <- c(1:max_outliers)
    }

    num_anoms <- 0

    # Compute test statistic until r=max_outliers values have been
    # removed from the sample.
    for (i in 1:max_outliers){
        if(verbose) print(paste(i,"/", max_outliers,"completed"))

        if(one_tail){
            if(upper_tail){
                ares <- data[[2]] - func_ma(data[[2]])
            } else {
                ares <- func_ma(data[[2]]) - data[[2]]
            }
        } else {
            ares = abs(data[[2]] - func_ma(data[[2]]))
        }

        ares <- ares/func_sigma(data[[2]])
        R[i] <- max(ares)

        temp_max_idx <- which(ares == max(ares))

        if(length(temp_max_idx) > 1)
            temp_max_idx <- temp_max_idx[1]

        R_idx[i] <- data[[1]][temp_max_idx]

        data <- data[-which(data[[1]] == R_idx[i]), ]   

        ## Compute critical value.
        if(one_tail){
            p <- 1 - alpha/(n-i+1)
        } else {
            p <- 1 - alpha/(2*(n-i+1))
        }

        t <- qt(p,(n-i-1))
        lam[i] <- t*(n-i) / sqrt((n-i-1+t**2)*(n-i+1))

        if(R[i] > lam[i])
            num_anoms <- i
    }

    return(list(anoms = R_idx[1:num_anoms], stl = data_decomp))
}
