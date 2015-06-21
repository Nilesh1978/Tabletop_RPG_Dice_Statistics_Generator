library(shiny)

shinyUI(
  pageWithSidebar(
    headerPanel("Let's Roll Some Dice!"),
    sidebarPanel(
      numericInput('id4','Number of Four-Sided Dice to Roll (d4)',0, min=0,max=50, step=1),
      numericInput('id6','Number of Six-Sided Dice to Roll (d6)',0, min=0,max=50, step=1),
      numericInput('id8','Number of Eight-Sided Dice to Roll (d8)',0, min=0,max=50, step=1),
      numericInput('id10','Number of Ten-Sided Dice to Roll (d10)',0, min=0,max=50, step=1),
      numericInput('id12','Number of Twelve-Sided Dice to Roll (d12)',0, min=0,max=50, step=1),
      numericInput('id20','Number of Twenty-Sided Dice to Roll (d20)',0, min=0,max=50, step=1),
      numericInput('id1','Constant Additive Factor',0, min=-250,max=250, step=1),
      submitButton('Start Rolling!')
    ),
    mainPanel(
      h2('You chose to roll:'),
      textOutput("fulldice"),
      h2('The mean sum for rolling the chosen dice is:'),
      verbatimTextOutput("sum"),
      h2('with standard deviation:'),
      verbatimTextOutput("stddev")
    )
  )
)