Using Networks to study the Evolution of Cooperation
================
Bianca Brusco bb1569
12/5/2017

A bit of background...
----------------------

### Why Evolutionary Game Theory?

Under Darwin's theory of **Natural Selection**, evolution in a population is intended as the propagation of particular genes that increase the fitness of the present individuals. Those who are more fit tend to produce more offspring, so that those genes are proportionally more represented in the population.

Many behaviours, however, do not depend on the single gene of the single individual, but rather on how posessing a certain behavioural characteristic increases (or decreases) the individual's fitness in its interactions with other memebers of the population. As a consequence, the fitness brought by a gene ( or a set of genes) should not measured in isolation, but rather in the context of the entire population that the organism is part of.

In particular, we examine the attribute **"Cooperation"**. In this context, Cooperation is seen as a binary characteristic (either "cooperator"" or "defector"") of an individual, rather than as a spectrum. We can intuitively see how the benefit of Cooperation depends on the charactersitcs of the population as a whole: if I am the only animal helping the population to feed itself, I risk wasting a lot of energy gathering food that I will not eat, therefore decreasing my overall fitness for the benefit of my neighbours. However, if all my neighbours are cooperators, we can explore more food sources than a single individual, and as a whole, we are more likely to collect more food per individual that if we were to scavange alone.

The evolution of cooperation in animal populations has long been a subject of investigation. The fact that some animals cooperate seems, at a first glance, to oppose Darwin's Natural Selection theory: the genes of those who benefit from the help of others, while not wasting any resources if not on themseleves, are most likely to be passed on, as those individuals are likely to be the fittest.

