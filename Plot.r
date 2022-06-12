###############
library(tibble)
library("ggplot2")
library(dplyr)

#Read in counts and metadata. 
Data = read.table("results_Count_gene.filtered.tsv", header=TRUE,sep='\t',quote="")
metadata=read.table("Metadata.tsv", header=TRUE,sep='\t')


#X an Y gene names can be the same. This makes them unique. Row is set to this unique value. 
rownames(Data)= paste(Data$Gene_name,Data$Gene_stable_ID,Data$chr,sep="$")

#Select only columns with count data. 
Data=select(Data,contains(c("COVSUBJ","batch")))

#Remove zero variance columns
Data=t(Data)[ , which(apply(t(Data), 2, var) !=0)]
#PCA
data.pca = prcomp(Data,center=TRUE,scale=TRUE)

#Make SampleID column
data.pca = tibble::rownames_to_column(as.data.frame(data.pca$x), "SampleID")
#Merge with metadata
data.pca=merge(metadata,data.pca,all.by="SampleID",all.x = TRUE,all.y=TRUE)

#Plot
ggplot(data.pca, aes(x = PC1, y = PC2, color = Study)) +
  geom_point(size =2) +
  #coord_fixed() +
  ggtitle("CombatSeq.Counts")
png("CombatSeq.Counts_Study.png")
print(p)
dev.off()

ggplot(data.pca, aes(x = PC1, y = PC2, color = Covid.Status)) +
  geom_point(size =2) +
  #coord_fixed() +
  ggtitle("CombatSeq.Counts")
png("CombatSeq.Counts_CovidStatus.png")
print(p)
dev.off()

ggplot(data.pca, aes(x = PC1, y = PC2, color = Tissue2)) +
  geom_point(size =2) +
  #coord_fixed() +
  ggtitle("CombatSeq.Counts")
png("CombatSeq.Counts_Tissue2.png")
print(p)
dev.off()

ggplot(data.pca, aes(x = PC1, y = PC2, color = RIA.Superpopulation.Inference)) +
  geom_point(size =2) +
  #coord_fixed() +
  ggtitle("CombatSeq.Counts")
png("CombatSeq.Counts_RIA.Superpopulation.Inference.png")
print(p)
dev.off()

ggplot(data.pca, aes(x = PC1, y = PC2, color = RIA.Superpopulation.Inference.GrtEq0.7)) +
  geom_point(size =2) +
  #coord_fixed() +
  ggtitle("CombatSeq.Counts")
png("CombatSeq.Counts_RIA.Superpopulation.Inference.GrtEq0.7.png")
print(p)
dev.off()

ggplot(data.pca, aes(x = PC1, y = PC2, color = Type)) +
  geom_point(size =2) +
  #coord_fixed() +
  ggtitle("CombatSeq.Counts")
png("CombatSeq.Counts_Type.png")
print(p)
dev.off()
