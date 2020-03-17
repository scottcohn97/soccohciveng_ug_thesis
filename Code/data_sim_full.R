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

T1_1_1 <- T1_12$P[,1] %>% append(1)
T1_2_1 <- T1_12$P[,2] %>% append(2)
T1_3_1 <- T1_34$P[,1] %>% append(3)
T1_4_1 <- T1_34$P[,2] %>% append(4)

# match 2
T1_13 <- .matchL(get(ID$strategy[1]), get(ID$strategy[3]), 10)
T1_24 <- .matchL(get(ID$strategy[2]), get(ID$strategy[4]), 10)

# match 2 payoffs

T1_1_2 <- T1_13$P[,1] %>% append(1)
T1_2_2 <- T1_24$P[,1] %>% append(2)
T1_3_2 <- T1_13$P[,2] %>% append(3)
T1_4_2 <- T1_24$P[,2] %>% append(4)

# match 3
T1_14 <- .matchL(get(ID$strategy[1]), get(ID$strategy[4]), 10)
T1_23 <- .matchL(get(ID$strategy[2]), get(ID$strategy[3]), 10)

# match 3 payoffs

T1_1_3 <- T1_14$P[,1] %>% append(1)
T1_2_3 <- T1_23$P[,1] %>% append(2)
T1_3_3 <- T1_23$P[,2] %>% append(3)
T1_4_3 <- T1_14$P[,2] %>% append(4)

# High Tx - B
# match 1
T1_56 <- .matchH(get(ID$strategy[5]), get(ID$strategy[6]), 10)
T1_78 <- .matchH(get(ID$strategy[7]), get(ID$strategy[8]), 10)

# match 1 payoffs

T1_5_1 <- T1_56$P[,1] %>% append(5)
T1_6_1 <- T1_56$P[,2] %>% append(6)
T1_7_1 <- T1_78$P[,1] %>% append(7)
T1_8_1 <- T1_78$P[,2] %>% append(8)

# match 2
T1_57 <- .matchH(get(ID$strategy[5]), get(ID$strategy[7]), 10)
T1_68 <- .matchH(get(ID$strategy[6]), get(ID$strategy[8]), 10)

# match 2 payoffs

T1_5_2 <- T1_57$P[,1] %>% append(5)
T1_6_2 <- T1_68$P[,1] %>% append(6)
T1_7_2 <- T1_57$P[,2] %>% append(7)
T1_8_2 <- T1_68$P[,2] %>% append(8)

# match 3
T1_58 <- .matchH(get(ID$strategy[5]), get(ID$strategy[8]), 10)
T1_67 <- .matchH(get(ID$strategy[6]), get(ID$strategy[7]), 10) 

# match 3 payoffs

T1_5_3 <- T1_58$P[,1] %>% append(5)
T1_6_3 <- T1_67$P[,1] %>% append(6)
T1_7_3 <- T1_67$P[,2] %>% append(7)
T1_8_3 <- T1_58$P[,2] %>% append(8)

# Payoff Table ---------------------------------------------------------

columns <- sprintf("c%d", 1:10) %>% append("partID")

# join tables
payoffsL <- tibble(columns, T1_1_1, T1_2_1, T1_3_1, T1_4_1,
                  T1_1_2, T1_2_2, T1_3_2, T1_4_2,
                  T1_1_3, T1_2_3, T1_3_3, T1_4_3) 

payoffsH <- tibble(columns, T1_5_1, T1_6_1, T1_7_1, T1_8_1,
                   T1_5_2, T1_6_2, T1_7_2, T1_8_2,
                   T1_5_3, T1_6_3, T1_7_3, T1_8_3)

# Belonging Questions ------------------------------------------------------

likert4 <- 1:4
likert5 <- 1:5

belQ <- function(){
  Q1 <- sample(likert4, 1, replace = TRUE)
  Q2_3 <- sample(likert5, 2, replace = TRUE)
  return(append(Q1, Q2_3))
}

x <- c("partID", "Q1", "Q2", "Q3")
belongingQuestions <- as.data.frame(sapply(x, function(x) numeric()))

for (i in 1:8) {
  belongingQuestions[i, ] <- append(i, belQ())
}

# TPGG --------------------------------------------------------------------


## Task 2 ------------------------------------------------------------------




