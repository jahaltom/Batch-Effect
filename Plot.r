library(tibble)
library("ggplot2")
library(dplyr)
library(DESeq2)

Plot=function(matrix){
ggplot(matrix, aes(x = PC1, y = PC2, color = Study, shape=Study)) +
  geom_point(size =2) +
  #coord_fixed() +
  ggtitle("CombatSeq.Counts")

ggsave("CombatSeq.Counts_Study.png")


ggplot(matrix, aes(x = PC1, y = PC2, color = Covid.Status, shape=Study)) +
  geom_point(size =2) +
  #coord_fixed() +
  ggtitle("CombatSeq.Counts")
ggsave("CombatSeq.Counts_CovidStatus.png")


ggplot(matrix, aes(x = PC1, y = PC2, color = Tissue, shape=Study)) +
  geom_point(size =2) +
  #coord_fixed() +
  ggtitle("CombatSeq.Counts")
ggsave("CombatSeq.Counts_Tissue.png")


ggplot(matrix, aes(x = PC1, y = PC2, color = RIA.Superpopulation.Inference, shape=Study)) +
  geom_point(size =2) +
  #coord_fixed() +
  ggtitle("CombatSeq.Counts")
ggsave("CombatSeq.Counts_RIA.Superpopulation.Inference.png")

ggplot(matrix, aes(x = PC1, y = PC2, color = RIA.Superpopulation.Inference.Admix	, shape=Study)) +
  geom_point(size =2) +
  #coord_fixed() +
  ggtitle("CombatSeq.Counts")
ggsave("CombatSeq.Counts_RIA.Superpopulation.Inference.Admix.png")

ggplot(matrix, aes(x = PC1, y = PC2, color = Covid.Transcript.Level, shape=Study)) +
  geom_point(size =2) +
  #coord_fixed() +
  ggtitle("CombatSeq.Counts")
ggsave("CombatSeq.Counts_Covid.Transcript.Level.png")


ggplot(matrix, aes(x = PC1, y = PC2, color = TissueSpecific, shape=Study)) +
  geom_point(size =2) +
  #coord_fixed() +
  ggtitle("CombatSeq.Counts")
ggsave("CombatSeq.Counts_TissueSpecific.png")
}



#Read in counts and metadata. 
Data = read.table("CombatSeq.Counts.tsv", header=TRUE,sep='\t',quote="")
metadata=read.table("Metadata.tsv", header=TRUE,sep='\t')

#For results_Count_gene.filtered.tsv results_TPM_gene.filtered.tsv
tryCatch({
  #X an Y gene names can be the same. This makes them unique. Row is set to this unique value. 
  rownames(Data)= paste(Data$Gene_name,Data$Gene_stable_ID,Data$chr,sep="$")
  #Select only columns with count data. 
  Data=select(Data,contains(c("COVSUBJ","batch")))},error = function(e){})









#Remove zero variance columns
#Data=t(Data)[ , which(apply(t(Data), 2, var) !=0)]

#DESeq2 transformation/normalization
dds= DESeqDataSetFromMatrix(countData=Data, colData = metadata, design = ~1)
vsd=vst(dds,fitType='local')
pca_vsd_dds=plotPCA(vsd, returnData=T, intgroup=c("SampleID"))
pca_vsd_dds=merge(metadata,pca_vsd_dds,all.by="SampleID",all.x = TRUE,all.y=TRUE)
Plot(pca_vsd_dds)



#PCA R
#Data=assay(vsd)
#data.pca = prcomp(Data,center=TRUE,scale=TRUE)
##Make SampleID column
#data.pca = tibble::rownames_to_column(as.data.frame(data.pca$rotation), "SampleID")
##Merge with metadata
#data.pca=merge(metadata,data.pca,all.by="SampleID",all.x = TRUE,all.y=TRUE)
#Plot(data.pca)






