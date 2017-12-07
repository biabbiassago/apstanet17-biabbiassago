library(shiny)

fluidPage(
  pageWithSidebar(
    
    titlePanel("Evolution of cooperators in a Network"),
    
    # choose which nets should be displayed
    sidebarPanel(
      selectInput("chosenNet", label = "Type of Network",
                  choices = c("Cycle","Lattice","Regular","Scale Free")),
      
      sliderInput("benf", label = "Benefit",
                  min = 2, max = 20, value = 20, step = 1),
      
      sliderInput("cost", label = "Cost",
                  min = 2, max = 20, value = 2, step = 1),
      
      checkboxInput("multStart", "Multiple Initial Cooperators", FALSE),
    
      # SubmitButton - to avoid to much load 
      submitButton("Simulate")
    ),
    
    # output
    mainPanel(
    fluidRow(
      splitLayout(cellWidths = c("50%", "50%"), plotOutput("networkBefore"), plotOutput("networkAfter"))
    )
  )
  )
)
