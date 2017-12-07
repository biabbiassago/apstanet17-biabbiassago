###########CIRLCE#######################

n = 100
#for benefit/cost > k =2
benf_1 = 20
cost_1 = 1
sampleCircle = make_ring(n, directed=FALSE)
sampleCircle = assignType(sampleCircle)
sampleCircle = assignColor(sampleCircle)
sampleCircle = netFit(sampleCircle,benf = benf_1,cost =cost_1)

#for benefit/cost < k =2
benf_2 = 1
cost_2 = 1
sampleCircle2 = make_ring(n, directed=FALSE)
sampleCircle2 = assignType(sampleCircle2)
sampleCircle2 = assignColor(sampleCircle2)
sampleCircle2 = netFit(sampleCircle2,benf = benf_2,cost =cost_2)

##sims
fracCircle_1 = simDistCoop(sampleCircle,benf = benf_1, cost = cost_1,100,500)
fracCircle_2 = simDistCoop(sampleCircle2,benf= benf_2, cost = cost_2, 100, 500)


# histograms to plot and table
z.test(mean(fracCircle_1), mean(fracCircle_2), alternative = "greater",mu = 0)
confIntCircle_1= c(mean(fracCircle_1)-1.96*sd(fracCircle_1)/sqrt(n),mean(fracCircle_1)+1.96*sd(fracCircle_1)/sqrt(n))
confIntCircle_2 =c(mean(fracCircle_2)-1.96*sd(fracCircle_2)/sqrt(n),mean(fracCircle_2)+1.96*sd(fracCircle_2)/sqrt(n))

par(mfrow = c(1,2))
histCircle1 = qplot(fracCircle_1,bins = 30, main="Fraction of Cooperators in 100 Simulations, b/c=20",xlab="fraction of Cooperators",geom="histogram") + theme_minimal()
histCircle2 = qplot(fracCircle_2,bins = 30, main="Fraction of Cooperators in 100 Simulations, b/c=1",xlab="fraction of Cooperators",geom="histogram") + theme_minimal()

grid.arrange(histCircle1,histCircle2)

lower = c(0.111,0.091)
mean = c(0.120,0.098)
upper = c(0.129,0.105)

resultsCircle = data.frame(lower,mean,upper) 
colnames(resultsCircle) = c("95% CI lower bound","mean","95% CI upper bound")
rownames(resultsCircle) = c("b/c = 20", "b/c = 1")
kable(resultsCircle, caption= "Comparison of mean % of cooperators for different benefit-cost ratios")


#######LATTICE###########################
#for benefit/cost > k =2
sampleLattice = make_lattice(n/10,n/10, directed=FALSE)
sampleLattice = assignType(sampleLattice)
sampleLattice = assignColor(sampleLattice)
sampleLattice = netFit(sampleLattice,benf = benf_1,cost =cost_1)

#for benefit/cost < k =2
benf_2 = 1
cost_2 = 1
sampleLattice2 = make_ring(n, directed=FALSE)
sampleLattice2 = assignType(sampleLattice2)
sampleLattice2 = assignColor(sampleLattice2)
sampleLattice2 = netFit(sampleLattice2,benf = benf_2,cost =cost_2)

fracLattice_1 = simDistCoop(sampleLattice,benf = benf_1, cost = cost_1,100,500)
fracLattice_2 = simDistCoop(sampleLattice2,benf= benf_2, cost = cost_2, 100, 500)
par(mfrow = c(1,2))
hist(fracLattice_1, freq = F)
hist(fracLattice_2, freq = F)

##################SCALE FREE###################

#for benefit/cost > k =2
sampleScale = barabasi.game(n, directed = F)
sampleScale2 = sampleScale
sampleScale = assignType(sampleScale)
sampleScale = netFit(sampleScale,benf = benf_1, cost= cost_1,100,500)


#for benefit/cost < k =2
sampleScale2 = assignType(sampleScale2)
sampleScale2 = netFit(sampleScale2,benf = benf_2, cost= cost_2,100,500)

fracSale_1 = simDistCoop(sampleScale, benf = benf_1, cost = cost_1, 100,500)
fracSale_2 = simDistCoop(sampleScale, benf = benf_1, cost = cost_1, 100,500)

par(mfrow = c(1,2))
hist(fracScale_1, freq = F)
hist(fracScale_2, freq = F)

##############################################