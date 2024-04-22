# Utility functions
library(ggplot2)
library(dplyr)
library(crqa)

# Compute recurrence rate from recurrence plot matrix.
# Needed, e.g., for the joint recurrence plot.
recurrence_rate <- function(rp) {
  return(sum(rp) / length(rp) * 100)
}

# Function to compute RQA of one time series
rqa <- function(ts, delay, embed, radius) {
  rqa_ts <-  crqa(ts, ts,
                  delay, embed, radius,
                  rescale     = 0,           # 0 (none) | 1 (mean distance) | 2 (max distance) | 3 (min distance) | 4 (euclidean distance)
                  normalize   = 2,           # 0 (none) | 1 (unit interval) | 2 (z-score)
                  mindiagline = 2,           # min recurrent points for diagonal lines
                  minvertline = 2,           # min recurrent points for vertical lines
                  tw          = 1,           # Theiler window: 0 (incl LOI) | 1 (excl LOI)
                  whiteline   = TRUE,        # calculate empty vertical lines or not
                  recpt       = FALSE,       # calculate measures directly from RP or not
                  side        = "both",      # base measures on "upper" or "lower" triangle, or "both"
                  method      = "rqa",       # "rqa" | "crqa" | "mdcrqa"
                  metric      = "euclidean", # distance metric: "euclidean" | "maximum" | "minkowski" | ...
                  datatype    = "continuous")
  
  return(rqa_ts)
}

# Function to compute MdRQA of one time series
mdrqa <- function(ts, delay, embed, radius) {
  rqa_ts <-  crqa(ts, ts,
                  delay, embed, radius,
                  rescale     = 0,           # 0 (none) | 1 (mean distance) | 2 (max distance) | 3 (min distance) | 4 (euclidean distance)
                  normalize   = 2,           # 0 (none) | 1 (unit interval) | 2 (z-score)
                  mindiagline = 2,           # min recurrent points for diagonal lines
                  minvertline = 2,           # min recurrent points for vertical lines
                  tw          = 1,           # Theiler window: 0 (incl LOI) | 1 (excl LOI)
                  whiteline   = TRUE,        # calculate empty vertical lines or not
                  recpt       = FALSE,       # calculate measures directly from RP or not
                  side        = "both",      # base measures on "upper" or "lower" triangle, or "both"
                  method      = "mdcrqa",    # "rqa" | "crqa" | "mdcrqa"
                  metric      = "euclidean", # distance metric: "euclidean" | "maximum" | "minkowski" | ...
                  datatype    = "continuous")
  return(rqa_ts)
}

# Function to compute the recurrence rate of the lagged joint recurrence
# plot at different lags, given two recurrence plots. The lags are from
# -window_size to +window_size, which has the default value 10.
lagged_joint_rr <- function(rp_1, rp_2, window_size = 10) {
  lagged_RR <- data.frame()
  for (w in -window_size:window_size) {
    # This constructs a lagged joint recurrence plot with lag w
    if (w < 0) {
      jrp <- rp_1[(1 - w):(dim(rp_1)[1]), (1 - w):(dim(rp_1)[1])] *
        rp_2[(1):(dim(rp_2)[1] + w), (1):(dim(rp_2)[1] + w)]
    } else if (w == 0) {
      jrp <- rp_1[(1):(dim(rp_1)[1]), (1):(dim(rp_1)[1])] *
        rp_2[(1):(dim(rp_2)[1]), (1):(dim(rp_2)[1])]
    } else {
      jrp <- rp_1[(1):(dim(rp_1)[1] - w), (1):(dim(rp_1)[1] - w)] *
        rp_2[(1 + w):(dim(rp_2)[1]), (1 + w):(dim(rp_2)[1])]
    }
    lagged_RR <- rbind(
      lagged_RR,
      data.frame(
        w = w,
        RR = (sum(jrp) / (dim(jrp)[1]^2)) * 100)
    )
  }
  return(lagged_RR)
}


# Dan Mønster, July 2023

# A ggplot2-based function to produce a recurrence plot from a
# matrix. Much faster than using graphics::image() and nicer than
# crqa::plotRP().
plot_rp <- function(data_matrix,
                    plot_title = "",
                    points = FALSE,
                    flip_y = FALSE) {
  # If data_matrix is a sparse matrix from the Matrix package,
  # convert it to a regular matrix first.
  if ("dgCMatrix" %in% class(data_matrix)) {
    data_matrix <- as.matrix(data_matrix)
  } else if ("dgRMatrix" %in% class(data_matrix)) {
    data_matrix <- as.matrix(data_matrix)
  } else if ("ngCMatrix" %in% class(data_matrix)) {
    data_matrix <- as.matrix(data_matrix)
  }
  data_dims <- dim(data_matrix)
  if (data_dims[1] != data_dims[2]) {
    stop("Matrix is not square.
           Number of rows should be equal to number of columns.")
  }
  
  data_df <- as.data.frame.table(data_matrix, responseName = "value") %>%
    mutate(value = as.logical(value)) %>%
    filter(value == TRUE) %>%
    mutate_if(is.factor, as.integer)
  
  RP <- ggplot(data_df, aes(x = Var1, y = Var2, fill = value)) +
    scale_fill_discrete(type = c("0" = "white", "1" = "black")) +
    coord_fixed(ratio = 1) +
    xlab("") +
    ylab("") +
    labs(title = plot_title) +
    expand_limits(x = 1, y = 1) +
    expand_limits(x = data_dims[1], y = data_dims[2]) +
    theme_classic() +
    theme(legend.position = "none")
  
  if (flip_y) {
    RP <- RP + scale_y_reverse()
  }
  if (points) {
    RP <- RP + geom_point(size = 0.5, stroke = 0, shape = ".")
  } else {
    RP <- RP + geom_tile()
  }
  return(RP)
}
