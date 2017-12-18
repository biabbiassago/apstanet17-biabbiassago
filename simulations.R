##Under weak selection
smallestW = sample_smallworld(1, 20, 2, 0.1, loops = FALSE, multiple = FALSE)
smallestWTest = assignType(smallestW)
smallestWTest = assignColor(smallestWTest)
smallestWTest = netFit(smallestWTest, benf = 5, cost = 1, w = 0.1)
plot(smallestWTest)


#1 Generation
dataProp_weak = array(dim = c(100,9))
i = 1
for(r in seq(0,16,2)){
  currentFrac = simDistCoop(net = smallestWTest, benf = r, cost = 1, w=0.1, sims=100,rounds=75)
  dataProp_weak[,i] = currentFrac
  i = i + 1
}

write.csv(dataProp_weak, "dataProp_weak.csv")

#2 Generations 
dataProp_weak_two = array(dim = c(100,9))
i = 1
for(r in seq(0,16,2)){
  currentFrac = simDistCoop(net = smallestWTest, benf = r, cost = 1, w=0.1, sims=100,rounds=150)
  dataProp_weak_two[,i] = currentFrac
  i = i + 1
}

write.csv(dataProp_weak_two, "dataProp_weak_two.csv")


#UNDER STRONG SELECTION

#di notte venerdi
smallestW_strong = sample_smallworld(1, 20, 2, 0.1, loops = FALSE, multiple = FALSE)
smallestWTest_strong = assignType(smallestW_strong)
smallestWTest_strong = assignColor(smallestWTest_strong)
smallestWTest_strong = netFit(smallestWTest_strong, benf = 5, cost = 1, w = 1)



#1 Generation
dataProp_strong = array(dim = c(100,9))
i = 1
for(r in seq(0,16,2)){
  currentFrac = simDistCoop(net = smallestWTest_strong, benf = r, cost = 1, w=1, sims=100,rounds=75)
  dataProp_strong[,i] = currentFrac
  i = i + 1
}

write.csv(dataProp_strong, "dataProp_strong.csv")

#2 Generations 
dataProp_strong_two = array(dim = c(100,9))
i = 1
for(r in seq(0,16,2)){
  currentFrac = simDistCoop(net = smallestWTest_strong, benf = r, cost = 1, w=1, sims=100,rounds=150)
  dataProp_strong_two[,i] = currentFrac
  i = i + 1
}

write.csv(dataProp_strong_two, "dataProp_strong_two.csv")




##############################################