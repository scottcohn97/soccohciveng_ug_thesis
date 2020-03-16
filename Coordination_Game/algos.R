# ========================================================================== #
# Basic algos
# ========================================================================== #

# These are the algos included into the tournament anyway.

# -------------------------------------------------------------------------- #
# AllC
# -------------------------------------------------------------------------- #

# Always cooperates.

allc = function(p, o, n = 2000) TRUE


# -------------------------------------------------------------------------- #
# AllD
# -------------------------------------------------------------------------- #

# Always defects.

alld = function(p, o, n = 2000) FALSE


# -------------------------------------------------------------------------- #
# Alternate
# -------------------------------------------------------------------------- #

# Randomly cooperate or defect (prob = 1/2) on the 1st round then alternates
# regardless of what the opponent does.

alt = function(p, o, n = 2000) {
  ifelse(length(p) == 0, sample(c(T, F), 1), !tail(p, 1))
}


# -------------------------------------------------------------------------- #
# Grudger
# -------------------------------------------------------------------------- #

# Cooperates until the opponent defects and then defects forever.

grudger = function(p, o, n = 2000) {
  all(o)
}


# -------------------------------------------------------------------------- #
# Random
# -------------------------------------------------------------------------- #

# This strategy plays randomly (prob = 1/2) disregarding the history of play.

rand = function(p, o, n = 2000) {
  sample(c(TRUE, FALSE), 1)
}


# -------------------------------------------------------------------------- #
# Detective
# -------------------------------------------------------------------------- #

# Cooperates, defects, cooperates and cooperates again. If the opponent
# doesn't relatilates in the 3rd round, defects all the time; otherwise plays
# Tit-for-Tat.

detect = function(p, o, n = 2000) {
  r <- length(p) + 1
  if (r < 5) {
    res <- as.logical(r != 2)
  } else {
    res <- ifelse(o[3], FALSE, o[r - 1])
  }
  res
}


# -------------------------------------------------------------------------- #
# Tit-For-Tat
# -------------------------------------------------------------------------- #

# Begins by cooperating and then simply repeats the last moves made by the
# opponent.

tft = function(p, o, n = 2000) {
  ifelse(length(p) == 0, TRUE, tail(o, 1))
}


# -------------------------------------------------------------------------- #
# Generous Tit-For-Tat
# -------------------------------------------------------------------------- #

# Same as TFT but 'forgives' defections in 1/3 of cases.

gtft = function(p, o, n = 2000) {
  res <- TRUE
  if (length(p) > 0 && !tail(o, 1)) res <- sample(c(F, T), 1, 2:1) 
  res
}


# -------------------------------------------------------------------------- #
# Tit-For-Two-Tats
# -------------------------------------------------------------------------- #

# Like TFT but only retaliates after two defections rather than one.

tf2t = function(p, o, n = 2000) {
  res <- TRUE
  if (length(p) > 1) res <- !all(!tail(o, 2))
  res
}


# -------------------------------------------------------------------------- #
# Win-Stay-Lose-Shift
# -------------------------------------------------------------------------- #

# Cooperates first then, if the opponent cooperated on the last round, repeat
# last move; otherwise, switch.

wsls = function(p, o, n = 2000) {
  r <- length(p) + 1
  if (r == 1) {
    res <- TRUE
  } else {
    res <- ifelse(tail(o, 1), tail(p, 1), !tail(p, 1))
  }
  res
}


# -------------------------------------------------------------------------- #
# Zero-Determinant GTFT 2
# -------------------------------------------------------------------------- #

# Always collaborates if the opponent did. When the opponent defects, it
# collaborates with a probability of 1/8 if it has collaborated on the last
# round or with a probability of 1/4 otherwise.

zdgtft2 = function(p, o, n = 2000) {
  if (length(p) == 0) {
    res <- TRUE
  } else {
    if (tail(o, 1)) {
      res <- TRUE
    } else {
      z <- ifelse(tail(p, 1), 1/8, 1/4)
      res <- sample(c(T, F), 1, c(z, 1 - z))
    }
  }
  res
}


# -------------------------------------------------------------------------- #
# Extort 2
# -------------------------------------------------------------------------- #

# If the opponent collarorated on the last round, it will collaborate with a
# probability of 8/9 if it has also collaborated and 1/3 otherwise. If the
# opponent defected, it will collaborate with a probability of 1/2 if it
# collaborated and 0 otherwise.

extort2 = function(p, o, n = 2000) {
  if (length(p) == 0) {
    res <- TRUE
  } else {
    if (tail(o, 1)) {
      z <- ifelse(tail(p, 1), 8/9, 1/3)
    } else {
      z <- ifelse(tail(p, 1), 1/2, 0)
    }
    res <- sample(c(TRUE, FALSE), 1, prob = c(z, 1 - z))
  }
  res
}