library(shiny)

constructDiceOutput <- function(id4,id6,id8,id10,id12,id20,id1) {
  if(id4 == 0 & id6 == 0 & id8 == 0 & id10 == 0 & id12 == 0 & id20 == 0) {
    "No Dice Selected!"
  }
  else {
    diceoutput = ""
    if(id4 > 0) diceoutput = paste(diceoutput,id4,"d4 + ",sep="")
    if(id6 > 0) diceoutput = paste(diceoutput,id6,"d6 + ",sep="")
    if(id8 > 0) diceoutput = paste(diceoutput,id8,"d8 + ",sep="")
    if(id10 > 0) diceoutput = paste(diceoutput,id10,"d10 + ",sep="")
    if(id12 > 0) diceoutput = paste(diceoutput,id12,"d12 + ",sep="")
    if(id20 > 0) diceoutput = paste(diceoutput,id20,"d20 + ",sep="")
    if(id1 > 0) diceoutput = paste(diceoutput,id1,sep="")
    else diceoutput = substr(diceoutput, 1, nchar(diceoutput)-2)
    diceoutput
  }
}

constructSample <- function(id4,id6,id8,id10,id12,id20,id1) {
  if(id4 == 0 & id6 == 0 & id8 == 0 & id10 == 0 & id12 == 0 & id20 == 0) {
    results=as.data.frame(cbind(c(0,0),c(0,0)))  
    names(results) = c("Average_Sums","Average_Variances")
    results
  }
  else {
    sample_means = NULL
    sample_variances = NULL
    #c("Mean Sum of Rolled Dice","Standard Deviation")
    for (i in 1 : 1000) {
      this_sample = NULL
      for (j in 1 : 40) {
        total = id1
        total = total + sum(sample(1:4,id4,replace=TRUE))
        total = total + sum(sample(1:6,id6,replace=TRUE))
        total = total + sum(sample(1:8,id8,replace=TRUE))
        total = total + sum(sample(1:10,id10,replace=TRUE))
        total = total + sum(sample(1:12,id12,replace=TRUE))
        total = total + sum(sample(1:20,id20,replace=TRUE))
        this_sample = c(this_sample,total)
      }
      sample_means = c(sample_means, mean(this_sample))
      sample_variances = c(sample_variances, var(this_sample))
    }
    results=as.data.frame(cbind(sample_means,sample_variances))
    names(results) = c("Average_Sums","Average_Variances")
    results
  }
}

shinyServer(
  function(input,output) {

    results <- reactive({
      results <- constructSample(input$id4,input$id6,input$id8,input$id10,input$id12,input$id20,input$id1)
    })

    output$fulldice <- renderText({constructDiceOutput(input$id4,input$id6,input$id8,input$id10,input$id12,input$id20,input$id1)})
    output$sum <- renderText({mean(results()$Average_Sums)})
    output$stddev <- renderText({sqrt(mean(results()$Average_Variances))})
  }
)
