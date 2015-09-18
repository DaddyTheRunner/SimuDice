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
However, familiar are dice with different number of sides.  There
are six regular polyhedrons which have the following number of
sides:  4, 6, 7, 10, 12, 20.

The app allows the user to choose how many of each type of die to
use in the simulation.


## Simulation Details
For each simulated roll of the dice, the face value of the dice are
summed together.  Once conducting the requested number of dice rolls,
the results are tabulated and compared with the theoretical expected
results.

### Simulation Parameters
- **Number of Rolls** - Number of times the dice are rolled in the simulation (1000 - 50,000)

- **Number of _n_ Sided Dice** - The number of dice with _n_ sides (1 - 20)

**Note:** There must be at least one die in the simulation.  If all
dice inputs are zero, then the six sided die is reset to 1.


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

#### Help
This help file.
