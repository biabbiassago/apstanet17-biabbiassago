
assignType = function(net){
  
  ## This function assigns type attribute - cooperator or defector
  ## All nodes are defectors except for one random cooperator
  ## @net = igraph network input
  ## assign network with assigned type
  
  n = vcount(net)
  firstC = sample(1:n,1)
  V(net)$type = c(rep("D",n))
  V(net)$type[firstC] = "C"
  return(net)
}
assignTypeMult = function(net, initialFrac = 0.25){
  
  ## This function assigns type attribute - cooperator or defector
  ## @net = igraph network input
  ## @initialFrac = fraction of initial cooperators to include (default = 0.25)
  ## returns network with assigned type
  
  n = vcount(net)
  nodesCoop = sample(1:n,n*initialFrac)
  V(net)$type = c(rep("D",n))
  for(c in 1:length(nodesCoop)){
  V(net)$type[nodesCoop[c]] = "C"
  }
  return(net)
}
assignColor = function(net){
  
  ## this function assigns Blue color to cooperators and Red to defectors
  ## @net = igraph network to pass, must have a type attribute with "C","D, or "U"
  ## returns network with assigned color attribute
  
  n = vcount(net)
  if(length(V(net)$type) == 0){
    message = "You must pass a network with assignned C,D or U type"
    print(message)
    return(net)
  }  
  else{
    V(net)$color = V(net)$type
    V(net)$color=gsub("C","steel blue",V(net)$color)
    V(net)$color=gsub("D","indian red",V(net)$color)
    V(net)$color= gsum("U", "grey", V(net)$color)
    return(net)
  }
}
nodeFit = function(net,v, benf = 100, cost = 1, w = 0.1){
  ## this function defines fitness for a given node v in a network
  ## @net = igraph network 
  ## @v = node to assign fitness to 
  ## @benf = benefit gained from having a cooperator neighbour (deafult = 100)
  ## @cost = cost associated with helping a neighbour (default = 1)
  ## @w = strenght of selection. Strong selection = 1, weak Selection = 0.1
  ## returns fitness value for specified node
  
  n = vcount(net)
  
  if(length(V(net)$type) == 0){
    message = "You must pass a network with assignned C or D type"
    print(message)
    return(net)
  } 
  
  else{
    #count number of cooperator neighbours for node in question
    i = sum(neighbors(net,v)$type == "C")
    #count number of neighbours of node in question
    k = length(neighbors(net, v))
    
    ## assign cost ONLY to cooperators
    
    if (V(net)$type[v] == "C"){
      payoff = benf * i - cost * k
    }
    else if (V(net)$type[v] == "D"){
      # no cost cause they don't help
      payoff = benf * i 
    }
    
    fit = 1- w + payoff * w
    return(fit)
  }
}
netFit = function(net,benf = 100, cost = 1, w = 0.1){
  
  ## this function defines fitness for a network
  ## @net = igraph network 
  ## @benf = benefit gained from having a cooperator neighbour (deafult = 100)
  ## @cost = cost associated with helping a neighbour (default = 1)
  ## @w = strenght of selection. Strong selection = 1, weak Selection = 0.1
  ## returns network with fitness attribute assigned
  
  
  n = vcount(net)
  if(length(V(net)$type) == 0){
    message = "You must pass a network with assignned C or D type"
    print(message)
    return(net)
  } 
  
  else{
    
    for( v in 1:n)
    {
      V(net)$fitness[v] = nodeFit(net, v, benf, cost, w=0.1)
    }
    return(net)
  }
}  
deathBirth = function(net){
  ## Death Birth (one round) process as defined in Othsuki et al. 2006.
  ## One node at random "dies" and his neighbours 
  ## (cooperators or defectors) compete based on fitness
  ## @net= igraph network 
  ## returns net with updated type
  
  n = vcount(net)
  
  #death = no fitness
  dead = sample(1:n,1)
  V(net)$type[dead] = "U"
  
  #birth
  
  fc = 0
  fd = 0
  #overall fitness of cooperating neighbours
  i = neighbors(net,dead)
  for( count in 1:length(i)){
    if(neighbors(net,dead)[count]$type == "C"){
      fc = fc + as.numeric(V(net)[i[count]]$fitness)
    }
    if(neighbors(net,dead)[count]$type == "D"){
      fd = fd + as.numeric(V(net)[i[count]]$fitness)
    }
  }
  
  p = fc/(fc+fd)
  
  #cheap fix... non capisco bene cosa ci sia che non funziona
  if(p < 0){
    p = 0
  }
  else if(p>1){
    p = 1
  }
  
  #assign based on prob
  V(net)$type[dead] = sample(c("C","D"), size=1, prob=c(p,1-p))
  V(net)$fitness[dead] = nodeFit(net, dead)
  return(net)
  
}
netUpdate = function(net,rounds = 100){
  
  ## simulates network update based on Death Birth process
  ## @net = igraph network
  ## @rounds number of Death Birth processes to go through. Based on nodes of initial net. 
  ## returns network after rounds of Death Birth
  
  s = 1
  while(s<rounds){
    net = deathBirth(net)
    s = s +1
  }
  return(net)
}
simDistCoop = function(net,sims = 100, rounds = 100) {
  ## performs multiple netUpdate simulations -- network update based on Death-Birth process 
  ## @net = igraph network object.
  ## @sims = number of netUpdate simualtions to perform. Deafult = 100
  ## @rounds number of Death Birth processes to go through. Based on nodes of initial net. Deafult = 100
  # returns vector with fractions of cooperators in each network

  n = vcount(net)
  reps = 0
  frac = c()
  while(reps<sims){
    netUp = netUpdate(net,rounds)
    f = sum(V(netUp)$type == "C")/n
    frac = c(f,frac)
    reps = reps + 1
  }
  return(frac)
}



# ### my functions ###
# assignColor()   - blue cooperators and red defectors
# nodeFit()       - assign fitness based on neighbouring cooperators and defectors
# netFit()        - assign fitness to whole network
# deathBirth()    - death Birth updating for one node
# netUpdate()     - death birth through whole network
# simDistCoop()   - simulate deathBirth for multiple times and gives distribution of %coops. 
# ##################