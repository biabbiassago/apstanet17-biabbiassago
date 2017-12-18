library(shiny)
library(igraph)
source("./functions.R")

#using simulation functions create app to simulate the netUpdate() process as defined in functions.R

# load data
n = 20
cycle = make_ring(n)
lattice = make_lattice(c(5,4))
regular = sample_k_regular(n, 10, directed = F, multiple = FALSE)
scaleFree = barabasi.game(n, directed = F)
smallWorld = sample_smallworld(1, n, 2, 0.1, loops = FALSE, multiple = FALSE)



shinyServer(
  function(input, output) {
  
  netChoice = function(){
    net = switch(input$chosenNet,
                 "Cycle" = cycle,
                 "Lattice"= lattice,
                 "Regular K = 10" = regular,
                 "Scale Free mean k = 2" =scaleFree,
                 "Small World mean k =4" = smallWorld)
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
      plot(netBefore, main = "Network Before Death-Birth update",vertex.label=NA, layout=lay)
      
    })
    output$networkAfter = renderPlot({
      netBefore = netChoice()
  
      b = input$benf
      c = input$cost
      lay=layout.fruchterman.reingold(netBefore)
      netBefore = netFit(netBefore, benf = b, cost = c)
      netAfter = netUpdate(netBefore,benf=b, cost=c, 50)
      netAfter = assignColor(netAfter)
      
      plot(netAfter, main = "Network After Death-Birth update", vertex.label=NA, layout=lay)
      
    })

  }
)
###############################################
