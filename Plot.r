###############
library(tibble)
library("ggplot2")
#Read in count and metadata. 
Data = read.table("DESeq_TPM.tsv", header=TRUE,sep='\t')
Design=read.table("Metadata.tsv", header=TRUE,sep='\t')
#Remove zero variance columns
Data=t(Data)[ , which(apply(t(Data), 2, var) !=0)]
#PCA
data.pca = prcomp(Data,center=TRUE,scale=TRUE)


#Make SampleID column
data.pca <- tibble::rownames_to_column(as.data.frame(data.pca$x), "SampleID")

data.pca=merge(Design,data.pca,all.by="SampleID",all.x = TRUE,all.y=TRUE)


ggplot(data.pca, aes(x = PC1, y = PC2, color = Study)) +
  geom_point(size =2) +
  #coord_fixed() +
  ggtitle("Autopsy Nasal ComBat-Seq")
