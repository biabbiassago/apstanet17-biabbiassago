__APSTANET 17 Final Project__    
__Bianca Brusco bb1569__


# Using Networks to study the Evolution of Cooperation

The goal of this project is to understand how we can use networks as population models in an evolutionary game theory context.
In this repo I keep working files. 

__Read : finalpresentation.md for complete project.__


### Part 1: 

Create a simulation that replicates the evolution process as described in *A simple rule for the evolution of cooperation on graphs and social networks*, Ohtsuki, Hauert,Liberman, Nowak, Nature **441**, 502-505, 2006.  

	- file : gifdemo.R for visual representation of the process. 
	- file : functions.R for functions used in simulation. 

### Part 2

Represent the generational evolution for a network of 20 nodes, and visualize. To do so, I created a Shiny App in which the process can be explored in four different types of networks.   
  
	- Shiny App: https://biabbiassago.shinyapps.io/cooperationsim/.   
	- file : server.R for 'back-end' of the app.  
	- file: ui.R for 'front-end' of the app.  

### Part 3

In this part, I simulate 100 net-update processes at 9 different levels of b/c, from 0 to 9. I use at sample small world network with 20 nodes.  I test what happens after 1 and 2 generations. I repeat for both weak selection and strong selection. 

	- file: simulations.R. 
	- folder : simfiles containing the four .csv files with 100 simulations,  \
	for 1 and 2 generations, under weak and strong selection. 
	
	
__Other files in this folder__

Files used for prenstation of the project. The final presentation includes background on the topic that might be helpful to readers with no previous knowledge of evolutionary game theory.   

	- proppresentation.pdf = presentation with initial project proposal.   
	- finalpresentation.md = final markdown file presenting project's results. 


	
