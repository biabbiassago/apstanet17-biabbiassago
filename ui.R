library(shiny)

#using Shiny platform, design an App to visualize the netUpdate() process as described in funcitons.R. In this document, the 
#code to create the UI of the App. 

fluidPage(
  pageWithSidebar(
    titlePanel(h3("Evolution of cooperators in a Network")),
    
    
<<<<<<< HEAD
=======
    # choose which nets should be displayed
>>>>>>> c86bb0b853684314fa7de55d3f0bbb93cc40af4e
    sidebarPanel(
      selectInput("chosenNet", label = "Type of Network",
                  choices = c("Cycle","Lattice","Regular","Scale Free")),
      
      sliderInput("benf", label = "Benefit",
                  min = 2, max = 20, value = 20, step = 1),
      
      sliderInput("cost", label = "Cost",
                  min = 2, max = 20, value = 2, step = 1),
      
      checkboxInput("multStart", "Multiple Initial Cooperators", FALSE),
    
      # SubmitButton - to avoid too much load 
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
