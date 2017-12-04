assignColor = function(net){
  if(length(V(net)$type) == 0){
    message = "You must pass a network with assignned C or D type"
    print(message)
    return(net)
  }  
  else{
    V(net)$color = V(net)$type
    V(net)$color=gsub("C","steel blue",V(net)$color)
    V(net)$color=gsub("D","indian red",V(net)$color)
    return(net)
  }
}
nodeFit = function(net,v){
  ## this function defines fitness for a given node in a network
  
  
  if(length(V(net)$type) == 0){
    message = "You must pass a network with assignned C or D type"
    print(message)
    return(testG)
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
      payoff = benf * i 
    }
    
    fit = 1- w + payoff * w
    return(fit)
  }
}
deathBirth = function(net){
  #this function goes through one round of death birth updating. 
  # one node dies and based on fitness of neighbours, the newborn node is either 
  #a cooperator or a defector
  
  
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
    if(neighbors(net,2)[count]$type == "C"){
      fc = fc + as.numeric(V(net)[i[count]]$fitness)
    }
    if(neighbors(testG,2)[count]$type == "D"){
      fd = fd + as.numeric(V(testG)[i[count]]$fitness)
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
  V(net)$fitness[dead] = defFit(net, dead)
  return(net)
  
}
#node level definition of fitness
##define fitness for whole network
netFit = function(net){
  
  if(length(V(net)$type) == 0){
    message = "You must pass a network with assignned C or D type"
    print(message)
    return(net)
  } 
  
  else{
    
    for( v in 1:n)
    {
      V(net)$fitness[v] = defFit(net, v)
    }
    return(net)
  }
}  
netUpdate = function(net,rounds = 100){
  s = 1
  while(s<rounds){
    net = deathBirth(net)
    s = s +1
  }
  return(net)
}
#do multiple rounds to see results in histogram
simDistCoop = function(net,sims = 100, rounds = 100) {
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