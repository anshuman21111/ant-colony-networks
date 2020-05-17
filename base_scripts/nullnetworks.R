#null networks

library("VertexSort")

#strength
Antsortstrength=list()
for(i in 1:6){
  set.seed(i)
  X11=paste("Colony", i, sep = "")
  print(X11)
  Antg=dpr(Antgr[[X11]][[1]], viteration_no=1000, vparallel = FALSE, vcpus = 1)
  Antgr1=Antg[[1]]
  A=strength(Antgr1, vids = V(Antgr1), loops = TRUE)
  X2=cbind(as.character(names(A)), as.numeric(A))
  colnames(X2)=c("AntID", "Day1")
  X2=as.data.frame(X2)
  for (j in 2:41) {
    Antg=dpr(Antgr[[X11]][[j]], viteration_no=1000, vparallel = FALSE, vcpus = 1)
    Antgr1=Antg[[1]]
    A=strength(Antgr1, vids = V(Antgr1), loops = TRUE)
    X3=cbind(as.character(names(A)), as.numeric(A))
    X3=as.data.frame(X3)
    colnames(X3)=c("AntID", paste("Day", j, sep = ""))
    X2=left_join(as.data.frame(X2), as.data.frame(X3), by="AntID")
    print(dim(X2))
  }
  Antsortstrength[[X11]]=X2
  
  X3= paste("~/Downloads/Ants/strength/sort/Colony",i,".csv",sep="")
  write.csv(X2, file=X3)
}

#betweenness
Antsortbetween=list()
for(i in 1:2){
  set.seed(i)
  X11=paste("Colony", i, sep = "")
  print(X11)
  Antg=dpr(Antgr[[X11]][[1]], viteration_no=1000, vparallel = FALSE, vcpus = 1)
  Antgr1=Antg[[1]]
  A=betweenness(Antgr[[X11]][[1]], v = V(Antgr[[X11]][[1]]), directed = FALSE, nobigint = TRUE, normalized = FALSE)
  X2=cbind(as.character(names(A)), as.numeric(A))
  colnames(X2)=c("AntID", "Day1")
  X2=as.data.frame(X2)
  for (j in 2:41) {
    Antg=dpr(Antgr[[X11]][[j]], viteration_no=1000, vparallel = FALSE, vcpus = 1)
    Antgr1=Antg[[1]]
    A=betweenness(Antgr[[X11]][[j]], v = V(Antgr[[X11]][[j]]), directed = FALSE, nobigint = TRUE, normalized = FALSE)
    X3=cbind(as.character(names(A)), as.numeric(A))
    X3=as.data.frame(X3)
    colnames(X3)=c("AntID", paste("Day", j, sep = ""))
    X2=left_join(as.data.frame(X2), as.data.frame(X3), by="AntID")
    print(dim(X2))
  }
  Antsortstrength[[X11]]=X2
  
  X3= paste("~/Downloads/Ants/betweenness/sort/Colony",i,".csv",sep="")
  write.csv(X2, file=X3)
}


#bridgebetweenness
Antsortbridbetween=list()
for(i in 1:2){
  set.seed(i)
  X11=paste("Colony", i, sep = "")
  print(X11)
  Antg=dpr(Antgr[[X11]][[1]], viteration_no=1000, vparallel = FALSE, vcpus = 1)
  Antgr1=Antg[[1]]
  library(networktools)
  nodea=list()
  for(i in 1:6){
    X11=paste("Colony", i, sep = "")
    print(X11)
    communities00 = Antgr[[X11]][[1]] %>% cluster_louvain(weights = NULL)
    A00= bridge(Antgr[[X11]][[1]], communities00, useCommunities = "all",directed = NULL, nodes = NULL, normalize = FALSE)

  for (j in 2:41) {
    Antg=dpr(Antgr[[X11]][[j]], viteration_no=1000, vparallel = FALSE, vcpus = 1)
    Antgr1=Antg[[1]]
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
  Antsortstrength[[X11]]=X2
  
  X3= paste("~/Downloads/Ants/betweennessbridge/sort/Colony",i,".csv",sep="")
  write.csv(X2, file=X3)
}
