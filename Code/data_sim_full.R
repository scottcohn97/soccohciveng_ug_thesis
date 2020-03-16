# ----------------------
# Simulated Data
# Scott Cohn
# Mar 16, 2020
# ----------------------

# !! Code 1 random session, run it MC-style n times
# This file essentially represents 1 experimental session

library(tidyverse)
library(purrr)

set.seed(1)


# Init -- ID Table
partID <- 1:8
group <- c("A", "A", "A", "A", "B", "B", "B", "B")
Strategies <- c("allc", "alld", "alt", "grudger", "rand", "detect", "tft", "tf2t", "wsls")

ID <- tibble(partID, group)
ID[["strategy"]] <- sample(Strategies, size = nrow(ID), replace = TRUE) # random strategies

# Group by Group
#T1_A <- simData %>% filter(Group == "A")
#T1_B <- simData %>% filter(Group == "B")

# Simulate Games L/H ------------------------------------------------------

root <- "/Users/scottcohn/Documents/UMass/Research/SocCohCivEng/soccohciveng/Coordination_Game/"
source(file.path(root, "utilities_low.R"))
source(file.path(root, "utilities_high.R"))
source(file.path(root, "algos.R"))

# Low Tx - A
# match 1
T1_12 <- .matchL(get(ID$strategy[1]), get(ID$strategy[2]), 10)
T1_34 <- .matchL(get(ID$strategy[3]), get(ID$strategy[4]), 10)

# match 2
T1_13 <- .matchL(get(ID$strategy[1]), get(ID$strategy[3]), 10)
T1_24 <- .matchL(get(ID$strategy[2]), get(ID$strategy[4]), 10)

# match 3
T1_14 <- .matchL(get(ID$strategy[1]), get(ID$strategy[4]), 10)
T1_23 <- .matchL(get(ID$strategy[2]), get(ID$strategy[3]), 10)

# High Tx - B
# match 1
T1_56 <- .matchH(get(ID$strategy[5]), get(ID$strategy[6]), 10)
T1_78 <- .matchH(get(ID$strategy[7]), get(ID$strategy[8]), 10)

# match 2
T1_57 <- .matchH(get(ID$strategy[5]), get(ID$strategy[7]), 10)
T1_68 <- .matchH(get(ID$strategy[6]), get(ID$strategy[8]), 10)

# match 3
T1_58 <- .matchH(get(ID$strategy[5]), get(ID$strategy[8]), 10)
T1_67 <- .matchH(get(ID$strategy[6]), get(ID$strategy[7]), 10)


# Extract Payoffs ---------------------------------------------------------

# Extract

# call match
(ans <- .matchL(tft, rand, 10))
(ans <- .matchH(tft, rand, 10))
# TODO have inputs be from table

# convert match to payoff list
# p1 + p2 payoffs as list
p1_pay <- ans$P[,1]
p2_pay <- ans$P[,2]

columns = sprintf("c%d", 1:10)


# join tables


# Belonging Question ------------------------------------------------------

likert4 <- 1:4
likert5 <- 1:5


# TPGG --------------------------------------------------------------------


## Task 2 ------------------------------------------------------------------




