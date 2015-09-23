# Interesting Simulations
This page lists some interesting simulations to try.

## Traditional 6 Sided Dice
The simulation defaults to a single six sided die and the summation
aggregation function.  This results in the well known uniform 1/6
probability distribution.

Try increasing the number of six sided dice.  Two six sided dice
result in the familiar triangular probability function.  As you
increase the number of die, the probability function quickly begins
to look like (and approximate) the normal distribution function.
This result is confirmed by the fact that the probabilities can be
calculated by multiple convolutions which results in the normal
distribution in the limit as the number of dice goes to infinity.


## Trapezoids
Next try a single 4 sided die and a single 20 sided die.  The
result is a trapezoidal probability distribution.  The size and
shape of the trapezoid can be adjusted by changing the number of
sides on the two dice.  As long as they are different and there is
only one of each, you will get a trapezoid.


## Rounded Trapezoids
Building on the previous simulation, you can round the edges of
the trapezoid by increasing the number of smaller sided die.
Here are a few cases to try:

- 2 x 4-sided dice and 1 x 20-sided die

- 3 x 4-sided dice and 1 x 20-sided die

- 1 x 4-sided die, 1 x 6-sided die, and 1 x 20-sided die


## Rounded Triangle
Two dice of the same number of sides produces a triangle
probability function.  If the number of sides is large (i.e. 20),
when a single small die (i.e. 4) is added, the triangle is
rounded much like the trapezoids in the previous section.

- 2 x 20-sided dice and 1 x 4-sided die


## Min and Max Aggregation
Exploring the `min` and `max` functions creates some interesting
distributions.  With a single die, the `min` and `max` functions
produce the same results as the `sum` function becuase all three
functions return the same result when only one die is rolled.

However, the distributions start becoming interesting as the
number of dice increase.  If all of the dice have the same
number of sides, the distributions take on shapes of
polynomial functions of the order of the number of dice.  As
long as all of the dice have the same number of sides, the
`min` and `max` functions produce mirror images.

- 2 x 6-sided dice

- 3 x 6-sided dice

- 4 x 6-sided dice

Using groups of dice with different numbers of sides produces
some very interesting (and potentially counter-intuitive)
probability distributions.  Gives some of these a try:

- `max` function with 2 x 4-sided dice and 1 x 8-sided die

- `max` function with 4 x 6-sided dice and 1 x 10-sided die

- `min` function with 3 x 4-sided dice and 1 x 12-sided die


## Range Function
The `range` function (i.e. `max - min`) produces some of the
most interesting probability distributions:

- 1 x any-sided die (always results in all zeros)

- 2 x any (same) sided dice (always a lop-sided triangular ramp)

- 3 x any (same) sided dice

- 2 x 4-sided dice and 1 x 10-sided die

- 2 x 6-sided dice and 1 x 12-sided die

- 2 x 6-sided dice and 2 x 12-sided dice