One important theory in evolutionary biology, that reconciled the empirical observation with the theory of Natural Selection, was developed by Hamilton in 1957 (check can't remember exactly). Hamilton argued that individuals do not only want to benefit their own fitness, but rather the fitness of individuals who share their gene pool. For example, Hamilton's theory explained why some ants spend their lives helping the Queen ant rather than focusing on reproducing. Indeed, they share more genes with their sister (Queen ant), than with their potential offspring.

In more recent years, the evolution of cooperation has been examined through different lenses, taking a game theoretical approach. The interaction of members of a population can be seen has an "evolutionary game", in which there is a dominant strategy, which not only depends on the two individual's fitness (or "payoff") but rather on the overall characteristics and fitness of the population. In some cases, the dominant strategy is "cooperator", in some, it is not.

### Why networks?

Many evolutionary games have been modeled on fully connected population, in which all individuals interact with each other. However, this is not very representative of real population. Networks can be very valuable for the study of evolutionary games because they represent properly interaction among individuals, and population structures are more realistically under this setting.

My project
----------

All the code used throughout to generate visualizations or results in this presentation is in apsta-net17/biabiassago repo.

### Testing Evolution of Cooperation

In this project, my initial aim was to replicate the results published by Outhsuki et al. in 2006. In the paper, the authors explore the evolution of cooperation in networks, investigating of the number of neighbours that each node has is an important variable. They prove that a *necessary condition* for cooperation to evolve is for the ratio of benefit of having cooperators as neighbours(b) over cost of helping them (c) to be larger than the number of neighbours (k). I.e $\\frac{b}{c}&gt; k$. This means: the less neighbours you interact with, the more you have to rely on them. And therefore, the more chances there are that you pick a cooperating strategy.

The authors test multiple cycles of simulation by introducing one single cooperator in a population of defectors, and observe in which cases the cooperator attribute evolves among all individuals.

They argue that if the cooperation attribute is neutral (i.e. it neither increases nor decreases fitness) then the probability of a single cooperator turning the enitre population into defectors (called "fixation probability") is of 1/N (with N, number of nodes). If the fixation probability of a single cooperator is greater than 1/N, then selection favors the emergence of cooperation.

Therefore they study the fixation probability of cooperation attribute, by performing 10^6 simulations in each different settings (i.e. different values of benefit, cost and different types of networks). They then examine in how many of these simulations the cooperation attribute has fixated. They demonstrate that $\\frac{b}{c}&gt; k$ is a necessary condition (albeit not sufficient) for cooperation to be favoured by natural selection.

In this project, I do not have time nor resources to run multiple 10^6 simulation for different conditions. Therefore, I decided to explore how networks can be used for evolutionary game theory games, by writing my own simulation, and building an interactive tool to visualize it.

Moreover, I will ran 100 rounds of my simulations on different graphs, to see if the $\\frac{b}{c}&gt; k$ rule seems to hold.

``` r
library(igraph)
library(shiny)
library(knitr)
library(ggplot2)
library(gridExtra)
source("./functions.R")
set.seed(1993)
```

### Developing the simulation

To develop this simulation I wrote several functions that I describe below. The code can be found in this repository in functions.R.

-   assignType() : this function picks a random individual in the network an assignes it the attribute of cooperator "C", and it assignes "D", defector, to all others.

-   assignColor() : for visualization purposes. Assignes vertex color red to defectors and blue to cooperators.
-   nodeFit() : this function assigns "fitness" to each node. This characterstic is based on whether the node is a cooperator or a defector, and on the charactersitics of its neighbours. Specifically,
	
	__Fitness__ = 1- w- (benf*i - cost*k)*w.   
	__benf__ = benefit gained from being neighbour to some cooperators.   
	__cost__ = cost lost from helping neighbours by being a cooperators.   
	__i__ = number of cooperatoring neighbours. 
	__k__ = number of neighbours.  
	__w__ : determines whether we are under strong selection (one attribute is largely better than another, in which case w=1), or under weak selection 	(the fitness increase from one
	attribute rather than the other is small, in which case w<<1).  	


-   netFit() : assign fitness to whole network, node by node.

-   deathBirth() : death Birth updating for one node. See below for more on death Birth Updating.
-   netUpdate() : death birth through whole network
-   simDistCoop() : this function simulates deathBirth for the whole network multiple times. It then calculates, for each simulation, the percentage of cooperators at the end of the evolutionary process. It returns an array with percentage of cooperators in each of the simulations.

### The process : Death-Birth updating

To simulate evolution of a population, I developed a simulation to replicate a Death-Birth updating on a Network. In a death-birth network update, one individual is chosen at random to die at time t=1. Hence, its neighbouring nodes compete for its spot. This can be immagined as a race between two groups: the cooperators and the defectors. Who wins the race is determined by a probabilistic function that takes into account the overall fitness of each group

In this case, I define the probability of a cooperator winning to be:

Pc = F_c/(F\_c + F\_d)

as defined in Outhsuki et al. (2006).
where:

F_c : fitness of neighbouring cooperators
F_d : fitness of neighbouring defectors

I conducted this preliminary investigations under weak selection, as advised in Outhsuki et al. (2006), although it would be interesting to examine the strong selection case.

In the image below, we can visualize the death-Birth update in a network that starts with 6 cooperators and 4 defectors, and eventually turns in a full-cooperators population.

![image](https://github.com/apstanet2017/apstanet17-biabbiassago/blob/master/images/example.gif)

#### What is happening? Visualizing in a Shiny App

In this Shiny App, we explore the netUpdate() function in different networks with 20 nodes each. User can define benefit and cost, and chose among 4 different sample networks.

link to app: <https://biabbiassago.shinyapps.io/finalProject/>

Screenshot for github document: ![image](https://github.com/apstanet2017/apstanet17-biabbiassago/blob/master/images/appscreenshot.png)

The code to create the app is in the files server.R and ui.R in this directory.

### Simulations on bigger networks

I then plan to test the simulations on larger networks, with 100 nodes, and examine the distribution in Since these simulations are computationally heave and require around 1h each, in the interest of time, I present here the results only for the Cycle. I test under conditions of *b*/*c* &gt; *k* and *b*/*c* &lt; *k*

#### On circle k = 2

``` r
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
```

``` r
#100 simulations
fracCircle_1 = simDistCoop(sampleCircle,benf = benf_1, cost = cost_1,100,500)
fracCircle_2 = simDistCoop(sampleCircle2,benf= benf_2, cost = cost_2, 100, 500)

z.test(mean(fracCircle_1), mean(fracCircle_2), alternative = "greater",mu = 0)
 confIntCircle_1= c(mean(fracCircle_1)-1.96*sd(fracCircle_1)/sqrt(n),mean(fracCircle_1)+1.96*sd(fracCircle_1)/sqrt(n))
 confIntCircle_2 =c(mean(fracCircle_2)-1.96*sd(fracCircle_2)/sqrt(n),mean(fracCircle_2)+1.96*sd(fracCircle_2)/sqrt(n))
 
par(mfrow = c(1,2))
histCircle1 = qplot(fracCircle_1,bins = 30, main="Fraction of Cooperators in 100 Simulations, b/c=20",xlab="fraction of Cooperators",geom="histogram") + theme_minimal()
histCircle2 = qplot(fracCircle_2,bins = 30, main="Fraction of Cooperators in 100 Simulations, b/c=1",xlab="fraction of Cooperators",geom="histogram") + theme_minimal()

grid.arrange(histCircle1,histCircle2)
```

![image](https://github.com/apstanet2017/apstanet17-biabbiassago/blob/master/images/histCircles.png)

Although the histograms appear to be very similar, we can test for difference in mean percentage of cooperators. We obtain that the mean percentage of cooperators in the simulated networks is statistically larger when the benefit/cost ratio is larger (non overlapping 95% confidence intervals).

``` r
#values are hard coded cause I don't have time to re-run simulation in creating markdown.
# but i want pretty table :)

lower = c(0.111,0.091)
mean = c(0.120,0.098)
upper = c(0.129,0.105)
min = c(0.01,0.01)
max = c(0.28,0.21)


resultsCircle = data.frame(lower,mean,upper,min,max) 
colnames(resultsCircle) = c("95% CI l.b.","mean","95% CI u.b.","min","max")
rownames(resultsCircle) = c("b/c = 20", "b/c = 1")
kable(resultsCircle, caption= "Comparison of mean % of cooperators for different benefit-cost ratios")
```

|          |  95% CI l.b.|   mean|  95% CI u.b.|   min|   max|
|----------|------------:|------:|------------:|-----:|-----:|
| b/c = 20 |        0.111|  0.120|        0.129|  0.01|  0.28|
| b/c = 1  |        0.091|  0.098|        0.105|  0.01|  0.21|

#### On scale Free (represents populations well)

``` r
n = 100
#for benefit/cost > k =2
sampleScale = barabasi.game(n, directed = F)
sampleScale = assignType(sampleScale)
sampleScale = assignColor(sampleScale)
sampleScale2 = sampleScale

sampleScale = netFit(sampleScale,benf = benf_1, cost= cost_1)

#for benefit/cost < k =2
sampleScale2 = netFit(sampleScale2,benf = benf_2, cost= cost_2)
```

For now, let's see simulate only once to visualize in a Scale Free network for the two networks:

``` r
sampleScale_up = netUpdate(sampleScale, benf = benf_1, cost = cost_1, rounds = 500)
sampleScale_up = assignColor(sampleScale_up)

lay = layout.fruchterman.reingold(sampleScale)

sampleScale2_up = netUpdate(sampleScale2, benf= benf_2, cost= cost_2, rounds = 500)
sampleScale2 = assignColor(sampleScale2)
sampleScale2_up = assignColor(sampleScale_up)

lay = layout.fruchterman.reingold(sampleScale2)

par(mfrow = c(1,2))
plotScale1 = plot(sampleScale, layout= lay, vertex.label=NA, main = "b/c = 20 , before")
plotScale2 = plot(sampleScale_up,layout= lay, vertex.label=NA, main = "b/c = 20 , after")

plotScale3 = plot(sampleScale2,layout= lay, vertex.label=NA, main = "b/c = 1 , before")
plotScale4 = plot(sampleScale2,layout= lay, vertex.label=NA, main = "b/c = 1 , after")
```

![](https://github.com/apstanet2017/apstanet17-biabbiassago/blob/master/images/scalePlot.png))

**Further work to finish**

``` r
fracScale_1 = simDistCoop(sampleScale, benf = benf_1, cost = cost_1, 100,500)
fracScale_2 = simDistCoop(sampleScale2, benf = benf_2, cost = cost_2, 100,500)

par(mfrow = c(1,2))
hist(fracScale_1, freq = F)
hist(fracScale_2, freq = F)
```

#### On Lattice k =4

Repeat simulation 100 (or 1000 times)
2histograms (b/c &lt; k , b/c &gt;k)

``` r
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
```

#### On regular k = 10

Repeat simulation 100 (or 1000 times)
2histogram (b/c > k , b/c < k)

#### On monk network: smaller real network

Most evolutionary game-theory simulations are theoretical networks. Here we examine what happens if we run the simulation on the sampson's monk network.

Challenges and future work:
---------------------------

-   Need to work on lattice simulation because all nodes now have same probability right now
-   Create distributions for all different networks and observe conclusions.
-   To get a similar result to the paper would need to run a lot more times
-   What happens under strong selection conditions?
-   How does the centrality measure of the starting cooperator affect the simulations?
-   What happens under strong selection conditions?

References
----------

-   *A simple rule for the evolution of cooperation on graphs and social networks*, Ohtsuki, Hauert,Liberman, Nowak, Nature **441**, 502-505, 2006

-   *Crowds, and Markets: Reasoning about a Highly Connected World* By David Easley and Jon Kleinberg. Cambridge University Press, 2010.

-   *Social games in Social networks*, Abramson, Kuperman.

-   *Evolutionary instability of zero-determinant strategies demonstrates that winning is not everything*, Adami, Hintze, Nature Communications,**4**,2013

-   Nowak, M. A. & Sigmund, K. Evolution of indirect reciprocity. Nature 437, 1291–1298 (2005)

-   Killingback, T. & Doebeli, M. Spatial evolutionary game theory: Hawks and Doves revisited. Proc. R. Soc. Lond. B 263, 1135–1144 (1996)

-   Tutorial on building Shiny App : <http://rstudio.github.io/shiny/tutorial/>
