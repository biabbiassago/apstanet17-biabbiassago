simulation testing in small circular graph - def fitness
================
Bianca Brusco
11/27/2017

``` r
library(igraph)
library(statnet)
library(sna)
```

First of all: work on simulation by creating a 10 nodes circle graph

``` r
n = 10
testG = make_ring(n, directed=FALSE)
plot(testG)
```

![](simFit_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-1-1.png)

``` r
V(testG)$type = c("C",rep("D",n-1))
V(testG)$color = V(testG)$type
V(testG)$color=gsub("C","steel blue",V(testG)$color)
V(testG)$color=gsub("D","indian red",V(testG)$color)

V(testG)$fitness = c(rep("0",n))

#count number of cooperators (for whole network)
i = sum(V(testG)$type == "C")

#bi- ck

#assign fitness to each node based on cooperating/def neighbours
v = 0

# random values for testing
benf = 200
cost = 1

V(testG)$fitness[n]
```

    ## [1] "0"

``` r
for( v in 1:n)
{
  i = sum(neighbors(testG,v)$type == "C")
  k = length(neighbors(testG, v))
  V(testG)$fitness[v] = benf*i - cost*k

}

V(testG)$fitness
```

    ##  [1] "-2"  "198" "-2"  "-2"  "-2"  "-2"  "-2"  "-2"  "-2"  "198"

``` r
plot(testG)
```

![](simFit_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-1-2.png)
