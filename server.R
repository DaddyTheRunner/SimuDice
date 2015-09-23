## SimuDice
## Sever Code

## Load the required libraries
require(shiny)
require(shinyBS)

## Load the diceTools
source("diceTools.R")


## Create some constants

# Limits the amount of time calculating theoretical results
# 20,000 ~ 1 second on an AMD Dual-Core C60
computationLimit <- 50000


shinyServer(function(input, output, clientData, session) {
  
  # Reactive code to conduct the dice roll simulation
  #
  # Note:
  #   Currently it only performs one simulation and ignores
  #   the number of simulation input parameter
  
  # Keep track of the dice
  diceList <- reactive({
    c(rep(4, input$num4D),
      rep(6, input$num6D),
      rep(8, input$num8D),
      rep(10, input$num10D),
      rep(12, input$num12D),
      rep(20, input$num20D)
    )
  })
  
  # Keep track of the aggregation function
  aggFn <- reactive({
    switch(input$aggFn,
           sum = sum,
           min = min,
           max = max,
           range = Range)
  })
  
  
  # Check for safe parameters
  unsafeParams <- reactive({
    # Start off assuming safe parameters
    result <- FALSE
    closeAlert(session, "paramWarn")
    
    if (identical(aggFn(), sum)) { result <- FALSE}
    else if (length(diceList()) < 1) { result <- TRUE }
    else if (max(diceList()) < 1) { result <- TRUE }
    else if (prod(diceList()) > computationLimit) { result <- TRUE }
    
    if (result) {
      msg <- list(
        p("Input Parameters are predicted to cause excessive",
          "computation time or there are an invalid number",
          "of dice"),
        p("Estimated computation time:  ", prod(diceList())/20000,
          "seconds."),
        p("Number of dice:  ", length(diceList())))
      # msg <- capture.output(cat(sapply(seq(length(msg)), function(x){capture.output(msg[[x]])})))
      msg <- paste(sapply(seq(length(msg)), function(x){paste(msg[[x]])}))
      
      createAlert(session, "msgWarn", alertId = "paramWarn",
                  title = "<b>Unsafe Parameters</b>",
                  content = msg, style = "warning", append = FALSE)
    } else {
      closeAlert(session, "paramWarn")
    }
    
    return(result)
  })

  
  # Generate the simulation data
  sim <- reactive({
    if (unsafeParams())
      return(NULL)

    runDiceSim(diceList(), input$rollsPerSim,
               confLevel=0.95, aggFn = aggFn())
  })

  # Generate a plot of the simulation results
  output$simPlot <- renderPlot({
    if (is.null(sim())) {
      return()
    } else {
      # print("getting ready to plot...")
      p <- gplotDiceSim(sim())
      print(p)
    }
  })
  
  # Generate a table of the simulation results
  output$simSummary <- renderPrint({
    if (is.null(sim())) {
      return()
    } else {
      sim()
    }
  })
})
