## SimuDice
## UI Code

## Load the required libraries
require(shiny)
require(shinyBS)


## Define some constants
minDiceCount <- 0
maxDiceCount <- 20
funList <- c("sum", "min", "max", "range")


shinyUI(fluidPage(
  theme = "bootstrap.css",

  # Title  Banner with graphic
  fluidRow(
    column(2,
      img(src="dice.png", width=100)),
    column(10,
      h2("SimuDice App"))
  ),

  # Side panel and main panel layout
  fluidRow(
    
    # Simulation Parameters
    column(4,
      h3("Parameters"),
      numericInput("rollsPerSim", label="Number dice rolls",
                   val=1000, min=1000, max=50000, step=100),
#       numericInput("numSims", label="Number of simulations",
#                    val=1, min=1, max=1000, step=10),
      selectInput("aggFn", "Aggregation Function", funList,
                  selected = "sum"),
      h4("Dice"),
      sliderInput("num4D", label="Number of 4 sided dice",
                   val=0, min=minDiceCount, max=maxDiceCount, step=1),
      sliderInput("num6D", label="Number of 6 sided dice",
                   val=1, min=minDiceCount, max=maxDiceCount, step=1),
      sliderInput("num8D", label="Number of 8 sided dice",
                   val=0, min=minDiceCount, max=maxDiceCount, step=1),
      sliderInput("num10D", label="Number of 10 sided dice",
                   val=0, min=minDiceCount, max=maxDiceCount, step=1),
      sliderInput("num12D", label="Number of 12 sided dice",
                   val=0, min=minDiceCount, max=maxDiceCount, step=1),
      sliderInput("num20D", label="Number of 20 sided dice",
                   val=0, min=minDiceCount, max=maxDiceCount, step=1)
    ),

    # Simulation Output
    column(8,
      h3("Simulation Results"),
      bsAlert("msgWarn"),
      tabsetPanel(type="tabs",
        tabPanel("Plot", plotOutput("simPlot")),
        tabPanel("Summary", verbatimTextOutput("simSummary")),
        tabPanel("Interesting Cases", includeMarkdown("interesting.md")),
        tabPanel("Help", includeMarkdown("help.md"))
      )
    )
  )
))
