# ----------------------
# Simulated Data
# Scott Cohn
# Mar 16, 2020
# ----------------------

# !! Code 1 random session, run it MC-style N times
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
# Task1_player1player2

T1_12 <- .matchL(get(ID$strategy[1]), get(ID$strategy[2]), 10)
T1_34 <- .matchL(get(ID$strategy[3]), get(ID$strategy[4]), 10)

# match 1 payoffs
# Task1_Player_Match

T1_1_1 <- T1_12$P[,1]
T1_2_1 <- T1_12$P[,2]
T1_3_1 <- T1_34$P[,1]
T1_4_1 <- T1_34$P[,2]

# match 2
T1_13 <- .matchL(get(ID$strategy[1]), get(ID$strategy[3]), 10)
T1_24 <- .matchL(get(ID$strategy[2]), get(ID$strategy[4]), 10)

# match 2 payoffs

T1_1_2 <- T1_13$P[,1]
T1_2_2 <- T1_24$P[,1]
T1_3_2 <- T1_13$P[,2]
T1_4_2 <- T1_24$P[,2]

# match 3
T1_14 <- .matchL(get(ID$strategy[1]), get(ID$strategy[4]), 10)
T1_23 <- .matchL(get(ID$strategy[2]), get(ID$strategy[3]), 10)

# match 3 payoffs

T1_1_3 <- T1_14$P[,1]
T1_2_3 <- T1_23$P[,1]
T1_3_3 <- T1_23$P[,2]
T1_4_3 <- T1_14$P[,2]

# High Tx - B
# match 1
T1_56 <- .matchH(get(ID$strategy[5]), get(ID$strategy[6]), 10)
T1_78 <- .matchH(get(ID$strategy[7]), get(ID$strategy[8]), 10)

# match 1 payoffs

T1_5_1 <- T1_56$P[,1]
T1_6_1 <- T1_56$P[,2]
T1_7_1 <- T1_78$P[,1]
T1_8_1 <- T1_78$P[,2]

# match 2
T1_57 <- .matchH(get(ID$strategy[5]), get(ID$strategy[7]), 10)
T1_68 <- .matchH(get(ID$strategy[6]), get(ID$strategy[8]), 10)

# match 2 payoffs

T1_5_2 <- T1_57$P[,1]
T1_6_2 <- T1_68$P[,1]
T1_7_2 <- T1_57$P[,2]
T1_8_2 <- T1_68$P[,2]

# match 3
T1_58 <- .matchH(get(ID$strategy[5]), get(ID$strategy[8]), 10)
T1_67 <- .matchH(get(ID$strategy[6]), get(ID$strategy[7]), 10)

# match 3 payoffs

T1_5_3 <- T1_58$P[,1]
T1_6_3 <- T1_67$P[,1]
T1_7_3 <- T1_67$P[,2]
T1_8_3 <- T1_58$P[,2]

# Payoff Table ---------------------------------------------------------

columns = sprintf("c%d", 1:10)
idrow <- c("ID", 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4)
# join tables
payoffsL <- tibble(columns, T1_1_1, T1_2_1, T1_3_1, T1_4_1,
                  T1_1_2, T1_2_2, T1_3_2, T1_4_2,
                  T1_1_3, T1_2_3, T1_3_3, T1_4_3) 
payoffsL <- rbind(payoffsL, idrow)
# TODO figure out ID and reformatting this
  

payoffsH <- tibble(columns, T1_5_1, T1_6_1, T1_7_1, T1_8_1,
                   T1_5_2, T1_6_2, T1_7_2, T1_8_2,
                   T1_5_3, T1_6_3, T1_7_3, T1_8_3)

# Belonging Question ------------------------------------------------------

likert4 <- 1:4
likert5 <- 1:5


# TPGG --------------------------------------------------------------------


## Task 2 ------------------------------------------------------------------




