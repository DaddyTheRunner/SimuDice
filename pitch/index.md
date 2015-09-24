---
title       : SimuDice
subtitle    : Simulating Rolling Multi-Sided Dice
author      : Daddy The Runner
job         : Developing Data Products
logo        : dice.png
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

<style>
em { font-style: italic }
strong { font-weight: bold }
</style>



## Introduction to _SimuDice_

- **SimuDice** allows you to explore the characteristics of rolling
collections of dice

- **_Description:_**
    - The purpose of this shiny app is to explore the probability
      distributions of rolling various combinations of multi-sided
      dice.  The app allows the user to choose the set of dice to
      use for the simulation as well as the number of rolls to
      simulate.


- **_Dice Basics_**
    - The most common/familiar die is a six-sided cube
    - Rolling a single die results in a simple uniform distribution
    - Rolling two dice (e.g. 2 x 6-sided dice) yields a simple
      triangular distribution
    - Dice can be made from any regular polyhedron
    - There are six regular polyhedrons with the following sides:
        - 4, 6, 8, 10, 12, 20

--- .class #id 

## Rolling Multiple Dice

- Rolling multiple dice results in a random sampling of numbers
- These numbers can be combined (or aggregated) into a single
statistic
    - The traditional statistic used is a simple summation:
        - Dice values:  4, 5,  2
        - `sum`:  11
    - Other options include:
        - `max`:  5
        - `min`:  2
        - `range`:  3
            - Where `range` is defined as `max - min`
    - These non-traditional aggregations produce some interesting
    and complex probability distributions

--- .class #id 

## Sample _SimuDice_ Plot

- Here is a sample plot from _SimuDice_ for a simulation of
10,000 rolls of three dice:  2 x 6-sided dice and 1 x 12-sided
die using the `range` aggregator

![plot of chunk unnamed-chunk-1](assets/fig/unnamed-chunk-1-1.png) 

- The bars show the total number of times each `range` value
appeared in the simulation.  The line, points and wiskers
represent the expected simulation results and the 95% confidence 
range.

--- .class #id 

## Sample _SimuDice_ Plot

- The following is a plot for a simulation of 10,000 rolls of
5 dice:  4 x 6-sided dice and 1 x 10-sided die using the `max`
aggregator

![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2-1.png) 

