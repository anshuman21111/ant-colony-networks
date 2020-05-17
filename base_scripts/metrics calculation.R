#calculating metrics
library(dplyr)

#betweenness
Antbetween=list()
for(i in 1:6){
  X11=paste("Colony", i, sep = "")
  print(X11)
  A=betweenness(Antgr[[X11]][[1]], v = V(Antgr[[X11]][[1]]), directed = FALSE, nobigint = TRUE, normalized = FALSE)
  X2=cbind(as.character(names(A)), as.numeric(A))
  colnames(X2)=c("AntID", "Day1")
  X2=as.data.frame(X2)
  for (j in 2:41) {
    A=betweenness(Antgr[[X11]][[j]], v = V(Antgr[[X11]][[j]]), directed = FALSE, nobigint = TRUE, normalized = FALSE)
    X3=cbind(as.character(names(A)), as.numeric(A))
    X3=as.data.frame(X3)
    colnames(X3)=c("AntID", paste("Day", j, sep = ""))
    X2=left_join(as.data.frame(X2), as.data.frame(X3), by="AntID")
    print(dim(X2))
  }
  Antbetween[[X11]]=X2
  
  X3= paste("~/Downloads/Ants/betweenness/Colony",i,".csv",sep="")
  write.csv(X2, file=X3)
}

#Strength
Antstrength=list()
for(i in 1:6){
  X11=paste("Colony", i, sep = "")
  print(X11)
  A=strength(Antgr[[X11]][[1]], vids = V(Antgr[[X11]][[1]]), loops = TRUE)
  X2=cbind(as.character(names(A)), as.numeric(A))
  colnames(X2)=c("AntID", "Day1")
  X2=as.data.frame(X2)
  for (j in 2:41) {
    A=strength(Antgr[[X11]][[j]], vids = V(Antgr[[X11]][[j]]), loops = TRUE)
    X3=cbind(as.character(names(A)), as.numeric(A))
    X3=as.data.frame(X3)
    colnames(X3)=c("AntID", paste("Day", j, sep = ""))
    X2=left_join(as.data.frame(X2), as.data.frame(X3), by="AntID")
    print(dim(X2))
  }
  Antstrength[[X11]]=X2
  
  X3= paste("~/Downloads/Ants/strength/Colony",i,".csv",sep="")
  write.csv(X2, file=X3)
}


#Bridge betweenness
namelist=c("Bridge Strength","Bridge Betweenness", "Bridge Closeness", "Bridge Expected Influence (1-step)", "Bridge Expected Influence (2-step)")
library(networktools)
nodea=list()
for(i in 1:6){
  X11=paste("Colony", i, sep = "")
  print(X11)
  communities00 = Antgr[[X11]][[1]] %>% cluster_louvain(weights = NULL)
  A00= bridge(Antgr[[X11]][[1]], communities00, useCommunities = "all",directed = NULL, nodes = NULL, normalize = FALSE)
  for (j in 2:41) {
    communities = Antgr[[X11]][[j]] %>% cluster_louvain(weights = NULL)
    A= bridge(Antgr[[X11]][[j]], communities, useCommunities = "all",directed = NULL, nodes = NULL, normalize = FALSE)
    
    for (k in 1:5) {
      A00i=A00[k]
      Ai=A[k]
      namef=paste("A00i$`", namelist[k],"`", sep="")
      X2=cbind(as.character(names(A00i$namelist[k])), as.numeric(A00i))
      colnames(X2)=c("AntID", "Day1")
      X2=as.data.frame(X2)
      X3=cbind(as.character(names(Ai)), as.numeric(Ai))
      X3=as.data.frame(X3)
      colnames(X3)=c("AntID", paste("Day", j, sep = ""))
      nodea[[k]]=left_join(as.data.frame(X2), as.data.frame(X3), by="AntID")
      #print(dim(X2))
    }
    
  }
  
  
}

X3= paste("~/Downloads/Ants/bridge_properties/",namelist[k],"/Colony",i,".csv",sep="")
write.csv(nodea[[k]], file=X3)



