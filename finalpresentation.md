An Introduction to the Evolution of Cooperation in Networks
================
Bianca Brusco bb1569
12/5/2017

Introduction
============

Why Evolutionary Game Theory?
-----------------------------

Under Darwin's theory of Natural selection, evolution in a population is intended as the propagation of particular genes that increase the fitness of individuals in the population. Indeed, individuals who are more fit tend to produce more offspring, so that those genes that are proportionally more represented in the population.

Many behaviours that evolve in populations however, do not depend on the single gene of the single individual, but rather on how posessing a certain behavioural characteristic increases (or decreases) the individual's fitness in its interactions with other members of the population. As a consequence, the fitness brought by a gene ( or a set of genes) should not measured in isolation, but rather in the context of the entire population that the organism is part of.

In particular, we examine the attribute "Cooperation". In this context, Cooperation is seen as a binary characteristic (either cooperator or defector) of an individual, rather than as a spectrum. We can intuitively see how Cooperation whose benefit depends on the characteristics of the population as a whole: if I am the only animal helping the population as a whole to be fed, I risk wasting a lot of energy gathering food that I will not eat, therefore decreasing my overall fitness for the benefit of my neighbours. However, if all my neighbours are cooperators, we can explore more food sources than a single individual, and as a whole, we are more likely to collect more food per individual that if we were to scavenge alone.

The evolution of cooperation in animal populations has long been subject of investigation. The fact that some animal populations cooperate seems in some way opposes Darwin's Natural Selection theory: the genes of those who benefit from the help of others while not wasting any resources if not on themselves are most likely to be passed on, as those individuals are likely to be the fittest.

