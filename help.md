# SimuDice App
*Author: Daddy The Runner*
***

## Description
The purpose of this shiny app is to explore the probability
distributions of rolling various combinations of multi-sided
dice.  The app allows the user to choose the set of dice to
use for the simulation as well as the number of rolls to
simulate.

## Dice
Most people are very familiar with the very common six sided die.
However, less familiar are dice with different numbers of sides.
Dice can be made from regular polyhedrohns.
There are six regular polyhedrons which have the following numbers
of sides:  4, 6, 7, 10, 12, 20.

The app allows the user to choose how many of each type of die to
use in the simulation.


## Combining Dice Values
The traditional method of aggregating the values of multiple dice
is to simply add all of the values together.  However, there are
other options for aggregation:  minimum value, maximum value, and
range (i.e. `max - min`) are a few examples.

The app allows the user to choose the aggregation function used
for each roll of the dice.


## Simulation Details
For each simulated roll of the dice, the face value of the dice are
agreggated together using the specified function.  Once done
conducting the requested number of dice rolls,
the results are tabulated and compared with the theoretically
expected results.

### Simulation Parameters
- **Number of Rolls** - Number of times the dice are rolled in the simulation (1000 - 50,000)

- **Aggregation Function** - Name of the function used to aggregate the values of the dice on each roll.  (`sum`, `min`, `max`, or
`range`)

- **Number of _n_ Sided Dice** - The number of dice with _n_ sides (1 - 20)

**Note:** As the number of dice increase, the the total number of
possible dice combinations grows exponentially.  Therefore, the
app protects against long computation times by roughly estimating
the computation time required to calculate the theoretical
expectations.  If the predicted computation time exceeds a
predetermined threshold (about 2.5 seconds), a warning message
is displayed and the computation is suspended until the number
of dice is reduced.

The computation time is impacted by the number of sides on each
die.  Therefore, the app allows larger numbers of smaller dice.

The theoretical expectations for the summation function can be
calculated very efficiently using convolution.  Therefore, the
maximum number of dice for the summation function is significantly
larger than for the other aggregation function options.


### Outputs

#### Plot
A graphical depiction of the simulation results.  The bars show the
total number of times each sum appeared in the simulation.  The line,
points and wiskers represent the expected simulation results and the
95% confidence range.

#### Summary
A tabluated depiction of the simulation results.  The columns of the
table are:

- **Total** - Sum of the dice values

- **Freq** - The number of ways each total value can be obtained given the set of dice rolled

- **Prob** - The probability of getting the given total value on a
single roll of the set of dice

- **Count** - The expected number of times the given total should be seen for the number of rolls performed

- **Count.Lower** - Lower limit on the expected number of observations for a given total (95% confidence level)

- **Count.Upper** - Upper limit on the expected number of observations for a given total (95% confidence level)

- **Count.Sim** - The actual number of observations in the simulation.

#### Interesting Cases
A page of recommended simulation settings to try.

#### Help
This help file.
