library(igraph)
#install.packages("animation")
library(animation)
source("./functions.R")

edgelist=matrix(c(1,2,1,3,2,4,3,5,4,5,2,7,5,7,6,7,5,6,6,9,5,8,8,10),ncol = 2,byrow = T)


g1=graph_from_edgelist(edgelist,directed=F)
V(g1)$type = c(rep("C",6),rep("D",4))
g1 = assignColor(g1)

g2=graph_from_edgelist(edgelist,directed = F)
V(g2)$type=c(rep("C",6),"U",rep("D",3))
g2 = assignColor(g2)

g3=graph_from_edgelist(edgelist,directed=F)
V(g3)$type=c(rep("C",7),rep("D",3))
g3 = assignColor(g3)

g4=graph_from_edgelist(edgelist,directed = F)
V(g4)$type=c(rep("C",7),"U",rep("D",2))
g4 = assignColor(g4)

g5=graph_from_edgelist(edgelist,directed=F)
V(g5)$type=c(rep("C",8),rep("D",2))
g5 = assignColor(g5)

g6=graph_from_edgelist(edgelist,directed = F)
V(g6)$type=c(rep("C",8),"U",rep("D",1))
g6 = assignColor(g6)

g7=graph_from_edgelist(edgelist,directed=F)
V(g7)$type=c(rep("C",9),rep("D",1))
g7 = assignColor(g7)

g8=graph_from_edgelist(edgelist,directed = F)
V(g8)$type=c(rep("C",9),"U")
g8 = assignColor(g8)

g9=graph_from_edgelist(edgelist,directed = F)
V(g9)$type=c(rep("C",10))
g9 = assignColor(g9)



par(mfrow=c(3,3))
lay=layout.fruchterman.reingold(g1)
png(filename="g1.png")
plot(g1,vertex.label=V(g1)$type,vertex.size=25, layout=lay)
dev.off()
png(filename="g2.png")
plot(g2,vertex.label=V(g2)$type,vertex.size=25, layout=lay)
dev.off()
png(filename="g3.png")
plot(g3,vertex.label=V(g3)$type,vertex.size=25, layout=lay)
dev.off()
png(filename="g4.png")
plot(g4,vertex.label=V(g4)$type,vertex.size=25, layout=lay)
dev.off()
png(filename="g5.png")
plot(g5,vertex.label=V(g5)$type,vertex.size=25, layout=lay)
dev.off()
png(filename="g6.png")
plot(g6,vertex.label=V(g6)$type,vertex.size=25, layout=lay)
dev.off()
png(filename="g7.png")
plot(g7,vertex.label=V(g7)$type,vertex.size=25, layout=lay)
dev.off()
png(filename="g8.png")
plot(g8,vertex.label=V(g8)$type,vertex.size=25, layout=lay)
dev.off()
png(filename="g9.png")
plot(g9,vertex.label=V(g9)$type,vertex.size=25, layout=lay)
dev.off()

system("convert *.png -delay 3 -loop 0 example.gif")
