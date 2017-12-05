library(shiny)
library(igraph)
source("./functions.R")


# load data
n = 20
cycle = make_ring(n)
lattice = make_lattice(c(5,4))
regular = sample_k_regular(n, 10, directed = F, multiple = FALSE)
scaleFree = barabasi.game(n, directed = F)


shinyServer(
  function(input, output) {
  
  netChoice = function(){
    net = switch(input$chosenNet,
                 "Cycle" = cycle,
                 "Lattice"= lattice,
                 "Regular" = regular,
                 "Scale Free" =scaleFree)
    if(input$multStart == T){
      netBefore = assignTypeMult(net)
    }
    else{
      netBefore = assignType(net)
    }
    netBefore = assignColor(netBefore)
    return(netBefore)
  }
    
      
  output$networkBefore = renderPlot({
      netBefore = netChoice()
      lay=layout.fruchterman.reingold(netBefore)
      plot(netBefore, main = "Network Before Death-Birth")
      
    })
    output$networkAfter = renderPlot({
      netBefore = netChoice()
  
      b = input$benf
      c = input$cost
      lay=layout.fruchterman.reingold(netBefore)
      netBefore = netFit(netBefore, benf = b, cost = c)
      netAfter = netUpdate(netBefore,15)
      netAfter = assignColor(netAfter)
      
      plot(netAfter, main = "Network After Death-Birth")
      
    })

  }
)
###############################################
