## Script file that plays around with dice simulations
require(ggplot2)

# list of acceptable dice sizes
diceSizes <- c(4,6,8,10,12,20)

diceTable <- function(numDice, diceSize) {
  # Create a table of all dice combinations
  #
  # Parameters
  # ----------
  #   numDice   int   number of each dice
  #   diceSize  list  list of dice sizes
  #
  # Return
  # ------
  #   table of dice roll combinations

	result <- expand.grid(lapply(rep(diceSize, numDice), function(x){1:x}))
	names(result) <- paste("die", 1:ncol(result), sep=".")
	return(result)
}


totalFreqs <- function(diceSizes) {
  if(length(diceSizes) == 1) {
    result <- rep(1, diceSizes)
  } else {
    result <- rep(1, diceSizes[1])
    for(i in seq(2, length(diceSizes))) {
      result <- convolve(result, rep(1, diceSizes[i]), type="open")
    }
  }
  
  return(result)
}


multDiceProb <- function(diceTable) {
  # Calculate theoretical probabilities for a list of dice
  # roll combinations
  #
  # Parameters
  # ----------
  #   diceTable   table   List of dice roll combinations
  #                         Obtainede from diceTable()
  #
  # Return
  # ------
  #   Table of dice roll combinations and theoretical probabilites

	totals <- apply(diceTable, 1, sum)
	probs <- as.data.frame(table(totals))
	names(probs) <- c("Value", "Freq")
	probs$Prob <- probs$Freq / sum(probs$Freq)
	probs$Value <- as.numeric(as.character(probs$Value))
	return(probs)
}


multDiceProb2 <- function(diceSizes) {
  # A much more efficient way of calculating the expected
  # probabilities table for the summation aggregation function
  lower <- length(diceSizes)
  upper <- sum(diceSizes)
  probs <- data.frame(Value=seq(lower, upper),
                      Freq=totalFreqs(diceSizes))
  probs$Prob <- probs$Freq / sum(probs$Freq)
  return(probs)
}


Range <- function(x) {
  # Convert the output of range() to a single number
  result <- range(x)
  
  return(result[2] - result[1] + 1)
}

incDVs <- function(diceValues, diceSizes) {
  # Increment the dice values
  
  # Initialize an index variable
  i <- 1
  
  # Initialize the result to the set of values received
  result <- diceValues
  
  # Increment the first die
  result[i] <- (result[i] + 1) %% (diceSizes[i] + 1)
  
  # Check for carry-overs
  while((i < length(diceValues)) && (result[i] == 0)) {
    result[i] <- 1
    i <- i + 1
    result[i] <- (result[i] + 1) %% (diceSizes[i] +1)
  }
  
  return(result)
}


multDiceAggFnProb <- function(diceSizes, aggFn=sum) {
  # Calculates probabilities for arbitrary aggregation functions
  
  # Start all dice with a value of 1
  diceValues <- rep(1, length(diceSizes))
  
  # Determine if we have a known limited range of values
  limitedValueRange <- any(sapply(list(max, min, Range),
                                  function(x){identical(aggFn, x)}))
  
  # Initialize the array of possible roll values
  if(limitedValueRange) {
    rollValues <- rep(0, max(diceSizes))
  } else {
    rollValues <- rep(0, prod(diceSizes))
  }
  
  # Iterate through all possible combinations of dice values
  for(i in seq(prod(diceSizes))) {
    if(limitedValueRange) {
      rollValues[aggFn(diceValues)] <- rollValues[aggFn(diceValues)] +1
    } else {
      rollValues[i] <- aggFn(diceValues)
    }
    
    diceValues <- incDVs(diceValues, diceSizes)
  }
  
  # Return a table of the results
  if(limitedValueRange) {
    values <- seq(max(diceSizes))
    if(identical(aggFn, Range)) {values <- values - 1}
    result <- data.frame(Value=values, Freq=rollValues)
  } else {
    result <- as.data.frame(table(rollValues))
    result$rollValues <- as.numeric(as.character(result$rollValues))
  }
  
  colnames(result) <- c("Value", "Freq")
  result$Prob <- result$Freq / sum(result$Freq)
  
  return(result)
}


gplotDiceProb <- function(diceProb) {
  # Generate a ggplot of the dice prababilities
  #
  # Parameter
  # ---------
  # diceProb   table   Table of dice roll combinations and
  #                    theoretical probabilites
  #                      Obtained from multDiceProb()
  #
  # Return
  # ------
  # ggplot2 plot object

	p <- ggplot(diceProb, aes(Value, Prob)) + geom_line() + geom_point()
	p <- p + ggtitle("Probability of Dice Roll")
	p <- p + xlab("Value of Dice Roll")
	p <- p + ylab("Probability")
	return(p)
}


