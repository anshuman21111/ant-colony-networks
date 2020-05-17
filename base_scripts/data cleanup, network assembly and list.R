####colony (1,2,3,4,5,6)= (4, 18, 21, 29, 58, 78)
#

#creating a list of all adj matrices
BB=read.csv(file="~/Downloads/behavior_edited.csv")
Antall2=list()
Antgr=list()
listname=c(4,18,21,29,58,78)
for(i in 1:6)
{
  X0=paste("~/Downloads/doi_10.5061_dryad.8d8h7__v1/tracking_data/network_col",i,"_day",1,".txt",sep="")
  print(X0)
  A0=read.table(file=X0, sep = ",", header=T)
  X11=paste("Colony", i, sep = "")
  Antall2[[X11]]=list()
  Antgr[[X11]]=list()
  for (j in 1:41){
    X1=paste("~/Downloads/doi_10.5061_dryad.8d8h7__v1/tracking_data/network_col",i,"_day",j,".txt",sep="")
    A=read.table(file=X1, sep = ",", header=T)
    print(nrow(A))
    rownames(A)=colnames(A)
    
    id=which(colnames(A) %in% as.character(setdiff(unique(colnames(A0)), (unique(as.character((BB$Ant_ID[which(BB$colony==listname[i])])))))))
    
    A=A[-c(id), -c(id)]
    A=data.matrix(A)
    
    Antall2[[X11]][[j]]=A
    print(nrow(A))
    Antgr[[X11]][[j]]<-graph_from_adjacency_matrix(as.matrix(A), mode = "undirected", weighted = TRUE)
    
    
    #X3= paste("~/Downloads/Ants/revised/Colony",i,"/day",j,".csv",sep="")
    #write.csv(A, file=X3)
  }
}

#visualize sample network
graphRM=Antgr$Colony3[[14]]
V(graphRM)$frame.color <- "white"
V(graphRM)$label <- ""
V(graphRM)$color <- "orange"
V(graphRM)$size <- 10
E(graphRM)$arrow.mode <- 0

#visualize sample network community structure using Louvain
coordsRM = layout_with_fr(graphRM)
plot(graphRM, weighted=T)
print("Louvain:")
communities = graphRM %>% 
  cluster_louvain(weights = NULL)
plot(communities, graphRM, layout=coordsRM)