One important theory in evolutionary biology that reconciled the empirical observation was developed by Hamilton in 1957 (check can't remember exactly). Hamilton argued that individuals do not only want to benefit their own fitness, but rather the fitness of individuals who share their gene pool. For example, Hamilton's theory explained why some ants spend their lives helping the Queen ant rather than focusing on reproducing. Indeed, they share more genes with their sister (Queen ant), than with their potential offspring.

In more recent years, however, the evolution of game theory has been examined through different lenses, taking a game theoretical approach. The interaction of members of a population can be seen has an "evolutionary game", in which there is a winning strategy, which not only depends on the two individual's fitness (or "payoff") but rather on the overall characteristics and fitness of the population.

Why networks?
-------------

Many evolutionary games have been modeled on fully connected population, in which all individuals interact with each other. However, this is not very representative of real population. Networks can be very valuable for the study of evolutionary games because they interaction and population structures more realistically.

Testing Evolution of Cooperation
--------------------------------

In this project, my initial aim was the results published by Outhsuki et al. in 2006. In the paper, the authors explore the evolution of cooperation in networks based on the number of neighbours that each node has. They prove that a necessary condition for cooperation to evolve is for the ratio of benefit of having cooperators as neighbours(b) over cost of helping them (c) to be larger than the number of neighbours (k). I.e $\\frac{b}{c}&gt; k$. This means: the less neighbours you interact with, the more you have to rely on them. And therefore, the more chances there are that you pick a cooperating strategy.

The authors test multiple cycles of simulation by introducing one single cooperator in a population of defectors, and observe in which cases they cooperator attribute evolves among all individuals.

They argue that if the cooperation attribute is neutral (i.e. it neither increases nor decreases fitness) then the probability of a single cooperator turning the enitre population into defectors (called "fixation probability") is of 1/N (with N, number of nodes). If the fixation probability of a single cooperator is greater than 1/N, then selection favors the emergence of cooperation.

Therefore they study the fixation probability of cooperation attribute, by performing 10^6 simulations in each different settings (i.e. different values of benefit, cost and different types of networks). They then examine in how many of these simulations the cooperation attribute has fixated. They demonstrate that _b/c > k_ is a necessary condition (albeit not sufficient) for cooperation to be favoured by Natural Selection.

In this project, I do not have time not resources to run multiple 10^6 simulation for different conditions. Therefore, I decided to explore how networks can be used for evolutionary game theory games, by writing my own simulation, and building an interactive tool to visualize it.

Moreover, I will ran 100 rounds of my simulations on different graphs, to see if the _b/c>k_ rule seems to hold.

``` r
library(igraph)
library(shiny)
source("./functions.R")
set.seed(1993)
```

Developing the simulation
-------------------------

See file functions.R for code.

To develop this simulation I wrote several functions that I describe below. The code can be found in this repository in functions.R.

-   assignType() : this function picks a random individual in the network an assignes it the attribute of cooperator "C", and it assignes "D", defector, to all others.

-   assignColor() : for visualization purposes. Assignes vertex color red to defectors and blue to cooperators.
-   nodeFit() : this function assigns "fitness" to each node. This characterstic is based on whether the node is a cooperator or a defector, and on the charactersitics of its neighbours. Specifically,
	
	__Fitness__ = 1- w- (benf*i - cost*k)*w. 
	benf = benefit gained from being neighbour to some cooperators
	cost = cost lost from helping neighbours by being a cooperators.
	i = number of cooperatoring neighbours
	k = number of neighbours.
	w : determines whether we are under strong selection (one attribute is largely better than another, in which case w=1), or under weak selection (the fitness increase from one
	attribute rather than the other is small, in which case w&lt;&lt;1).

-   netFit() : assign fitness to whole network, node by node.

-   deathBirth() : death Birth updating for one node. See below for more on death Birth Updating.
-   netUpdate() : death birth through whole network
-   simDistCoop() : this function simulates deathBirth for the whole network multiple times. It then calculates, for each simulation, the percentage of cooperators at the end of the evolutionary process. It returns an array with percentage of cooperators in each of the simulations.

The process : Death-Birth updating
----------------------------------

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

What is happening? Visualizing in a Shiny App
---------------------------------------------

In this Shiny App, we analyze the netUpdate function in different networks with 20 nodes each.

link to app:

Screenshot for github document: ![image](https://github.com/apstanet2017/apstanet17-biabbiassago/blob/master/images/appscreenshot.png)

The code to create the app is in the files server.R and ui.R in this directory.

Simulations on bigger networks
------------------------------

I then plan to test the simulations on larger networks, with 100 nodes, and examine the distribution in Since these simulations are computationally heave and require around 1h each, in the interest of time, I present here the results only for the Cycle. I test underd conditions of *b*/*c* &gt; *k* and *b*/*c* &lt; *k*

### On circle k = 2

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
#TO CACHE
fracCircle_1 = simDistCoop(sampleCircle,benf = benf_1, cost = cost_1,100,500)
fracCircle_2 = simDistCoop(sampleCircle2,benf= benf_2, cost = cost_2, 100, 500)
par(mfrow = c(1,2))
hist(fracCircle_1,freq = F)
hist(fracCircle_2, freq = F)
```

![image](https://github.com/apstanet2017/apstanet17-biabbiassago/blob/master/images/histCircles.png)

From these histograms, we don't really see a difference between the distribution of percentage of cooperators in the two cases. I plan to test what happens under strong selection to observe the results.

### On Lattice k =4

Repeat simulation 100 (or 1000 times)
2histograms (b/c &lt; k , b/c &gt;k)

### On regular k = 10

Repeat simulation 100 (or 1000 times)
2histogram (b/c &lt; k , b/c &gt;k)

### On scale Free (represents populations well)

Repeat simulation 100 (or 1000 times)
2histogram (b/c &lt; k , b/c &gt;k)

### On monk network: smaller real network

Most evolutionary game-theory simulations are theoretical networks. Here we examine what happens if we run the simulation on the sampson's monk network.

Repeat simulation 100 (or 1000 times)
2histogram (b/c &lt; k , b/c &gt;k)

Challenges and future work:
---------------------------

-   Need to work on lattice simulation because all nodes now have same probability right now
-   To get a similar result to the paper would need to run a lot more times.

References
----------

-   *A simple rule for the evolution of cooperation on graphs and social networks*, Ohtsuki, Hauert,Liberman, Nowak, Nature **441**, 502-505, 2006

-   *Crowds, and Markets: Reasoning about a Highly Connected World* By David Easley and Jon Kleinberg. Cambridge University Press, 2010.

-   *Social games in Social networks*, Abramson, Kuperman.

-   <https://stackoverflow.com/questions/17002160/shiny-tutorial-error-in-r>

-   *Evolutionary instability of zero-determinant strategies demonstrates that winning is not everything*, Adami, Hintze, Nature Communications,**4**,2013

-   Nowak, M. A. & Sigmund, K. Evolution of indirect reciprocity. Nature 437, 1291–1298 (2005)
-   Killingback, T. & Doebeli, M. Spatial evolutionary game theory: Hawks and Doves revisited. Proc. R. Soc. Lond. B 263, 1135–1144 (1996)