expectedCounts <- function(p, n, cl) {
  # Calculate the expected number of events from a simulation
  #
  # Parameters
  # ----------
  #   p    float   probability of the event happening
  #   n    int     number of simulated events
  #   cl   float   confidence level
  #
  # Return
  # ------
  #   Expected number of events

	qbinom(c(0.5, (1+c(-1,1)*cl)/2), n, p)
}


expectedDiceSim <- function(diceProb, n, cl) {
  # Calculate expected dice simulation results and confidence
  # interval
  #
  # Parameters
  # ----------
  #   diceProb   table   table of dice rolls and probabilities
  #   n          int     number of dice rolls in the simulation
  #   cl         float   confidence level
  #
  # Result
  # ------
  #   Table of expected dice simulation results

	sim <- t(sapply(diceProb$Prob, function(p){expectedCounts(p, n, cl)}))
	sim <- as.data.frame(sim)
	names(sim) <- c("Count", "Count.Lower", "Count.Upper")
	result <- cbind(diceProb, sim)
	return(result)
}


gplotDiceSim <- function(diceSim) {
  # Generate a ggplot of the dice simulation
  #
  # Parameter
  # ---------
  # diceSim   table   Table of dice roll simulation results
  #
  # Return
  # ------
  # ggplot2 plot object
  
  p <- ggplot(data=diceSim,
                  aes(x=Value, y=Count, ymin=Count.Lower, ymax=Count.Upper))
	p <- p + geom_errorbar() + geom_point() + geom_line()
	p <- p + geom_bar(data=diceSim, stat="identity", aes(y=Count.Sim), alpha=0.5)
	p <- p + ggtitle("Comparison of Dice Simulation to Expected Counts")
	p <- p + xlab("Value of Dice Roll")
	p <- p + ylab("Counts")
	return(p)
}


rollDie <- function(n=1, sides=6) {
  # Simulate rolling a die
  #
  # Parameters
  # ----------
  #   n       int   number of rolls
  #   sides   int   number of sides on the die
  #
  # Return
  # ------
  #   Vector of dice rolls

	# as.integer(runif(n, 1, sides) + 0.5)
  as.integer(runif(n) * sides) + 1
}


runDiceSim <- function(dice, nRolls, confLevel=0.95, aggFn=sum) {
  # Conduct a dice simulation
  #
  # Parameters
  # ----------
  #   dice        vector  List of dice to roll
  #   nRolls      int     Number of dice rolls
  #   confLevel   float   Confidence level
  #
  # Result
  # ------
  #   Table of simulation results

  # Calculate the theoretical probabilities for each total
  if(identical(aggFn, sum)) {
    # Use the efficient method for summation
    probs <- multDiceProb2(dice)
  } else {
    # Use the brute force method
    probs <- multDiceAggFnProb(dice, aggFn)
  }
  
  # Calculate the 95% upper and lower limits for the expected counts
  sim <- expectedDiceSim(probs, nRolls, confLevel)
  
  # Perform the simulation
  diceRolls <- sapply(dice, function(d){rollDie(nRolls, d)})
  rollValues <- sapply(seq(nRolls), function(x){aggFn(diceRolls[x,])})
  if(identical(aggFn, Range)) {rollValues <- rollValues - 1}
  
  ## The following line was used for simulations using only summation
  ## diceRolls <- rowSums(sapply(dice, function(d){rollDie(nRolls, d)}))
  
  # Tabulate the results
  sim$Count.Sim <- sapply(sim$Value, function(x){sum(rollValues == x)})
  
#   if(length(dice) == 1) {
#     sim$Count.Sim <- tabulate(rollValues, max(sim$Value))
#   } else {
#     sim$Count.Sim <- tabulate(rollValues, max(sim$Value))[-(1:(min(sim$Value)-1))]
#   }
  
  # Return the simulation results
  return(sim)
  # return(list(sim=sim, diceRolls=diceRolls, rollValues=rollValues))
}


## Sample Usage
## ============

## Simulate rolling 3 four sided dice and a 20 sided die 10k times
## ---------------------------------------------------------------

# # Set up the simulation parameters
# dice <- c(4, 4, 4, 20)
# nRolls <- 50000
# confLevel <- 0.95
# 
# sim <- runDiceSim(dice, nRolls, confLevel)
# 
# # Plot the results
# p <- gplotDiceSim(sim)
# print(p)
